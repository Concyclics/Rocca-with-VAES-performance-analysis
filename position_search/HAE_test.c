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

    size_t plain_len = len * BLOCK_SIZE;

    uint8_t *plain = (uint8_t *) malloc(plain_len);
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    uint8_t *decode = (uint8_t *) malloc(plain_len);

    uint8_t tag1[16], tag2[16];

    memset(plain, 0x1, plain_len);
    //printf("len = %lu %lu\n",  strlen(ad), strlen(plain));
    //HAE(key, iv, plain, cipher, ad, tag1);

    DATA128b state[STATE];

    int rnd_1, rnd_2; 
    rnd_1 = rand() % len;
    rnd_2 = rand() % len;
    HAE_stream_init(state, key, iv);
    HAE_stream_encrypt(state, cipher, plain, rnd_1 * BLOCK_SIZE);
    HAE_stream_encrypt(state, cipher + rnd_1 * BLOCK_SIZE, plain + rnd_1 * BLOCK_SIZE, (len-rnd_1) * BLOCK_SIZE);
    HAE_stream_finalize(state, ad_len, plain_len, tag1);
    
    HAE_stream_init(state, key, iv);
    HAE_stream_decrypt(state, decode, cipher, rnd_2 * BLOCK_SIZE);
    HAE_stream_decrypt(state, decode + rnd_2 * BLOCK_SIZE, cipher + rnd_2 * BLOCK_SIZE, (len-rnd_2) * BLOCK_SIZE);
    HAE_stream_finalize(state, ad_len, plain_len, tag2);
    
    /*
    printf("--------functional test----------\n");
    printf("key  = ");
    print_data(key, 16);
    printf("iv     = ");
    print_data(iv, 16);

    printf("msg = ");
    print_data(plain, plain_len);
    printf("cipher = ");
    print_data(cipher, plain_len);
    printf("tag1 = ");
    print_data(tag1, 16);
    printf("decrypt = ");
    print_data(decode, plain_len);
    printf("tag2 = ");
    print_data(tag2, 16);
    */
    

    int same_msg = memcmp(plain, decode, plain_len);
    int same_tag = memcmp(tag1, tag2, 16);
    free(ad);
    free(plain);
    free(cipher);
    free(decode);
    
    //printf("same %d %d\n", same_msg, same_tag);
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
    int T = 2333;
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

    DATA128b state[STATE];

    clock_t start, end;
    
    start = clock();
    for (size_t iter = REPEAT; iter > 0; iter --) {
        //HAE_stream_init(state, key, iv);
        HAE_stream_encrypt(state, cipher, plain, plain_len);
        //HAE_stream_finalize(state, ad_len, plain_len, tag);
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

    DATA128b state[STATE];

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
    int len_test_case = 17;
    size_t test_case[len_test_case];
    double encrypto_speed[len_test_case];
    double decrypto_speed[len_test_case];
    test_case[0] = 64;
    int tmp = 64;
    for (int i = 0; i < len_test_case; i++)
    {
        test_case[i] = tmp;
        if(tmp <= 2048)
        {
            tmp*=2;
        }
        else if(tmp < 16384)
        {
            tmp+=2048;
        }
        else
        {
            tmp+=4096;
        }
    }
    printf("--------speed test(Gbps)----------\n");
    for (int i = 0; i < len_test_case; i++)
    {
        encrypto_speed[i] = speed_test_encode_work(test_case[i]);
        decrypto_speed[i] = speed_test_decode_work(test_case[i]);
        printf("length: %d, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
    }
    /*
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
    */
}

int main() {
    functional_test();
    speed_test();
}
