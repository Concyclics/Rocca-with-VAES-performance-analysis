# Rocca with VAES performance analysis

## Paper

* [Rocca: An Efficient AES-based Encryption Scheme for Beyond 5G (Full version) (iacr.org)](https://eprint.iacr.org/2022/116)

## Test settings

### system configuration

* CPU: AMD Ryzen 9 7950X @ 5GHz
* Compiler: Intel(R) oneAPI DPC++/C++ Compiler 2023.2.0 (2023.2.0.20230622)

#### AES instructions performance of Zen4

| instruction     | unit  | Latency | Throughput |
| --------------- | ----- | ------- | ---------- |
| AESENC(128bit)  | FP0/1 | 4       | 2          |
| VAESENC(256bit) | FP0/1 | 4       | 2          |
| VAESENC(512bit) | FP0/1 | 4       | 1          |

### Rocca  configuration

* rocca: 8*128 state with AES(128)
* rocca_256: 4*256 state with VAES(256)
* rocca_256_16: 8*256 state with VAES(256)

### compile command

```bash
icx -Ofast -march=native -maes -mvaes rocca.c -o rocca
icx -Ofast -march=native -maes -mvaes rocca_256.c -o rocca_256
icx -Ofast -march=native -maes -mvaes rocca_256_16.c -o rocca_256_16
```

### test command

```bash
perf stat -d -d -d  -r 10 ./rocca 4096
perf stat -d -d -d  -r 10 ./rocca_256 4096
perf stat -d -d -d  -r 10 ./rocca_256_16 4096
```

### test result

#### speed

| config       | speed(Gbps) |
| ------------ | ----------- |
| rocca        | 330         |
| rocca_256    | 295         |
| rocca_256_16 | 690         |

#### Conclusion

rocca_256, 4*256 states only take (2+1) VAES instructions, but the latency is 4 cycles, so the gap can hardly filled. So rocca_256 has an IPC < 1, while rocca and rocca_256_16, (4+2) AES/VAES can run with an IPC > 2, which fits the throughput of AES/VAES instructions. If we want to involve VAES, the instructions in each round should not decrease, so the state and cipher length should be double.

#### perf stat profile

##### rocca perf

```bash
Performance counter stats for './rocca 4096' (10 runs):

           1668.98 msec task-clock                #    1.000 CPUs utilized            ( +-  0.70% )
                 3      context-switches          #    0.002 K/sec                    ( +- 13.07% )
                 0      cpu-migrations            #    0.000 K/sec                  
                76      page-faults               #    0.045 K/sec                    ( +-  0.46% )
        8693646115      cycles                    #    5.209 GHz                      ( +-  0.28% )  (39.32%)
           1877033      stalled-cycles-frontend   #    0.02% frontend cycles idle     ( +-  8.89% )  (39.63%)
           1969715      stalled-cycles-backend    #    0.02% backend cycles idle      ( +- 11.12% )  (39.93%)
       18228989534      instructions              #    2.10  insn per cycle         
                                                  #    0.00  stalled cycles per insn  ( +-  0.10% )  (40.18%)
         336759813      branches                  #  201.776 M/sec                    ( +-  0.13% )  (40.43%)
             66931      branch-misses             #    0.02% of all branches          ( +-  3.36% )  (40.73%)
        4313370452      L1-dcache-loads           # 2584.441 M/sec                    ( +-  0.20% )  (40.80%)
            234306      L1-dcache-load-misses     #    0.01% of all L1-dcache hits    ( +- 16.72% )  (40.56%)
   <not supported>      LLC-loads                                                   
   <not supported>      LLC-load-misses                                             
           1384946      L1-icache-loads           #    0.830 M/sec                    ( +-  6.01% )  (40.29%)
             22776      L1-icache-load-misses     #    1.64% of all L1-icache hits    ( +-  3.43% )  (40.06%)
             22572      dTLB-loads                #    0.014 M/sec                    ( +-  4.45% )  (39.89%)
              6377      dTLB-load-misses          #   28.25% of all dTLB cache hits   ( +- 12.50% )  (39.77%)
             11512      iTLB-loads                #    0.007 M/sec                    ( +-  3.70% )  (39.64%)
              4293      iTLB-load-misses          #   37.29% of all iTLB cache hits   ( +- 13.01% )  (39.50%)
            158442      L1-dcache-prefetches      #    0.095 M/sec                    ( +- 29.82% )  (39.28%)
   <not supported>      L1-dcache-prefetch-misses                                   

            1.6692 +- 0.0117 seconds time elapsed  ( +-  0.70% )
```

##### rocca_256 perf

```bash
Performance counter stats for './rocca_256 4096' (10 runs):

           1858.92 msec task-clock                #    1.000 CPUs utilized            ( +-  0.29% )
                 3      context-switches          #    0.002 K/sec                    ( +- 10.38% )
                 0      cpu-migrations            #    0.000 K/sec                    ( +- 66.67% )
                75      page-faults               #    0.040 K/sec                    ( +-  0.42% )
        9779750286      cycles                    #    5.261 GHz                      ( +-  0.04% )  (39.06%)
           1874049      stalled-cycles-frontend   #    0.02% frontend cycles idle     ( +-  7.95% )  (39.60%)
           1676679      stalled-cycles-backend    #    0.02% backend cycles idle      ( +-  9.00% )  (40.13%)
        9631575876      instructions              #    0.98  insn per cycle         
                                                  #    0.00  stalled cycles per insn  ( +-  0.07% )  (40.64%)
         336892360      branches                  #  181.230 M/sec                    ( +-  0.07% )  (41.01%)
             76946      branch-misses             #    0.02% of all branches          ( +-  2.89% )  (41.34%)
        2146446886      L1-dcache-loads           # 1154.676 M/sec                    ( +-  0.06% )  (41.34%)
            303858      L1-dcache-load-misses     #    0.01% of all L1-dcache hits    ( +-  6.79% )  (41.01%)
   <not supported>      LLC-loads                                                   
   <not supported>      LLC-load-misses                                             
           1531076      L1-icache-loads           #    0.824 M/sec                    ( +-  2.24% )  (40.50%)
             25733      L1-icache-load-misses     #    1.68% of all L1-icache hits    ( +-  2.21% )  (40.00%)
             26019      dTLB-loads                #    0.014 M/sec                    ( +-  5.02% )  (39.62%)
              7975      dTLB-load-misses          #   30.65% of all dTLB cache hits   ( +- 13.81% )  (39.29%)
             13412      iTLB-loads                #    0.007 M/sec                    ( +-  2.58% )  (38.97%)
              4068      iTLB-load-misses          #   30.33% of all iTLB cache hits   ( +- 16.06% )  (38.76%)
            127162      L1-dcache-prefetches      #    0.068 M/sec                    ( +-  9.74% )  (38.73%)
   <not supported>      L1-dcache-prefetch-misses                                   

           1.85918 +- 0.00547 seconds time elapsed  ( +-  0.29% )
```

##### rocca_256_16 perf

```bash
 Performance counter stats for './rocca_256_16 4096' (10 runs):

            790.03 msec task-clock                #    1.000 CPUs utilized            ( +-  0.56% )
                 2      context-switches          #    0.002 K/sec                    ( +-  9.45% )
                 0      cpu-migrations            #    0.000 K/sec                    ( +-100.00% )
                76      page-faults               #    0.096 K/sec                    ( +-  0.48% )
        4114117656      cycles                    #    5.208 GHz                      ( +-  0.07% )  (38.78%)
           1144303      stalled-cycles-frontend   #    0.03% frontend cycles idle     ( +-  6.08% )  (40.04%)
            849301      stalled-cycles-backend    #    0.02% backend cycles idle      ( +- 10.26% )  (41.31%)
        9209352536      instructions              #    2.24  insn per cycle         
                                                  #    0.00  stalled cycles per insn  ( +-  0.09% )  (42.08%)
         202764774      branches                  #  256.653 M/sec                    ( +-  0.10% )  (42.61%)
             44922      branch-misses             #    0.02% of all branches          ( +-  0.80% )  (42.93%)
        3223194346      L1-dcache-loads           # 4079.816 M/sec                    ( +-  0.08% )  (42.24%)
            100557      L1-dcache-load-misses     #    0.00% of all L1-dcache hits    ( +- 11.23% )  (40.97%)
   <not supported>      LLC-loads                                                   
   <not supported>      LLC-load-misses                                             
            727151      L1-icache-loads           #    0.920 M/sec                    ( +-  2.73% )  (39.71%)
             11519      L1-icache-load-misses     #    1.58% of all L1-icache hits    ( +-  4.46% )  (38.94%)
             10923      dTLB-loads                #    0.014 M/sec                    ( +-  6.98% )  (38.40%)
              2462      dTLB-load-misses          #   22.54% of all dTLB cache hits   ( +- 17.14% )  (38.08%)
              5631      iTLB-loads                #    0.007 M/sec                    ( +-  3.41% )  (37.97%)
              1458      iTLB-load-misses          #   25.89% of all iTLB cache hits   ( +- 16.80% )  (37.97%)
             45109      L1-dcache-prefetches      #    0.057 M/sec                    ( +- 18.04% )  (37.97%)
   <not supported>      L1-dcache-prefetch-misses                                   

           0.79028 +- 0.00446 seconds time elapsed  ( +-  0.56% )
```



## Appendix: codes

### Rocca 8 state with  AES128

```c
#include <stdint.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
typedef struct Context
{
    __m128i state[8]; // state
    size_t sizeM;     // byte length of input data
    size_t sizeAD;    // byte length of associated data
} context;
#define S_NUM 8
#define M_NUM 2
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
#define enc(m, k) _mm_aesenc_si128(m, k)
#define xor(a, b) _mm_xor_si128(a, b)
#define UPDATE_STATE(X) \
    tmp7 = S[7];            \
    tmp6 = S[6];            \
    S[7] = xor(S[6], S[0]); \
    S[6] = enc(S[5], S[4]); \
    S[5] = enc(S[4], S[3]); \
    S[4] = xor(S[3], X[1]); \
    S[3] = enc(S[2], S[1]); \
    S[2] = xor(S[1], tmp6); \
    S[1] = enc(S[0], tmp7); \
    S[0] = xor(tmp7, X[0]);
#define LOAD(src, dst) \
        dst[0] = _mm_loadu_si128((const __m128i *)((src))); \
        dst[1] = _mm_loadu_si128((const __m128i *)((src) + 16));
#define XOR_STRM(src, dst) \
        dst[0] = xor(src[0], enc(S[1], S[5])); \
    dst[1] = xor(src[1], enc(xor(S[0], S[4]), S[2]));
#define STORE(src, dst) \
        _mm_storeu_si128((__m128i *)((dst)), src[0]); \
    _mm_storeu_si128((__m128i *)((dst) + 16), src[1]);
#define CAST_U64_TO_M128(v) \
    _mm_set_epi32(0, 0, (((uint64_t)(v)) >> 32) & 0xFFFFFFFF, \
                  (((uint64_t)(v)) >> 0) & 0xFFFFFFFF)

void stream_init(context *ctx, const uint8_t *key,
                 const uint8_t *nonce)
{
    __m128i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Initialize intenal state
    S[0] = _mm_loadu_si128((const __m128i *)(key + 16));
    S[1] = _mm_loadu_si128((const __m128i *)(nonce));
    S[2] = _mm_set_epi32(Z0_3, Z0_2, Z0_1, Z0_0);
    S[3] = _mm_set_epi32(Z1_3, Z1_2, Z1_1, Z1_0);
    S[4] = _mm_xor_si128(S[1], S[0]);
    S[5] = _mm_setzero_si128();
    S[6] = _mm_loadu_si128((const __m128i *)(key));
    S[7] = _mm_setzero_si128();
    M[0] = S[2];
    M[1] = S[3];
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
    __m128i S[S_NUM], M[M_NUM], tmp7, tmp6;
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
    __m128i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
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
    __m128i S[S_NUM], M[M_NUM], C[M_NUM], tmp7, tmp6;
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
    __m128i S[S_NUM], M[M_NUM], tmp7, tmp6;
    // Copy state from context
    for (size_t i = 0; i < S_NUM; ++i)
    {
        S[i] = ctx -> state[i];
    }
    // set M [0] to bit length of processed AD
    // set M [1] to bit length of processed M
    M[0] = CAST_U64_TO_M128((uint64_t)ctx -> sizeAD << 3);
    M[1] = CAST_U64_TO_M128((uint64_t)ctx -> sizeM << 3);
    // Update internal state
    for (size_t i = 0; i < NUM_LOOP_FOR_INIT; ++i)
    {
        UPDATE_STATE(M)
    }
    // Generate tag by XORing all S [ i ] s
    for (size_t i = 1; i < S_NUM; ++i)
    {
        S[0] = _mm_xor_si128(S[0], S[i]);
    }
    // Output tag
    _mm_store_si128((__m128i *)tag, S[0]);
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
    uint8_t *tag = (uint8_t *)malloc(16);

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
    for (int i = 0; i < 16; i++)
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
```

### Rocca 8 state with VAES 256

```c
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
```

### Rocca 16 state with VAES 256

```c
#include <stdint.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
typedef struct Context
{
    __m256i state[8]; // state
    size_t sizeM;     // byte length of input data
    size_t sizeAD;    // byte length of associated data
} context;
#define S_NUM 8
#define M_NUM 2
#define BLKSIZE 64
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
    tmp7 = S[7];            \
    tmp6 = S[6];            \
    S[7] = xor(S[6], S[0]); \
    S[6] = enc(S[5], S[4]); \
    S[5] = enc(S[4], S[3]); \
    S[4] = xor(S[3], X[1]); \
    S[3] = enc(S[2], S[1]); \
    S[2] = xor(S[1], tmp6); \
    S[1] = enc(S[0], tmp7); \
    S[0] = xor(tmp7, X[0]);
#define LOAD(src, dst) \
        dst[0] = _mm256_loadu_epi8((const __m256i *)((src))); \
        dst[1] = _mm256_loadu_epi8((const __m256i *)((src) + 32));
#define XOR_STRM(src, dst) \
        dst[0] = xor(src[0], enc(xor(S[0], S[2]), S[1])); \
        dst[1] = xor(src[1], enc(S[1], S[3]));
#define STORE(src, dst) \
        _mm256_storeu_epi8((__m256i *)((dst)), src[0]); \
        _mm256_storeu_epi8((__m256i *)((dst) + 32), src[1]);
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
    S[4] = _mm256_set_epi32(0, 0, 0, 0, Z0_3, Z0_2, Z0_1, Z0_0);
    S[5] = _mm256_set_epi32(0, 0, 0, 0, Z1_3, Z1_2, Z1_1, Z1_0);
    S[6] = _mm256_set_epi32(0, 0, 0, 0, Z0_3, Z0_2, Z0_1, Z0_0);
    S[7] = _mm256_set_epi32(0, 0, 0, 0, Z1_3, Z1_2, Z1_1, Z1_0);
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
```

