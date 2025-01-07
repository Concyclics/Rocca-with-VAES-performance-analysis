#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "snow-v.h"

#define SIZE 1024*10*1024
# define XOR(a , b ) _mm_xor_si128(a, b)
# define AND(a , b ) _mm_and_si128(a , b )
# define ADD(a , b ) _mm_add_epi32(a , b )
# define SET(v) _mm_set1_epi16(( short ) v )
# define SLL(a) _mm_slli_epi16(a , 1)
# define SRA( a ) _mm_srai_epi16(a , 15)
# define TAP7( Hi , Lo ) _mm_alignr_epi8( Hi , Lo , 7 * 2)
# define SIGMA(a ) _mm_shuffle_epi8(a , _mm_set_epi64x(0x0f0b07030e0a0602ULL, 0x0d0905010c080400ULL));
# define AESR(a , k ) _mm_aesenc_si128(a , k )
# define ZERO() _mm_setzero_si128()
# define LOAD(src) _mm_loadu_si128(( const __m128i *) ( src ) )
#define STORE(dst, x) _mm_storeu_si128(( __m128i *)(dst) , x)

//--------------Snow-5G----------------------------------- 
__m128i A0 , A1 , B0 , B1 ; // LFSR
__m128i R1 , R2 , R3 ; // FSMR
__m128i snow_keystream(void){ 
    // Taps
    __m128i T1 = B1 , T2 = A1 ;
    // LFSR - A / B
    A1 = _mm_xor_si128(_mm_xor_si128(_mm_xor_si128(TAP7(A1 , A0), B0), SLL(A0)), AND(SET(0x4a6d), SRA(A0)));
    B1 = _mm_xor_si128(_mm_xor_si128(SLL(B0), A0), _mm_xor_si128(B1, AND(SET(0xcc87), SRA(B0))));
    A0 = T2;
    B0 = T1;
    // Keystream word
    __m128i z = _mm_xor_si128(R2, ADD(R1, T1));
    // FSM Update
    T2 = ADD(_mm_xor_si128(T2, R3), R2);
    R3 = AESR(R2, ZERO());
    R2 = AESR(R1, ZERO());
    R1 = T2;
    return z ;
}
void snow_keyiv_setup(const unsigned char *key, const unsigned char *iv){ 
    B0 = R1 = R2 = R3 = ZERO();
    A0 = LOAD(iv);
    A1 = LOAD(key);
    B1 = LOAD(key + 16);
    B0 = LOAD(" AlexEkd JingThom ");
    for(int i = 0; i < 15; ++ i){
        A1 = _mm_xor_si128(A1, snow_keystream());
        R1 = _mm_xor_si128(R1, LOAD(key));
        A1 = _mm_xor_si128(A1, snow_keystream());
        R1 = _mm_xor_si128(R1, LOAD(key + 16));
    }
}

void snow5g(uint8_t *pt, uint8_t *key, uint8_t *ct, size_t len) {
    unsigned char iv[16] = {0};
    snow_keyiv_setup(key, iv);
    size_t l = len;
    for (int i = 0; i < l/16; ++i) {
        __m128i tmp = _mm_loadu_si128((__m128i*) (pt + 16*i));
        __m128i c = _mm_xor_si128(tmp, snow_keystream());
        _mm_storeu_si128((__m128i*)(ct + 16*i), c);
    }
}


