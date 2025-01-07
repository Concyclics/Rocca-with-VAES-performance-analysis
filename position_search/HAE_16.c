#include "HAE.h"
#include <string.h>

/*
 * STATE size and & STATE
 */

/*
 * The HAE position design of XOR
 * The position has freezed, change might cause some problem in unroll part
 */
#define P_0 0
#define P_1 1
//#define P_4 4
#define P_7 9
//#define i_1 3
//#define i_2 5

static const uint8_t CONST1[16] = {
    0x42, 0x8a, 0x2f, 0x98, 0xd7, 0x28, 0xae, 0x22, 0x71, 0x37, 0x44, 0x91, 0x23, 0xef, 0x65, 0xcd
};
static const uint8_t CONST2[16] = {
     0xb5, 0xc0, 0xfb, 0xcf, 0xec, 0x4d, 0x3b, 0x2f, 0xe9, 0xb5, 0xdb, 0xa5, 0x81, 0x89, 0xdb, 0xbc
};

static const uint8_t zo[16] = {
    0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00
};

/*
 * Update the STATE and shift by 1 as the HAE design
 */

#if defined(__AES__) && defined(__x86_64__)

#define UPDATE_STATE_offset(M, offset)\
    tmp[offset] = aesemc(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    state[(0 + offset) % STATE] = aes(state[(P_4 + offset) % STATE]);\
    state[(0 + offset) % STATE] = xor(M, state[(0 + offset) % STATE]);\
    state[(0 + offset) % STATE] = xor(state[(0 + offset) % STATE], tmp[offset]);\
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);

#define ENC_offset(M, C, offset)\
    tmp[offset] = xor(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    C = aesenc(tmp[offset], M);\
    state[(0 + offset) % STATE] = aesenc(state[(P_4 + offset) % STATE], C);\
    C = xor(C, state[(P_7 + offset) % STATE]);\
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);

#define DEC_offset(M, C, offset)\
    tmp[offset] = xor(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    M = xor(state[(P_7 + offset) % STATE], C);\
    state[(0 + offset) % STATE] = aesenc(state[(P_4 + offset) % STATE], M);\
    M = aesenc(tmp[offset], M);\
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);


#elif defined(__ARM_FEATURE_AES) && defined(__ARM_NEON)

#define UPDATE_STATE_offset(M, offset)\
    tmp[offset] = aesemc(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    state[(0 + offset) % STATE] = aes(state[(P_4 + offset) % STATE]);\
    state[(0 + offset) % STATE] = xor(M, state[(0 + offset) % STATE]);\
    state[(0 + offset) % STATE] = xor(state[(0 + offset) % STATE], tmp[offset]);\
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);

#define ENC_offset(M, C, offset)\
    tmp[offset] = aesemc(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    C = xor(tmp[offset], M); \
    state[(0 + offset) % STATE] = xor(C, aes(state[(P_4 + offset) % STATE]));\
    C = xor(C, state[(P_7 + offset) % STATE]); \
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);

#define DEC_offset(M, C, offset)\
    tmp[offset] = aesemc(state[(P_0 + offset) % STATE], state[(P_1 + offset) % STATE]);\
    M = xor(state[(P_7 + offset) % STATE], C);\
    state[(0 + offset) % STATE] = xor(M, aes(state[(P_4 + offset) % STATE]));\
    M = xor(M, tmp[offset]);\
    state[(i_1 + offset) % STATE] = xor(state[(i_1 + offset) % STATE], M);\
    state[(i_2 + offset) % STATE] = xor(state[(i_2 + offset) % STATE], M);

#else

#error This_Arch_do_not_Supported_yet_!!!

#endif

/*
 * load 4 128bit block from src
 */
#define LOAD_1BLOCK_offset(M, offset) \
    (M) = load(src + i + 0 + BLOCK_SIZE * offset); \
/*
 * store 4 128bit block to dst
 */
#define STORE_1BLOCK_offset(C, offset) \
    store(dst + i + 0 + BLOCK_SIZE * offset, (C)); \

#define encode_little_endian(bytes, v) \
    bytes[ 0] = (( uint64_t )( v ) << ( 3)); \
    bytes[ 1] = (( uint64_t )( v ) >> (1*8 -3)); \
    bytes[ 2] = (( uint64_t )( v ) >> (2*8 -3)); \
    bytes[ 3] = (( uint64_t )( v ) >> (3*8 -3)); \
    bytes[ 4] = (( uint64_t )( v ) >> (4*8 -3)); \
    bytes[ 5] = (( uint64_t )( v ) >> (5*8 -3)); \
    bytes[ 6] = (( uint64_t )( v ) >> (6*8 -3)); \
    bytes[ 7] = (( uint64_t )( v ) >> (7*8 -3)); \
    bytes[ 8] = (( uint64_t )( v ) >> (8*8 -3)); \
    bytes[ 9] = 0; \
    bytes[10] = 0; \
    bytes[11] = 0; \
    bytes[12] = 0; \
    bytes[13] = 0; \
    bytes[14] = 0; \
    bytes[15] = 0;

