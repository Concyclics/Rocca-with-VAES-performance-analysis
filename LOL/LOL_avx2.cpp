#include <immintrin.h>

const __m128i LOLMINI_C = _mm_setr_epi16(0x35c9, 0x952b, 0xd4b1, 0x4ab5, 0xa291, 0x7eed, 0xa31b, 0x7ca1);
const __m128i LOLMINI_SIGMA = _mm_setr_epi8(2, 3, 4, 5, 14, 15, 8, 9, 12, 13, 6, 7, 0, 1, 10, 11);

const __m128i ZERO128 = _mm_setzero_si128();

const __m256i LOLDOUBLE_C = _mm256_setr_epi16(0x35c9, 0x952b, 0xd4b1, 0x4ab5, 0xa291, 0x7eed, 0xa31b, 0x7ca1,
                                               0xc553, 0x7dc5, 0xd83, 0xb2eb, 0xd52f, 0x9fb7, 0x44e1, 0xf069);

const __m256i LOLDOUBLE_SHUFFLE0 = _mm256_setr_epi8(6, 7, 0xff, 0xff, 10, 11, 2, 3, 0xff, 0xff, 0xff, 0xff, 14, 15, 8, 9, 
                                                     2, 3, 0xff, 0xff, 0, 1, 0xff, 0xff, 12, 13, 14, 15, 0xff, 0xff, 6, 7);
const __m256i LOLDOUBLE_SHUFFLE1 = _mm256_setr_epi8(0xff, 0xff, 0, 1, 0xff, 0xff, 4, 5, 0xff, 0xff, 0xff, 0xff, 12, 13, 
                                                     0xff, 0xff, 0xff, 0xff, 8, 9, 0xff, 0xff, 0xff, 0xff, 10, 11, 4, 5, 
                                                     0xff, 0xff, 0xff, 0xff);
#define shuffle256(x) _mm256_xor_si256(_mm256_shuffle_epi8((x), LOLDOUBLE_SHUFFLE0), \
                                        _mm256_permute4x64_epi64(_mm256_shuffle_epi8((x), LOLDOUBLE_SHUFFLE1), 0x4e))

const __m256i ZERO256 = _mm256_setzero_si256();

// LOL-MINI
struct Lolmini
{
    __m128i hi, lo, nfsr, state[3];

    inline __m128i keystream(void)
    {
        // Keystream Bits
        __m128i intermediate = _mm_aesenc_si128(state[2], ZERO128);
        __m128i z = _mm_xor_si128(intermediate, nfsr);

        // N Update
        nfsr = _mm_aesenc_si128(nfsr, lo);

        // LFSR Update
        __m128i mulx = _mm_xor_si128(_mm_slli_epi16(hi, 1), _mm_and_si128(LOLMINI_C, _mm_srai_epi16(hi, 15)));
        __m128i oddOld = hi;
        hi = _mm_xor_si128(mulx, _mm_shuffle_epi8(lo, LOLMINI_SIGMA));
        lo = oddOld;

        // FSM Update
        state[2] = _mm_aesenc_si128(state[1], state[2]);
        state[1] = _mm_aesenc_si128(state[0], state[1]);
        state[0] = _mm_xor_si128(_mm_xor_si128(hi, intermediate), state[0]);
        return z;
    }

    inline void keyiv_setup(const unsigned char *key, const unsigned char *iv)
    {
        __m128i mainKey[2];
        state[0] = _mm_loadu_si128((__m128i *)iv);
        state[1] = mainKey[0] = _mm_loadu_si128((__m128i *)(key + 16));
        state[2] = mainKey[1] = _mm_loadu_si128((__m128i *)key);
        nfsr = hi = lo = ZERO128;

        for (int i = 0; i < 12; ++i)
        {
            __m128i output = keystream();
            nfsr = _mm_xor_si128(nfsr, output);
            hi = _mm_xor_si128(hi, output);
        }
        state[0] = _mm_xor_si128(state[0], mainKey[0]);
        hi = _mm_xor_si128(hi, mainKey[1]);
    }
};

// LOL-DOUBLE
struct Loldouble
{
    __m256i hi, lo;
    __m128i state[4];
    __m128i nfsr[2];

