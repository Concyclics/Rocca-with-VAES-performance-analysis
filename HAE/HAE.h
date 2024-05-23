/******************************************************************************
    Copyright (C), 2024-2054, Huawei Tech. Co., Ltd.
*******************************************************************************
    Author        : CHEN Han (50038340)
    Created       : 2024/05/23
    Last Modified : 2024/05/23
    Description   : HAE encryption algorithm designed for Kunpeng processor
                    The design intake instruction fusion feature of Kunpeng 920 
                    as well as unroll optimization in encryption for better speed
                    speed for encryption can reach 52Gbps on Kunpeng 920@2.6GHz
                    speed for encryption can reach 129Gbps on Intel-Skylake@4GHz


******************************************************************************/

#ifndef __HAE__ALGO__
#define __HAE__ALGO__

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#if defined(__AES__) && defined(__x86_64__)

#include <immintrin.h>
#include <wmmintrin.h>

typedef __m128i DATA128b;

#define load(x) _mm_loadu_si128((const __m128i *)(x))
#define store(x, y) _mm_storeu_si128((__m128i *)(x), y)
#define xor(x, y) _mm_xor_si128(x, y)
#define zero128() _mm_setzero_si128()
//#define aesdimc(a, RoundKey) vaesimcq_u8(vaesdq_u8(a, RoundKey))
//#define aesdimc(a, RoundKey) vaesdq_u8(vaesimcq_u8(a), RoundKey)
#define aesemc(x, y) _mm_aesenc_si128(xor(x, y), zero128())
#define aesdimc(x, y) _mm_aesdeclast_si128(xor(x, y), zero128())
#define aesenc(x, y) _mm_aesenc_si128(x, y)

#elif defined(__ARM_FEATURE_AES) && defined(__ARM_NEON)

#include <arm_neon.h>

typedef uint8x16_t DATA128b;

#define aesemc(a, RoundKey) vaesmcq_u8(vaeseq_u8(a, RoundKey))
//#define aesdimc(a, RoundKey) vaesimcq_u8(vaesdq_u8(a, RoundKey))
//#define aesdimc(a, RoundKey) vaesdq_u8(vaesimcq_u8(a), RoundKey)
#define aesdimc(a, RoundKey) vaesdq_u8(a, RoundKey)
#define xor(a, b) veorq_u8(a, b)
#define load(x) vld1q_u8(x)
#define store(dst, x) vst1q_u8(dst, x)

#else

#error This_Arch_do_not_Supported_yet_!!!

#endif

/**
 * state initial for HAE
 *
 * INPUT:
 * @param key 256bit: 32 * 8
 * @param iv 128bit: 16 * 8
 * OUTPUT:
 * @param state 2048bit: 16 * 128
 */
void HAE_stream_init(DATA128b* state, 
    const uint8_t* key,
    const uint8_t* iv
);
/**
 * process ad for HAE
 *
 * INPUT:
 * @param state 2048bit: 16 * 128
 * @param len length of ad (byte)
 * OUTPUT:
 * @param ad a byte array for ad
 */
void HAE_stream_proc_ad(DATA128b* state, 
    const uint8_t* ad, 
    size_t len
);
/**
 * finalize to get tag for HAE
 *
 * INPUT:
 * @param state 2048bit: 16 * 128
 * @param ad_len length of ad (byte)
 * @param plain_len length of message(byte)
 * OUTPUT:
 * @param tag 128bit: 16 * 8
 */
void HAE_stream_finalize(DATA128b* state,
    uint64_t ad_len, 
    uint64_t plain_len,
    uint8_t* tag
);
/**
 * encryption for HAE
 *
 * INPUT:
 * @param state 2048bit: 16 * 128
 * @param size length of message(byte)
 * @param src a byte array for message
 * OUTPUT:
 * @param dst a byte array for cipher
 */
void HAE_stream_encrypt(DATA128b* state,
    uint8_t* dst, 
    const uint8_t* src,
    size_t size
);

void HAE_stream_decrypt(DATA128b* state,
    uint8_t* dst, 
    const uint8_t* src,
    size_t size
);

void HAE(uint8_t* key, 
    uint8_t* iv, 
    uint8_t* plain, 
    uint8_t* cipher, 
    uint8_t* ad, 
    uint8_t* tag);

#endif
