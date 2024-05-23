#include "HAE.h"
#include <string.h>

#define STATE 16
#define MOD 15

#define XOR_1 0
#define XOR_2 2
#define XOR_3 11
#define XOR_4 1
#define XOR_5 3
#define XOR_6 4
#define XOR_7 10
#define XOR_8 15


static const uint8_t CONST1[16] = {
    0x42, 0x8a, 0x2f, 0x98, 0xd7, 0x28, 0xae, 0x22, 0x71, 0x37, 0x44, 0x91, 0x23, 0xef, 0x65, 0xcd
};
static const uint8_t CONST2[16] = {
     0xb5, 0xc0, 0xfb, 0xcf, 0xec, 0x4d, 0x3b, 0x2f, 0xe9, 0xb5, 0xdb, 0xa5, 0x81, 0x89, 0xdb, 0xbc
};

static const uint8_t zo[16] = {
    0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00
};

#define UPDATE_STATE_SHIFT(X) \
    temp = xor(state[XOR_1], state[XOR_2]); \
    temp = xor(temp, state[XOR_3]); \
    state[XOR_8] = aesdimc(state[XOR_8], X); \
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
    state[15] = aesemc(temp, X);

#define SHIFT_STATE(i) \
    memcpy(state_tmp, state, 16); \
    state[0] = state_tmp[i]; \
    state[1] = state_tmp[(i+1)&MOD]; \
    state[2] = state_tmp[(i+2)&MOD]; \
    state[3] = state_tmp[(i+3)&MOD]; \
    state[4] = state_tmp[(i+4)&MOD]; \
    state[5] = state_tmp[(i+5)&MOD]; \
    state[6] = state_tmp[(i+6)&MOD]; \
    state[7] = state_tmp[(i+7)&MOD]; \
    state[8] = state_tmp[(i+8)&MOD]; \
    state[9] = state_tmp[(i+9)&MOD]; \
    state[10] = state_tmp[(i+10)&MOD]; \
    state[11] = state_tmp[(i+11)&MOD]; \
    state[12] = state_tmp[(i+12)&MOD]; \
    state[13] = state_tmp[(i+13)&MOD]; \
    state[14] = state_tmp[(i+14)&MOD]; \
    state[15] = state_tmp[(i+15)&MOD];

#define UPDATE_STATE_OFFSET(X, offset) \
    temp = xor(state[(XOR_1+offset)&MOD], state[(XOR_2+offset)&MOD]); \
    temp = xor(temp, state[(XOR_3+offset)&MOD]); \
    state[(XOR_8+offset)&MOD] = aesdimc(state[(XOR_8+offset)&MOD], X); \
    state[offset&MOD] = aesemc(temp, X);

#define XOR_STRM_SHIFT(src, dst) \
    temp = xor(state[XOR_4], state[XOR_5]); \
    temp = aesemc(temp, state[XOR_6]); \
    dst = xor(state[XOR_7], temp); \
    dst = xor(dst, src);

#define XOR_STRM_OFFSET(src, dst, offset) \
    temp = xor(state[(XOR_4+offset)&MOD], state[(XOR_5+offset)&MOD]); \
    temp = aesemc(temp, state[(XOR_6+offset)&MOD]); \
    dst = xor(state[(XOR_7+offset)&MOD], temp); \
    dst = xor(dst, src);

