#include <emmintrin.h>
#include <immintrin.h>
#include <smmintrin.h>
#include <wmmintrin.h>

const __m256i lol_shu16 = _mm256_set_epi8(23, 22, 13, 12, 31, 30, 29, 28, 5, 4, 17, 16, 1, 0, 19, 18,
                                           69, 8, 15, 14, 21, 20, 27, 26, 3, 2, 11, 10, 25, 24, 7, 6);
const __m256i ZERO256 = _mm256_setzero_si256();

#define LFSR_DOUBLE(H, L) \
{ F = _mm256_xor_si256(_mm256_slli_epi16(H, 1), _mm256_and_si256(lol_mul16, _mm256_srai_epi16(H, 15))); \
  F = _mm256_xor_si256(_mm256_permutexvar_epi8(lol_shu16, L), F); \
  L = H; \
  H = F; }

#define AES_ENC_256(C, M) C = _mm256_aesenc_epi128(M, ZERO256);
#define AES_ENC_KEY_256(C, M, R) C = _mm256_aesenc_epi128(M, R);

struct LOL_DOUBLE
{
    __m256i F, H, L, G, S0, S1, Z, N;
    
    inline __m256i keystream(void)
    {
        AES_ENC_256(G, S1);
        Z = _mm256_xor_si256(G, N);
        
        AES_ENC_KEY_256(N, N, L);
        LFSR_DOUBLE(H, L);
        
        AES_ENC_KEY_256(S1, S0, S1);
        S0 = _mm256_xor_si256(S0, _mm256_xor_si256(H, _mm256_permute4x64_epi64(G, 0x4e)));
        
        Z = _mm256_permute4x64_epi64(Z, 0x4e);
        return Z;
    }
    
    inline void keyiv_setup(const unsigned char *key, const unsigned char *iv)
    {
        S1 = _mm256_loadu_si256((__m256i *)key);
        S0 = _mm256_loadu_si256((__m256i *)iv);
        
        S1 = _mm256_permute2x128_si256(S0, S1, 0x31);
        S0 = _mm256_permute2x128_si256(S0, S1, 0x20);
        
        // round 1
        AES_ENC_256(G, S1);
        Z = _mm256_permute4x64_epi64(G, 0x4e);
        
        AES_ENC_KEY_256(N, ZERO256, Z);
        L = ZERO256;
        H = Z;
        
        AES_ENC_KEY_256(S1, S0, S1);
        S0 = _mm256_xor_si256(S0, Z);
        
        // rounds 2-12
        for (int i = 0; i < 11; i++)
        {
            AES_ENC_256(G, S1);
            Z = _mm256_xor_si256(G, N);
            Z = _mm256_permute4x64_epi64(Z, 0x4e);
            
            AES_ENC_KEY_256(N, N, L);
            N = _mm256_xor_si256(N, Z);
            
            LFSR_DOUBLE(H, L);
            
            AES_ENC_KEY_256(S1, S0, S1);
            S0 = _mm256_xor_si256(S0, _mm256_xor_si256(H, _mm256_permute4x64_epi64(G, 0x4e)));
            
            H = _mm256_xor_si256(H, Z);
        }
        
        // reload
        H = _mm256_xor_si256(H, _mm256_loadu_si256((__m256i *)key));
    }
};