    inline __m256i keystream(void)
    {
        // Keystream bits
        __m128i tmp1 = _mm_aesenc_si128(state[1], ZERO128);
        __m128i tmp3 = _mm_aesenc_si128(state[3], ZERO128);
        __m128i z0 = _mm_xor_si128(tmp1, nfsr[0]);
        __m128i z1 = _mm_xor_si128(tmp3, nfsr[1]);

        // N update
        nfsr[0] = _mm_aesenc_si128(nfsr[0], _mm256_castsi256_si128(lo));
        nfsr[1] = _mm_aesenc_si128(nfsr[1], _mm256_extracti128_si256(lo, 1));

        // LFSR Update
        __m256i mulx = _mm256_xor_si256(_mm256_slli_epi16(hi, 1), _mm256_and_si256(LOLDOUBLE_C, _mm256_srai_epi16(hi, 15)));
        __m256i oddOld = hi;
        hi = _mm256_xor_si256(shuffle256(lo), mulx);
        lo = oddOld;

        // FSM Update
        state[1] = _mm_aesenc_si128(state[0], state[1]);
        state[0] = _mm_xor_si128(_mm_xor_si128(tmp3, state[0]), _mm256_castsi256_si128(hi));
        state[3] = _mm_aesenc_si128(state[2], state[3]);
        state[2] = _mm_xor_si128(_mm_xor_si128(tmp1, state[2]), _mm256_extracti128_si256(hi, 1));
        return _mm256_set_m128i(z0, z1);
    }

    inline void keyiv_setup(const unsigned char *key, const unsigned char *iv)
    {
        __m256i mainKey = _mm256_loadu_si256((__m256i *)key);
        hi = lo = ZERO256;
        nfsr[0] = nfsr[1] = ZERO128;
        state[2] = _mm256_castsi256_si128(mainKey);
        state[3] = _mm256_extracti128_si256(mainKey, 1);
        state[0] = _mm_load_si128((__m128i *)iv);
        state[1] = _mm_load_si128((__m128i *)(iv + 16));
        for (int i = 0; i < 12; ++i)
        {
            __m256i output = keystream();
            hi = _mm256_xor_si256(hi, output);
            nfsr[0] = _mm_xor_si128(nfsr[0], _mm256_castsi256_si128(output));
            nfsr[1] = _mm_xor_si128(nfsr[1], _mm256_extracti128_si256(output, 1));
        }
        hi = _mm256_xor_si256(hi, mainKey);
    }
};

#define repeat 65536 * 64

double test_speed_lol_mini(int len)
{
    Lolmini ctx;
    unsigned char key[32], iv[16];
    for (int i = 0; i < 32; i++)
    {
        key[i] = rand() % 256;
    }
    for (int i = 0; i < 16; i++)
    {
        iv[i] = rand() % 256;
    }
    ctx.keyiv_setup(key, iv);

    unsigned char *message = (unsigned char *)malloc(len);
    unsigned char *ciphertext = (unsigned char *)malloc(len);

    for (int i = 0; i < len; i++)
    {
        message[i] = rand() % 256;
    }

    time_t start, end;
    __m128i M, C, Z;
    start = clock();
    for (int i = 0; i < repeat; i++)
    {
        for (int j = 0; j < len; j++)
        {
            M = _mm_loadu_si128((__m128i *)(message + j));
            Z = ctx.keystream();
            C = _mm_xor_si128(M, Z);
            _mm_storeu_si128((__m128i *)(ciphertext + j), C);
        }
    }
    end = clock();
    float seconds = (float)(end - start) / CLOCKS_PER_SEC;
    float gbps = 1.0 * len * repeat * 8 / seconds / 1e9;
    free(message);
    free(ciphertext);
    return gbps;
}

double test_speed_lol_double(int len)
{
    Loldouble ctx;
    unsigned char key[32], iv[32];
    for (int i = 0; i < 32; i++)
    {
        key[i] = rand() % 256;
    }
    for (int i = 0; i < 32; i++)
    {
        iv[i] = rand() % 256;
    }
    ctx.keyiv_setup(key, iv);
    
    unsigned char *message = (unsigned char *)malloc(len);
    unsigned char *ciphertext = (unsigned char *)malloc(len);

    for (int i = 0; i < len; i++)
    {
        message[i] = rand() % 256;
    }

    time_t start, end;
    __m256i M, C, Z;
    start = clock();
    for (int i = 0; i < repeat; i++)
    {
        for (int j = 0; j < len; j += 32)
        {
            M = _mm256_loadu_si256((__m256i *)(message + j));
            Z = ctx.keystream();
            C = _mm256_xor_si256(M, Z);
            _mm256_storeu_si256((__m256i *)(ciphertext + j), C);
        }
    }
    end = clock();
    float seconds = (float)(end - start) / CLOCKS_PER_SEC;
    float gbps = 1.0 * len * repeat * 8 / seconds / 1e9;
    free(message);
    free(ciphertext);
    return gbps;
}

int main(int argc, char *argv[])
{
    int test_cases[] = {16384, 8192, 1024, 256, 64};
    int test_cases_len = sizeof(test_cases) / sizeof(int);
    printf("LOL-MINI\n");
    for (int i = 0; i < test_cases_len; i++)
    {
        printf("Speed for %d bytes: %.2f Gbps\n", test_cases[i], test_speed_lol_mini(test_cases[i]));
    }
    printf("LOL-DOUBLE\n");
    for (int i = 0; i < test_cases_len; i++)
    {
        printf("Speed for %d bytes: %.2f Gbps\n", test_cases[i], test_speed_lol_double(test_cases[i]));
    }
    return 0;
}