#define XOR_1_6_4STEP_FUSION_OFFSET(offset) \
    tmp[0] = xor(state[(XOR_1+0+offset)&MOD], state[(XOR_2+0+offset)&MOD]); \
    tmp[0] = xor(tmp[0], state[(XOR_3+0+offset)&MOD]); \
    tmp[1] = xor(state[(XOR_4+0+offset)&MOD], state[(XOR_5+0+offset)&MOD]); \
    tmp[2] = xor(state[(XOR_1+1+offset)&MOD], state[(XOR_2+1+offset)&MOD]); \
    tmp[2] = xor(tmp[2], state[(XOR_3+1+offset)&MOD]); \
    tmp[3] = xor(state[(XOR_4+1+offset)&MOD], state[(XOR_5+1+offset)&MOD]); \
    tmp[4] = xor(state[(XOR_1+2+offset)&MOD], state[(XOR_2+2+offset)&MOD]); \
    tmp[4] = xor(tmp[4], state[(XOR_3+2+offset)&MOD]); \
    tmp[5] = xor(state[(XOR_4+2+offset)&MOD], state[(XOR_5+2+offset)&MOD]); \
    tmp[6] = xor(state[(XOR_1+3+offset)&MOD], state[(XOR_2+3+offset)&MOD]); \
    tmp[6] = xor(tmp[6], state[(XOR_3+3+offset)&MOD]); \
    tmp[7] = xor(state[(XOR_4+3+offset)&MOD], state[(XOR_5+3+offset)&MOD]); \

#define LOAD_4STEP_OFFSET(M, offset) \
    M[0] = load(src + i + 0 + 16*offset); \
    M[1] = load(src + i + 16 + 16*offset); \
    M[2] = load(src + i + 32 + 16*offset); \
    M[3] = load(src + i + 48 + 16*offset);

#define STORE_4STEP_OFFSET(C, offset) \
    store(dst + i + 0 + 16*offset, C[0]); \
    store(dst + i + 16 + 16*offset, C[1]); \
    store(dst + i + 32 + 16*offset, C[2]); \
    store(dst + i + 48 + 16*offset, C[3]);

#define NEW_STATE_ARRIVAL_4STEP_OFFSET(M, offset) \
    state[0+offset] = aesemc(M[0], tmp[0]); \
    state[1+offset] = aesemc(M[1], tmp[2]); \
    state[2+offset] = aesemc(M[2], tmp[4]); \
    state[3+offset] = aesemc(M[3], tmp[6]);

#define XOR_8_4STEP_OFFSET(M, offset) \
    state[(XOR_8+0+offset)&MOD] = aesdimc(state[(XOR_8+0+offset)&MOD], M[0]); \
    state[(XOR_8+1+offset)&MOD] = aesdimc(state[(XOR_8+1+offset)&MOD], M[1]); \
    state[(XOR_8+2+offset)&MOD] = aesdimc(state[(XOR_8+2+offset)&MOD], M[2]); \
    state[(XOR_8+3+offset)&MOD] = aesdimc(state[(XOR_8+3+offset)&MOD], M[3]);

#define XOR_7_4STEP_OFFSET(M, C, offset) \
    tmp[1] = aesemc(tmp[1], state[(XOR_6+0+offset)&MOD]); \
    tmp[3] = aesemc(tmp[3], state[(XOR_6+1+offset)&MOD]); \
    tmp[5] = aesemc(tmp[5], state[(XOR_6+2+offset)&MOD]); \
    tmp[7] = aesemc(tmp[7], state[(XOR_6+3+offset)&MOD]); \
    C[0] = xor(M[0], tmp[1]); \
    C[0] = xor(C[0], state[(XOR_7+0+offset)&MOD]); \
    C[1] = xor(M[1], tmp[3]); \
    C[1] = xor(C[1], state[(XOR_7+1+offset)&MOD]); \
    C[2] = xor(M[2], tmp[5]); \
    C[2] = xor(C[2], state[(XOR_7+2+offset)&MOD]); \
    C[3] = xor(M[3], tmp[7]); \
    C[3] = xor(C[3], state[(XOR_7+3+offset)&MOD]);

#define ENCRYPT_4_OFFSET(M, C, offset) \
    LOAD_4STEP_OFFSET(M, offset) \
    XOR_1_6_4STEP_FUSION_OFFSET(offset) \
    NEW_STATE_ARRIVAL_4STEP_OFFSET(M, offset) \
    XOR_8_4STEP_OFFSET(M, offset) \
    XOR_7_4STEP_OFFSET(M, C, offset) \
    STORE_4STEP_OFFSET(C, offset)

