#include <stdint.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
typedef struct Context
{
    __m512i state[8]; // state
    size_t sizeM;     // byte length of input data
    size_t sizeAD;    // byte length of associated data
} context;
#define S_NUM 8
#define M_NUM 2
#define BLKSIZE 128
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

#define XOR_1 0
#define XOR_2 2
#define XOR_3 11
#define XOR_4 1
#define XOR_5 3
#define XOR_6 4
#define XOR_7 15
#define XOR_8 12

#define zero128() _mm_setzero_si128()
#define zero256() _mm256_setzero_si256()
#define zero512() _mm512_setzero_si512()

#define loadu128(x) _mm_loadu_si128((const __m128i *)(x))
#define loadu256(x) _mm256_loadu_si256((const __m256i *)(x))
#define loadu512(x) _mm512_loadu_si512((const __m512i *)(x))
#define storeu128(x, y) _mm_storeu_si128((__m128i *)(x), y)
#define storeu256(x, y) _mm256_storeu_si256((__m256i *)(x), y)
#define storeu512(x, y) _mm512_storeu_si512((__m512i *)(x), y)

#define xor128(x, y) _mm_xor_si128(x, y)
#define xor256(x, y) _mm256_xor_si256(x, y)
#define xor512(x, y) _mm512_xor_si512(x, y)

#define aesemc128(x) _mm_aesemc_si128(x, zero128())
#define aesdimc128(x) _mm_aesdimc_si128(x, zero128())
#define aesenc128(x, y) _mm_aesenc_si128(x, y)
#ifdef VAES
#define aesemc256(x) _mm256_aesemc_epi128(x, zero256())
#define aesemc512(x) _mm512_aesemc_epi128(x, zero512())
#define aesdimc256(x) _mm256_aesdec_epi128(x, zero256())
#define aesdimc512(x) _mm512_aesdec_epi128(x, zero512())
#define aesenc256(x, y) _mm256_aesenc_epi128(x, y)
#define aesenc512(x, y) _mm512_aesenc_epi128(x, y)
#else
// do 2 or 4 128-bit AES encryption and combine the results
#define aesemc256(x) \
    __m128i x0 = _mm256_castsi256_si128(x); \
    __m128i x1 = _mm256_extracti128_si256(x, 1); \
    x0 = aesemc128(x0); \
    x1 = aesemc128(x1); \
    x = _mm256_inserti128_si256(x, x0, 0); \
    x = _mm256_inserti128_si256(x, x1, 1);
#define aesemc512(x) \
    __m256i x0 = _mm512_castsi512_si128(x); \
    __m256i x1 = _mm512_extracti32x8_epi32(x, 1); \
    __m256i x2 = _mm512_extracti32x8_epi32(x, 2); \
    __m256i x3 = _mm512_extracti32x8_epi32(x, 3); \
    x0 = aesemc128(x0); \
    x1 = aesemc128(x1); \
    x2 = aesemc128(x2); \
    x3 = aesemc128(x3); \
    x = _mm512_inserti32x8(x, x0, 0); \
    x = _mm512_inserti32x8(x, x1, 1); \
    x = _mm512_inserti32x8(x, x2, 2); \
    x = _mm512_inserti32x8(x, x3, 3);
#define aesdimc256(x) \
    __m128i x0 = _mm256_castsi256_si128(x); \
    __m128i x1 = _mm256_extracti128_si256(x, 1); \
    x0 = aesdimc128(x0); \
    x1 = aesdimc128(x1); \
    x = _mm256_inserti128_si256(x, x0, 0); \
    x = _mm256_inserti128_si256(x, x1, 1);
#define aesdimc512(x) \
    __m256i x0 = _mm512_castsi512_si128(x); \
    __m256i x1 = _mm512_extracti32x8_epi32(x, 1); \
    __m256i x2 = _mm512_extracti32x8_epi32(x, 2); \
    __m256i x3 = _mm512_extracti32x8_epi32(x, 3); \
    x0 = aesdimc128(x0); \
    x1 = aesdimc128(x1); \
    x2 = aesdimc128(x2); \
    x3 = aesdimc128(x3); \
    x = _mm512_inserti32x8(x, x0, 0); \
    x = _mm512_inserti32x8(x, x1, 1); \
    x = _mm512_inserti32x8(x, x2, 2); \
    x = _mm512_inserti32x8(x, x3, 3);
#define aesenc256(x, y) \
    __m128i x0 = _mm256_castsi256_si128(x); \
    __m128i x1 = _mm256_extracti128_si256(x, 1); \
    __m128i y0 = _mm256_castsi256_si128(y); \
    __m128i y1 = _mm256_extracti128_si256(y, 1); \
    x0 = aesenc128(x0, y0); \
    x1 = aesenc128(x1, y1); \
    x = _mm256_inserti128_si256(x, x0, 0); \
    x = _mm256_inserti128_si256(x, x1, 1);
#define aesenc512(x, y) \
    __m256i x0 = _mm512_castsi512_si128(x); \
    __m256i x1 = _mm512_extracti32x8_epi32(x, 1); \
    __m256i x2 = _mm512_extracti32x8_epi32(x, 2); \
    __m256i x3 = _mm512_extracti32x8_epi32(x, 3); \
    __m256i y0 = _mm512_castsi512_si128(y); \
    __m256i y1 = _mm512_extracti32x8_epi32(y, 1); \
    __m256i y2 = _mm512_extracti32x8_epi32(y, 2); \
    __m256i y3 = _mm512_extracti32x8_epi32(y, 3); \
    x0 = aesenc128(x0, y0); \
    x1 = aesenc128(x1, y1); \
    x2 = aesenc128(x2, y2); \
    x3 = aesenc128(x3, y3); \
    x = _mm512_inserti32x8(x, x0, 0); \
    x = _mm512_inserti32x8(x, x1, 1); \
    x = _mm512_inserti32x8(x, x2, 2); \
    x = _mm512_inserti32x8(x, x3, 3);
#endif

#define LOAD_4STEP(src) \
    M[0] = loadu256(src); \
    M[1] = loadu256(src + 32);

#define XOR_4STEP_OFFSET(offset) \
    tmp[0] = xor256(S[XOR_1+2*offset], 

#define MM256_ENC_4STEP_OFFSET(M, offset) \


void stream_init(context *ctx, const uint8_t *key,
                 const uint8_t *nonce)
{
    __m512i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Initialize intenal state
    S[0] = _mm512_loadu_si512((const __m512i *)(key + 64));
    S[1] = _mm512_loadu_si512((const __m512i *)(nonce));
    S[2] = _mm512_set_epi32(Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3);
    S[3] = _mm512_set_epi32(Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3);
    S[4] = _mm512_set_epi32(Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3);
    S[5] = _mm512_set_epi32(Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3);
    S[6] = _mm512_set_epi32(Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3, Z0_0, Z0_1, Z0_2, Z0_3);
    S[7] = _mm512_set_epi32(Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3, Z1_0, Z1_1, Z1_2, Z1_3);
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
    __m512i S[S_NUM], M[M_NUM], tmp7, tmp6;
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
    __m512i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
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
    __m512i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
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
    __m512i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // set M [0] to bit length of processed AD
    // set M [1] to bit length of processed M
    M[0] = CAST_U64_TO_M512(ctx -> sizeAD * 8);
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
    _mm512_storeu_si512((__m512i *)(tag), S[0]);
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
    uint8_t *tag = (uint8_t *)malloc(64);

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
    for (int i = 0; i < 64; i++)
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