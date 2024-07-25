#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "HAE.h"
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

    size_t plain_len = len * 16 * 16;

    uint8_t *plain = (uint8_t *) malloc(plain_len);
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    uint8_t *decode = (uint8_t *) malloc(plain_len);

    uint8_t tag1[16], tag2[16];

    memset(plain, 0x1, plain_len);
    //printf("len = %lu %lu\n",  strlen(ad), strlen(plain));
    //HAE(key, iv, plain, cipher, ad, tag1);

    DATA128b state[16];

    int rnd_1 = rand() % len;
    int rnd_2 = rand() % len;
    //printf("rnd_1/2 = %lu %lu\n", rnd_1, rnd_2);

    HAE_stream_init(state, key, iv);
    HAE_stream_encrypt(state, cipher, plain, rnd_1 * 16);
    HAE_stream_encrypt(state, cipher + rnd_1 * 16, plain + rnd_1 * 16, (len-rnd_1) * 16);
    HAE_stream_finalize(state, ad_len, plain_len, tag1);
    
    HAE_stream_init(state, key, iv);
    HAE_stream_decrypt(state, decode, cipher, rnd_2 * 16);
    HAE_stream_decrypt(state, decode + rnd_2 * 16, cipher + rnd_2 * 16, (len-rnd_2) * 16);
    HAE_stream_finalize(state, ad_len, plain_len, tag2);
    /*
    printf("--------functional test----------\n");
    printf("key  = ");
    print_data(key, 16);
    printf("iv     = ");
    print_data(iv, 16);

    printf("msg = ");
    print_data(plain, len * 16);
    printf("cipher = ");
    print_data(cipher, len * 16);
    printf("tag1 = ");
    print_data(tag1, 16);
    printf("decrypt = ");
    print_data(decode, len * 16);
    printf("tag2 = ");
    print_data(tag2, 16);
    */

    int same_msg = memcmp(plain, decode, len*16);
    int same_tag = memcmp(tag1, tag2, 16);
    free(ad);
    free(plain);
    free(cipher);
    free(decode);
    if(!(same_msg | same_tag)) {
        //printf("functional test pass.\n\n");
        return 1;
    }
    else {
        //printf("functional test failed!\n\n");
        return 0;
    }
    return 0;
}

void functional_test() {
    printf("--------functional test----------\n");
    int result = 1;
    int T = 64;
    while(T--) {
        result &= functional_test_work(1024);
    }
    if(result) {
        printf("functional test pass.\n\n");
    }
    else {
        printf("functional test failed!\n\n");
    }
}

double speed_test_encode_work(size_t len) {
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

    uint8_t tag[16];

    memset(plain, 0x1, plain_len);

    DATA128b state[16];

    clock_t start, end;
    
    HAE_stream_init(state, key, iv);
    start = clock();
    for (size_t iter = REPEAT; iter > 0; iter --) {
        HAE_stream_encrypt(state, cipher, plain, plain_len);
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) REPEAT * plain_len) / (cpu_time_used*(125000000));

    return speed;
}

double speed_test_decode_work(size_t len) {
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

    uint8_t tag[16];

    memset(plain, 0x1, plain_len);

    DATA128b state[16];

    clock_t start, end;
    
    HAE_stream_init(state, key, iv);
    start = clock();
    for (size_t iter = REPEAT; iter > 0; iter --) {
        HAE_stream_decrypt(state, cipher, plain, plain_len);
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) REPEAT * plain_len) / (cpu_time_used*(125000000.0));

    return speed;
}

void speed_test() {
    int len_test_case = 10;
    int test_case[10] = {64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768};
    double encrypto_speed[len_test_case];
    double decrypto_speed[len_test_case];
    for (int i = 0; i < len_test_case; i++)
    {
        encrypto_speed[i] = speed_test_encode_work(test_case[i]);
        decrypto_speed[i] = speed_test_decode_work(test_case[i]);
    }
    printf("--------speed test(Gbps)----------\n");
    printf("message length \t\t");
    for (int i = 0; i < len_test_case; i++)
    {
        printf("%d\t", test_case[i]);
    }
    printf("\n");
    printf("encryption speed \t");
    for (int i = 0; i < len_test_case; i++)
    {
        printf("%.1f\t", encrypto_speed[i]);
    }
    printf("\n");
    printf("decryption speed \t");
    for (int i = 0; i < len_test_case; i++)
    {
        printf("%.1f\t", decrypto_speed[i]);
    }
    printf("\n");
}

int main() {
    functional_test();
    speed_test();
}