void gfmul(__m128i a, __m128i b, __m128i *res)
{
    const __m128i MASK = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);

    __m128i a1 = _mm_shuffle_epi8(a, MASK);
    __m128i b1 = _mm_shuffle_epi8(b, MASK);

    __m128i T0, T1, T2, T3, T4, T5;

    T0 = _mm_clmulepi64_si128(a1, b1, 0x00);
    T1 = _mm_clmulepi64_si128(a1, b1, 0x01);
    T2 = _mm_clmulepi64_si128(a1, b1, 0x10);
    T3 = _mm_clmulepi64_si128(a1, b1, 0x11);

    T1 = _mm_xor_si128(T1, T2);
    T2 = _mm_slli_si128(T1, 8);
    T1 = _mm_srli_si128(T1, 8);
    T0 = _mm_xor_si128(T0, T2);
    T3 = _mm_xor_si128(T3, T1);

    T4 = _mm_srli_epi32(T0, 31);
    T0 = _mm_slli_epi32(T0, 1);

    T5 = _mm_srli_epi32(T3, 31);
    T3 = _mm_slli_epi32(T3, 1);

    T2 = _mm_srli_si128(T4, 12);
    T5 = _mm_slli_si128(T5, 4);
    T4 = _mm_slli_si128(T4, 4);
    T0 = _mm_or_si128(T0, T4);
    T3 = _mm_or_si128(T3, T5);
    T3 = _mm_or_si128(T3, T2);

    T4 = _mm_slli_epi32(T0, 31);
    T5 = _mm_slli_epi32(T0, 30);
    T2 = _mm_slli_epi32(T0, 25);

    T4 = _mm_xor_si128(T4, T5);
    T4 = _mm_xor_si128(T4, T2);
    T5 = _mm_srli_si128(T4, 4);
    T3 = _mm_xor_si128(T3, T5);
    T4 = _mm_slli_si128(T4, 12);
    T0 = _mm_xor_si128(T0, T4);
    T3 = _mm_xor_si128(T3, T0);

    T4 = _mm_srli_epi32(T0, 1);
    T1 = _mm_srli_epi32(T0, 2);
    T2 = _mm_srli_epi32(T0, 7);
    T3 = _mm_xor_si128(T3, T1);
    T3 = _mm_xor_si128(T3, T2);
    T3 = _mm_xor_si128(T3, T4);

    T3 = _mm_shuffle_epi8(T3, MASK);

    *res = T3;
}
void snow5g_aead_encrypt(uint8_t *pt, uint8_t *key, uint8_t *ct, uint8_t *ad, uint8_t *tag, size_t len) {
    __m128i H = snow_keystream();
    size_t lenad = 48;
    __m128i X = _mm_setzero_si128();
    for (int i = 0; i < lenad/16; i++) {
        __m128i tmp0 = _mm_loadu_si128((__m128i *) (ad + 16*i));
        X = _mm_xor_si128(X, tmp0);
        gfmul(X, H, &X);
    }

    size_t l = len;
    for (int i = 0; i < l/16; ++i) {
        __m128i tmp = _mm_loadu_si128((__m128i*) (pt + 16*i));
        __m128i c = _mm_xor_si128(tmp, snow_keystream());
        _mm_storeu_si128((__m128i*)(ct + i*16), c);
        X = _mm_xor_si128(X, c);
        gfmul(X, H, &X);
    }
    __m128i conc = _mm_setzero_si128();
    conc = _mm_insert_epi64(conc, (int64_t)l*8, 0);
    conc = _mm_insert_epi64(conc, (int64_t)lenad*8, 1);
    X = _mm_xor_si128(X, conc);
    gfmul(X, H, &X);
    STORE(tag, X);

}

void snow5g_aead_decrypt(uint8_t *pt, uint8_t *key, uint8_t *ct, uint8_t *ad, uint8_t *tag, uint8_t *val, size_t len) {
    __m128i H = snow_keystream();
    size_t lenad = 48;
    __m128i X = _mm_setzero_si128();
    for (int i = 0; i < lenad/16; i++) {
        __m128i tmp0 = _mm_loadu_si128((__m128i *) (ad + 16*i));
        X = _mm_xor_si128(X, tmp0);
        gfmul(X, H, &X);
    }

    size_t l = len;
    for (int i = 0; i < l/16; ++i) {
        __m128i tmp = _mm_loadu_si128((__m128i*) (ct + 16*i));
        __m128i c = _mm_xor_si128(tmp, snow_keystream());
        _mm_storeu_si128((__m128i*)(pt + i*16), c);
        X = _mm_xor_si128(X, tmp);
        gfmul(X, H, &X);
    }
    __m128i conc = _mm_setzero_si128();
    conc = _mm_insert_epi64(conc, (int64_t)l*8, 0);
    conc = _mm_insert_epi64(conc, (int64_t)lenad*8, 1);
    X = _mm_xor_si128(X, conc);
    gfmul(X, H, &X);
    uint8_t *tag2 = (uint8_t *)&X;
    *val = !memcmp(tag, tag2, 16);

}