#define STATE_SHIFT \
tmp[0] = state[0];\
state[0] = state[1]; \
state[1] = state[2]; \
state[2] = state[3]; \
state[3] = state[4]; \
state[4] = state[5]; \
state[5] = state[6]; \
state[6] = state[7]; \
state[7] = state[8]; \
state[8] = state[9]; \
state[9] = state[10]; \
state[10] = state[11]; \
state[11] = state[12]; \
state[12] = state[13]; \
state[13] = state[14]; \
state[14] = state[15]; \
state[15] = tmp[0]

#define ENCRYPT \
LOAD_1BLOCK_offset(M[0], 0);\
LOAD_1BLOCK_offset(M[1], 1);\
LOAD_1BLOCK_offset(M[2], 2);\
LOAD_1BLOCK_offset(M[3], 3);\
LOAD_1BLOCK_offset(M[4], 4);\
LOAD_1BLOCK_offset(M[5], 5);\
LOAD_1BLOCK_offset(M[6], 6);\
LOAD_1BLOCK_offset(M[7], 7);\
LOAD_1BLOCK_offset(M[8], 8);\
LOAD_1BLOCK_offset(M[9], 9);\
LOAD_1BLOCK_offset(M[10], 10);\
LOAD_1BLOCK_offset(M[11], 11);\
LOAD_1BLOCK_offset(M[12], 12);\
LOAD_1BLOCK_offset(M[13], 13);\
LOAD_1BLOCK_offset(M[14], 14);\
LOAD_1BLOCK_offset(M[15], 15);\
ENC_offset(M[0], C[0], 0);\
ENC_offset(M[1], C[1], 1);\
ENC_offset(M[2], C[2], 2);\
ENC_offset(M[3], C[3], 3);\
ENC_offset(M[4], C[4], 4);\
ENC_offset(M[5], C[5], 5);\
ENC_offset(M[6], C[6], 6);\
ENC_offset(M[7], C[7], 7);\
ENC_offset(M[8], C[8], 8);\
ENC_offset(M[9], C[9], 9);\
ENC_offset(M[10], C[10], 10);\
ENC_offset(M[11], C[11], 11);\
ENC_offset(M[12], C[12], 12);\
ENC_offset(M[13], C[13], 13);\
ENC_offset(M[14], C[14], 14);\
ENC_offset(M[15], C[15], 15);\
STORE_1BLOCK_offset(C[0], 0);\
STORE_1BLOCK_offset(C[1], 1);\
STORE_1BLOCK_offset(C[2], 2);\
STORE_1BLOCK_offset(C[3], 3);\
STORE_1BLOCK_offset(C[4], 4);\
STORE_1BLOCK_offset(C[5], 5);\
STORE_1BLOCK_offset(C[6], 6);\
STORE_1BLOCK_offset(C[7], 7);\
STORE_1BLOCK_offset(C[8], 8);\
STORE_1BLOCK_offset(C[9], 9);\
STORE_1BLOCK_offset(C[10], 10);\
STORE_1BLOCK_offset(C[11], 11);\
STORE_1BLOCK_offset(C[12], 12);\
STORE_1BLOCK_offset(C[13], 13);\
STORE_1BLOCK_offset(C[14], 14);\
STORE_1BLOCK_offset(C[15], 15);\

#define DECRYPT \
LOAD_1BLOCK_offset(C[0], 0);\
LOAD_1BLOCK_offset(C[1], 1);\
LOAD_1BLOCK_offset(C[2], 2);\
LOAD_1BLOCK_offset(C[3], 3);\
LOAD_1BLOCK_offset(C[4], 4);\
LOAD_1BLOCK_offset(C[5], 5);\
LOAD_1BLOCK_offset(C[6], 6);\
LOAD_1BLOCK_offset(C[7], 7);\
LOAD_1BLOCK_offset(C[8], 8);\
LOAD_1BLOCK_offset(C[9], 9);\
LOAD_1BLOCK_offset(C[10], 10);\
LOAD_1BLOCK_offset(C[11], 11);\
LOAD_1BLOCK_offset(C[12], 12);\
LOAD_1BLOCK_offset(C[13], 13);\
LOAD_1BLOCK_offset(C[14], 14);\
LOAD_1BLOCK_offset(C[15], 15);\
DEC_offset(M[0], C[0], 0);\
DEC_offset(M[1], C[1], 1);\
DEC_offset(M[2], C[2], 2);\
DEC_offset(M[3], C[3], 3);\
DEC_offset(M[4], C[4], 4);\
DEC_offset(M[5], C[5], 5);\
DEC_offset(M[6], C[6], 6);\
DEC_offset(M[7], C[7], 7);\
DEC_offset(M[8], C[8], 8);\
DEC_offset(M[9], C[9], 9);\
DEC_offset(M[10], C[10], 10);\
DEC_offset(M[11], C[11], 11);\
DEC_offset(M[12], C[12], 12);\
DEC_offset(M[13], C[13], 13);\
DEC_offset(M[14], C[14], 14);\
DEC_offset(M[15], C[15], 15);\
STORE_1BLOCK_offset(M[0], 0);\
STORE_1BLOCK_offset(M[1], 1);\
STORE_1BLOCK_offset(M[2], 2);\
STORE_1BLOCK_offset(M[3], 3);\
STORE_1BLOCK_offset(M[4], 4);\
STORE_1BLOCK_offset(M[5], 5);\
STORE_1BLOCK_offset(M[6], 6);\
STORE_1BLOCK_offset(M[7], 7);\
STORE_1BLOCK_offset(M[8], 8);\
STORE_1BLOCK_offset(M[9], 9);\
STORE_1BLOCK_offset(M[10], 10);\
STORE_1BLOCK_offset(M[11], 11);\
STORE_1BLOCK_offset(M[12], 12);\
STORE_1BLOCK_offset(M[13], 13);\
STORE_1BLOCK_offset(M[14], 14);\
STORE_1BLOCK_offset(M[15], 15);\