#define DECRYPT_4_OFFSET(M, C, offset) \
    LOAD_4STEP_OFFSET(C, offset) \
    XOR_1_6_4STEP_FUSION_OFFSET(offset) \
    XOR_7_4STEP_OFFSET(C, M, offset) \
    NEW_STATE_ARRIVAL_4STEP_OFFSET(M, offset) \
    XOR_8_4STEP_OFFSET(M, offset) \
    STORE_4STEP_OFFSET(M, offset)

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
    state[12] = xor(key_1, iv_);
    state[13] = ze;
    state[14] = key_0;
    state[15] = ze;

    DATA128b temp;
    for (size_t i = 0; i < 20; ++i) {
        UPDATE_STATE_SHIFT(const_0);
    }
    state[0] = xor(state[0], key_0);
    state[7] = xor(state[7], key_1);
}

void HAE_stream_proc_ad(DATA128b* state, const uint8_t *ad, size_t len) {
    size_t l = 0;
    size_t full_block_len = (len >> 4) << 4;
    DATA128b temp;
    while(l != full_block_len) {
        UPDATE_STATE_SHIFT(load(ad + l));
        l += 16;
    }
}

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
    
void HAE_stream_finalize(DATA128b* state, uint64_t ad_len, uint64_t plain_len, uint8_t *tag) {
    
    uint8_t lenad[16];
    uint8_t lenmsg[16];
    encode_little_endian(lenad, ad_len);
    encode_little_endian(lenmsg, plain_len);
    DATA128b lead = load(lenad);
    DATA128b lemsg = load(lenmsg);
    DATA128b temp;
    for (size_t i = 0; i < 20; ++i) {
        UPDATE_STATE_SHIFT(xor(lead, lemsg));
    }
    temp = state[0];
    for (size_t i = 1; i < 16; ++i) {
        temp = xor(temp, state[i]);
    }
    store(tag, temp);
}

void HAE_stream_encrypt(DATA128b* state, uint8_t *dst, const uint8_t *src, size_t size) {
    size_t rest = size & 255;
    size_t prefix = size - rest;
    DATA128b M[4], C[4], tmp[12], temp;

    for(size_t i = 0; i < prefix; i += 256) {
        ENCRYPT_4_OFFSET(M, C, 0);
        ENCRYPT_4_OFFSET(M, C, 4);
        ENCRYPT_4_OFFSET(M, C, 8);
        ENCRYPT_4_OFFSET(M, C, 12);
    }
    for(size_t i = 0; i < rest; i += 16) {
        M[0] = load(src + prefix + i);
        XOR_STRM_SHIFT(M[0], C[0]);
        UPDATE_STATE_SHIFT(M[0]);
        store(dst + prefix + i, C[0]);
    }
}

void HAE_stream_decrypt(DATA128b* state, uint8_t *dst, const uint8_t *src, size_t size) {
    size_t rest = size & 255;
    size_t prefix = size - rest;
    DATA128b M[4], C[4], tmp[12], temp;
    for(size_t i = 0; i < prefix; i += 256) {
        DECRYPT_4_OFFSET(M, C, 0);
        DECRYPT_4_OFFSET(M, C, 4);
        DECRYPT_4_OFFSET(M, C, 8);
        DECRYPT_4_OFFSET(M, C, 12);
    }
    for(size_t i = 0; i < rest; i += 16) {
        C[0] = load(src + prefix + i);
        XOR_STRM_SHIFT(C[0], M[0]);
        UPDATE_STATE_SHIFT(M[0]);
        store(dst + prefix + i, M[0]);
    }
}

void HAE(uint8_t *key, uint8_t *iv, uint8_t *plain, uint8_t *cipher, uint8_t *ad, uint8_t *tag) {
    DATA128b state[16];

    HAE_stream_init(state, key, iv);
    HAE_stream_proc_ad(state, ad, strlen(ad));
    HAE_stream_encrypt(state, plain, cipher, strlen(plain));
    HAE_stream_finalize(state, strlen(ad), strlen(plain), tag);

}
