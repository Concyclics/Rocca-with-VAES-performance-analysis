#include <stdint.h>
#include <stdio.h>
#include <string.h>
//#include <wmmintrin.h>  //for intrinsics AES-NI
#include <time.h>
#if defined(__AES__) && defined(__x86_64__)
#include <immintrin.h>
#include <wmmintrin.h>
#elif defined(__ARM_FEATURE_CRYPTO) && defined(__ARM_NEON)
#include <arm_neon.h>
#include "sse2neon.h"
#endif

void snow5g(uint8_t *pt, uint8_t *key, uint8_t *ct, size_t len);

void snow5g_aead_encrypt(uint8_t *pt, uint8_t *key, uint8_t *ct, uint8_t *ad, uint8_t *tag, size_t len);

void snow5g_aead_decrypt(uint8_t *pt, uint8_t *key, uint8_t *ct, uint8_t *ad, uint8_t *tag, uint8_t *val, size_t len);