void HAE_stream_init(DATA128b* state, const uint8_t *key, const uint8_t *iv) {
    DATA128b const_0 = load(CONST1);
    DATA128b key_0 = load(key);
    DATA128b key_1 = load(key+16);
    DATA128b iv_ = load(iv);

    DATA128b ze = load(zo);
    state[0] = key_1;
    state[1] = iv_;
    state[2] = const_0;
    state[3] = ze;
    state[4] = xor(key_1, iv_);
    state[5] = ze;
    state[6] = key_0;
    state[7] = ze;
    state[8] = key_1;
    state[9] = iv_;
    state[10] = const_0;
    state[11] = ze;
    //state[12] = key_0;
    //state[13] = ze;
    //state[14] = key_1;
    //state[15] = iv_;
    //state[16] = const_0;
    //state[17] = ze;
    for(int i = 11; i < STATE; i++)
    {
        state[i] = key_0;
    }

    DATA128b temp, tmp[STATE];
    for (size_t i = 0; i < STATE; ++i) {
        UPDATE_STATE_offset(const_0, i);
    }
    state[0] = xor(state[0], key_0);
    state[7] = xor(state[7], key_1);
}

void HAE_stream_proc_ad(DATA128b* state, const uint8_t *ad, size_t len) {
    size_t l = 0;
    size_t full_block_len = len - len % BLOCK_SIZE;
    DATA128b temp, tmp[STATE], M;
    int i = 0;
    while(l != full_block_len) {
        M = load(ad + l);
        UPDATE_STATE_offset(M, 0);
        STATE_SHIFT;
        l += BLOCK_SIZE;
    }
}
    
void HAE_stream_finalize(DATA128b* state, uint64_t ad_len, uint64_t plain_len, uint8_t *tag) {
    
    uint8_t lenad[16];
    uint8_t lenmsg[16];
    encode_little_endian(lenad, ad_len);
    encode_little_endian(lenmsg, plain_len);
    DATA128b lead = load(lenad);
    DATA128b lemsg = load(lenmsg);
    DATA128b temp, tmp[STATE];
    temp = xor(lead, lemsg);
    for (size_t i = 0; i < STATE; ++i) {
        UPDATE_STATE_offset(temp, i);
    }
    temp = state[0];
    for (size_t i = 1; i < STATE; ++i) {
        temp = xor(temp, state[i]);
    }
    store(tag, temp);
}

void HAE_stream_encrypt(DATA128b* state, uint8_t *dst, const uint8_t *src, size_t size) {
    size_t rest = size % UNROLL_BLOCK_SIZE;
    size_t prefix = size - rest;
    DATA128b M[STATE], C[STATE], tmp[STATE], temp;

    for(size_t i = 0; i < prefix; i += UNROLL_BLOCK_SIZE) {
        ENCRYPT;
    }
    for(size_t i = 0; i < rest; i += BLOCK_SIZE) {
        M[0] = load(src + i + prefix);
        ENC_offset(M[0], C[0], 0);
        STATE_SHIFT;
        store(dst + i + prefix, C[0]);
    }
}

void HAE_stream_decrypt(DATA128b* state, uint8_t *dst, const uint8_t *src, size_t size) {
    size_t rest = size % UNROLL_BLOCK_SIZE;
    size_t prefix = size - rest;
    DATA128b M[STATE], C[STATE], tmp[STATE], temp;

    for(size_t i = 0; i < prefix; i += UNROLL_BLOCK_SIZE) {
        DECRYPT;
    }
    for(size_t i = 0; i < rest; i += BLOCK_SIZE) {
        C[0] = load(src + i + prefix);
        DEC_offset(M[0], C[0], 0);
        STATE_SHIFT;
        store(dst + i + prefix, M[0]);
    }
}

void HAE(uint8_t *key, uint8_t *iv, uint8_t *plain, uint8_t *cipher, uint8_t *ad, uint8_t *tag) {
    DATA128b state[STATE];

    HAE_stream_init(state, key, iv);
    HAE_stream_proc_ad(state, ad, strlen(ad));
    HAE_stream_encrypt(state, plain, cipher, strlen(plain));
    HAE_stream_finalize(state, strlen(ad), strlen(plain), tag);

}
