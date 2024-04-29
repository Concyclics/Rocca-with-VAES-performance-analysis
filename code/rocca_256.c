#include <stdint.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
typedef struct Context
{
    __m256i state[4]; // state
    size_t sizeM;     // byte length of input data
    size_t sizeAD;    // byte length of associated data
} context;
#define S_NUM 4
#define M_NUM 1
#define BLKSIZE 32
#define NUM_LOOP_FOR_INIT 20
// Z0 = 428 a2f98d728ae227137449123ef65cd
#define Z0_3 0x428a2f98
#define Z0_2 0xd728ae22
#define Z0_1 0x71374491
#define Z0_0 0x23ef65cd
// Z1 = b5c0fbcfec4d3b2fe9b5dba58189dbbc
#define Z1_3 0xb5c0fbcf
#define Z1_2 0xec4d3b2f
#define Z1_1 0xe9b5dba5
#define Z1_0 0x8189dbbc
#define enc(m, k) _mm256_aesdec_epi128(m, k)
#define xor(a, b) _mm256_xor_si256(a, b)
#define UPDATE_STATE(X) \
    tmp7 = S[3];            \
    S[3] = xor(S[2], S[0]); \
    S[2] = enc(S[1], S[0]); \
    S[1] = enc(S[0], S[3]); \
    S[0] = xor(S[3], X[0]);
#define LOAD(src, dst) \
        dst[0] = _mm256_loadu_epi8((const __m256i *)((src))); 
        //dst[1] = _mm256_loadu_epi8((const __m256i *)((src) + 32));
#define XOR_STRM(src, dst) \
        dst[0] = xor(src[0], enc(xor(S[0], S[2]), S[1])); 
        //dst[1] = xor(src[1], enc(S[1], S[3]));
#define STORE(src, dst) \
        _mm256_storeu_epi8((__m256i *)((dst)), src[0]); 
        //_mm256_storeu_epi8((__m256i *)((dst) + 32), src[1]);
#define CAST_U64_TO_M256(v) \
    _mm256_set_epi32(0, 0, 0, 0, 0, 0, (((uint64_t)(v)) >> 32) & 0xFFFFFFFF, \
                   (((uint64_t)(v)) >> 0) & 0xFFFFFFFF)

void stream_init(context *ctx, const uint8_t *key,
                 const uint8_t *nonce)
{
    __m256i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Initialize intenal state
    S[0] = _mm256_loadu_si256((const __m256i *)(key + 32));
    S[1] = _mm256_loadu_si256((const __m256i *)(nonce));
    S[2] = _mm256_set_epi32(0, 0, 0, 0, Z0_3, Z0_2, Z0_1, Z0_0);
    S[3] = _mm256_set_epi32(0, 0, 0, 0, Z1_3, Z1_2, Z1_1, Z1_0);
    // Update local state
    for (size_t i = 0; i < NUM_LOOP_FOR_INIT; ++i)
    {
        UPDATE_STATE(M)
    }
    // Update context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        ctx -> state[i] = S[i];
    }
    ctx -> sizeM = 0;
    ctx -> sizeAD = 0;
}
size_t stream_proc_ad(context *ctx, const uint8_t *ad,
                      size_t size)
{
    __m256i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // Update local state with associated data
    size_t proc_size = 0;
    for (size_t size2 = size / BLKSIZE * BLKSIZE;
         proc_size < size2; proc_size += BLKSIZE)
    {
        LOAD(ad + proc_size, M);
        UPDATE_STATE(M);
    }
    // Update context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        ctx -> state[i] = S[i];
    }
    ctx -> sizeAD += proc_size;
    return proc_size;
}

size_t stream_enc(context *ctx, uint8_t *dst, const uint8_t *src,
                  size_t size)
{
    __m256i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // Generate and output ciphertext
    // Update internal state with plaintext
    size_t proc_size = 0;
    for (size_t size2 = size / BLKSIZE * BLKSIZE;
         proc_size < size2; proc_size += BLKSIZE)
    {
        LOAD(src + proc_size, M);
        XOR_STRM(M, C);
        STORE(C, dst + proc_size);
        UPDATE_STATE(M);
    }
    // Update context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        ctx -> state[i] = S[i];
    }
    ctx -> sizeM += proc_size;
    return proc_size;
}
size_t stream_dec(context *ctx, uint8_t *dst, const uint8_t *src,
                  size_t size)
{
    __m256i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // Generate and output plaintext
    // Update internal state with plaintext
    size_t proc_size = 0;
    for (size_t size2 = size / BLKSIZE * BLKSIZE;
         proc_size < size2; proc_size += BLKSIZE)
    {
        LOAD(src + proc_size, C);
        XOR_STRM(C, M);
        STORE(M, dst + proc_size);
        UPDATE_STATE(M);
    }
    // Update context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        ctx -> state[i] = S[i];
    }
    ctx -> sizeM += proc_size;
    return proc_size;
}

void stream_finalize(context *ctx, uint8_t *tag)
{
    __m256i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // set M [0] to bit length of processed AD
    // set M [1] to bit length of processed M
    M[0] = CAST_U64_TO_M256((uint64_t)ctx -> sizeAD << 3);
    // Update internal state
    for (size_t i = 0; i < NUM_LOOP_FOR_INIT; ++i)
    {
        UPDATE_STATE(M)
    }
    // Generate tag by XORing all S [ i ] s
    for (size_t i = 1; i < S_NUM; ++i)
    {
        S[0] = xor(S[0], S[i]);
    }
    // Output tag
    _mm256_storeu_si256((__m256i *)(tag), S[0]);
}

int main(int argc, char *argv[])
{
    int message_len = atoi(argv[1]);
    int ad_len = 32;

    uint8_t *key = (uint8_t *)malloc(32);
    uint8_t *nonce = (uint8_t *)malloc(16);
    uint8_t *ad = (uint8_t *)malloc(ad_len);
    uint8_t *message = (uint8_t *)malloc(message_len);
    uint8_t *ciphertext = (uint8_t *)malloc(message_len);
    uint8_t *tag = (uint8_t *)malloc(32);

    srand(time(0));
    for (int i = 0; i < 32; i++)
    {
        key[i] = rand() % 256;
    }

    for (int i = 0; i < 16; i++)
    {
        nonce[i] = rand() % 256;
    }

    for (int i = 0; i < ad_len; i++)
    {
        ad[i] = rand() % 256;
    }

    for (int i = 0; i < message_len; i++)
    {
        message[i] = rand() % 256;
    }

    time_t start, end;
    #define repeat 16777216
    start = clock();

    context ctx;
    stream_init( & ctx, key, nonce);
    stream_proc_ad( & ctx, ad, ad_len);
    for (int i = 0; i < repeat; i++)
    {
        stream_enc( & ctx, ciphertext, message, message_len);
    }
    stream_finalize( & ctx, tag);
    end = clock();

    printf("Key: ");
    for (int i = 0; i < 32; i++)
    {
        printf("%02x", key[i]);
    }
    printf("\n");
    printf("Tag: ");
    for (int i = 0; i < 32; i++)
    {
        printf("%02x", tag[i]);
    }
    printf("\n");
    float seconds = (float)(end - start) / CLOCKS_PER_SEC;
    float gbps = 1.0 * message_len * repeat * 8 / seconds / 1e9;
    printf("Time: %f\n", seconds);
    printf("Throughput: %.2f Gbps\n", gbps);
    free(key);
    free(nonce);
    free(ad);
    free(message);
    free(ciphertext);
    free(tag);

    return 0;
}