#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "HiAE.h"
#include <time.h>
#define REPEAT 65536

void print_data(const uint8_t *data, size_t len) {
    for (size_t i = 0; i < len; ++i) {
        printf("%02x", data[i]);
    }
    printf("\n");
}

int functional_test_work(int len) {
    uint8_t *key = (uint8_t *) malloc(32);
    memset(key, 1, 32);

    uint8_t *iv = (uint8_t *) malloc(16);
    memset(iv, 1, 16);

    size_t ad_len = 48;
    uint8_t *ad = (uint8_t *) malloc(ad_len);
    memset(ad, 1, ad_len);

    size_t plain_len = len * BLOCK_SIZE;

    uint8_t *plain = (uint8_t *) malloc(plain_len);
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    uint8_t *decode = (uint8_t *) malloc(plain_len);

    uint8_t tag1[16], tag2[16];

    memset(plain, 0x1, plain_len);
    //printf("len = %lu %lu\n",  strlen(ad), strlen(plain));
    //HiAE(key, iv, plain, cipher, ad, tag1);

    DATA128b state[STATE];

    int rnd_1, rnd_2; 
    rnd_1 = rand() % len;
    rnd_2 = rand() % len;
    HiAE_stream_init(state, key, iv);
    HiAE_stream_proc_ad(state, ad, ad_len);
    HiAE_stream_encrypt(state, cipher, plain, rnd_1 * BLOCK_SIZE);
    HiAE_stream_encrypt(state, cipher + rnd_1 * BLOCK_SIZE, plain + rnd_1 * BLOCK_SIZE, (len-rnd_1) * BLOCK_SIZE);
    HiAE_stream_finalize(state, ad_len, plain_len, tag1);
    
    HiAE_stream_init(state, key, iv);
    HiAE_stream_proc_ad(state, ad, ad_len);
    HiAE_stream_decrypt(state, decode, cipher, rnd_2 * BLOCK_SIZE);
    HiAE_stream_decrypt(state, decode + rnd_2 * BLOCK_SIZE, cipher + rnd_2 * BLOCK_SIZE, (len-rnd_2) * BLOCK_SIZE);
    HiAE_stream_finalize(state, ad_len, plain_len, tag2);
    
    int same_msg = memcmp(plain, decode, plain_len);
    int same_tag = memcmp(tag1, tag2, 16);
    free(ad);
    free(plain);
    free(cipher);
    free(decode);
    
    if(!(same_msg | same_tag)) {
        return 1;
    }
    else {
        return 0;
    }
    
    return 0;
}

void functional_test() {
    printf("--------functional test----------\n");
    int result = 1;
    int T = REPEAT;
    int len = 1024;
    while(T--) {
        result &= functional_test_work(len);
    }
    if(result) {
        printf("functional test pass.\n\n");
    }
    else {
        printf("functional test failed!\n\n");
    }
}

double speed_test_ad_work(size_t len) {
    uint8_t key[32];
    memset(key, 1, 32);
    uint8_t iv[16];
    memset(iv, 1, 16);
    size_t ad_len = len;
    uint8_t *ad = (uint8_t *) malloc(ad_len);
    memset(ad, 1, ad_len);
    DATA128b state[STATE];
    clock_t start, end;
    uint8_t tag[16];
    start = clock();
    for (size_t iter = REPEAT; iter > 0; iter --) {
        HiAE_stream_init(state, key, iv);
        HiAE_stream_proc_ad(state, ad, ad_len);
        HiAE_stream_finalize(state, ad_len, 0, tag);
    }
    end = clock();

    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) REPEAT * len) / (cpu_time_used*(125000000));

    return speed;
}


double speed_test_encode_work(size_t len, int AEAD) {
    uint8_t key[32];
    memset(key, 1, 32);
    uint8_t iv[16];
    memset(iv, 1, 16);
    size_t ad_len = 48;
    uint8_t *ad = (uint8_t *) malloc(ad_len);
    memset(ad, 1, ad_len);
    size_t plain_len = len;
    uint8_t *plain = (uint8_t *) malloc(plain_len);
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    memset(plain, 0x1, plain_len);
    DATA128b state[STATE];
    clock_t start, end;

    if(AEAD == 1) {
        uint8_t tag[16];
        start = clock();
        for (size_t iter = REPEAT; iter > 0; iter --) {
            HiAE_stream_init(state, key, iv);
            HiAE_stream_proc_ad(state, ad, ad_len);
            HiAE_stream_encrypt(state, cipher, plain, plain_len);
            HiAE_stream_finalize(state, ad_len, plain_len, tag);
        }
        end = clock();
    }
    else {
        start = clock();
        for (size_t iter = REPEAT; iter > 0; iter --) {
            HiAE_stream_init(state, key, iv);
            HiAE_stream_encrypt(state, cipher, plain, plain_len);
        }
        end = clock();
    }

    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) REPEAT * plain_len) / (cpu_time_used*(125000000));

    return speed;
}

double speed_test_decode_work(size_t len, int AEAD) {
    uint8_t key[32];
    memset(key, 1, 32);
    uint8_t iv[16];
    memset(iv, 1, 16);
    size_t ad_len = 48;
    uint8_t *ad = (uint8_t *) malloc(ad_len);
    memset(ad, 1, ad_len);
    size_t plain_len = len;
    uint8_t *plain = (uint8_t *) malloc(plain_len);
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    memset(plain, 0x1, plain_len);
    DATA128b state[STATE];
    clock_t start, end;
    
    if(AEAD == 1) {
        uint8_t tag[16];
        start = clock();
        for (size_t iter = REPEAT; iter > 0; iter --) {
            HiAE_stream_init(state, key, iv);
            HiAE_stream_proc_ad(state, ad, ad_len);
            HiAE_stream_decrypt(state, cipher, plain, plain_len);
            HiAE_stream_finalize(state, ad_len, plain_len, tag);
        }
        end = clock();
    }
    else {
        start = clock();
        for (size_t iter = REPEAT; iter > 0; iter --) {
            HiAE_stream_init(state, key, iv);
            HiAE_stream_decrypt(state, cipher, plain, plain_len);
        }
        end = clock();
    }
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) REPEAT * plain_len) / (cpu_time_used*(125000000.0));

    return speed;
}

void speed_test() {
    int len_test_case = 9;
    size_t test_case[9] = {16, 64, 256, 512, 1024, 2048, 4096, 8192, 16384};
    double encrypto_speed[len_test_case];
    double decrypto_speed[len_test_case];
    printf("--------speed test Encryption Only(Gbps)----------\n");
    for (int i = 0; i < len_test_case; i++)
    {
        encrypto_speed[i] = speed_test_encode_work(test_case[i], 0);
        decrypto_speed[i] = speed_test_decode_work(test_case[i], 0);
        double ad = speed_test_ad_work(test_case[i]);
        printf("length: %ld, encrypt: %.2f, decrypt: %.2f, AD: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i], ad);
    }
}

void speed_test_AEAD() {
    int len_test_case = 9;
    size_t test_case[9] = {16, 64, 256, 512, 1024, 2048, 4096, 8192, 16384};
    double encrypto_speed[len_test_case];
    double decrypto_speed[len_test_case];
    printf("--------speed test AEAD(Gbps)----------\n");
    for (int i = 0; i < len_test_case; i++)
    {
        encrypto_speed[i] = speed_test_encode_work(test_case[i], 1);
        decrypto_speed[i] = speed_test_decode_work(test_case[i], 1);
        printf("length: %ld, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
    }
}

int main() {
    printf("========HiAE test========\n");
    functional_test();
    speed_test();
    speed_test_AEAD();
}
