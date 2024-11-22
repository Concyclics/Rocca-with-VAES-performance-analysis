#include "snow-v.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

uint8_t res = 0;

#define SIZE 65536

void print_data(const uint8_t *data, size_t len) {
    for (size_t i = 0; i < len; ++i) {
        printf("%02x", data[i]);
    }
    printf("\n");
}

void snow5g_speedtest(uint8_t *plain, uint8_t *key, size_t len) {
    size_t plain_len = len;
    uint8_t *cipher = (uint8_t *) malloc(plain_len);
    uint8_t iv[16];
    memset(iv, 1, 16);

    clock_t start, end;
    int t = SIZE;
    start = clock();
    while(t--) {
        snow5g(plain, key, cipher, len);
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    double speed = ((double) SIZE * plain_len) / (cpu_time_used*(125000000));
    printf("time used = %.3fs\n", cpu_time_used);
    printf("approx. speed = %.3fGbps\n", speed);
    free(cipher);
}

void snow5g_print(uint8_t *plain, uint8_t *key, uint8_t *cipher) {
    size_t plain_len = strlen(plain);

    uint8_t iv[16];
    memset(iv, 1, 16);

    snow5g(plain, key, cipher, plain_len);
    printf("cipher = ");
    print_data(cipher, plain_len);
}



double speed_test_encode_work(size_t len, int AEAD) {
    clock_t start, end;
    if(AEAD==1) {
        size_t plain_len = len;
        uint8_t *plain = (uint8_t *) malloc(plain_len);
        memset(plain, 1, plain_len);
        uint8_t *cipher = (uint8_t *) malloc(plain_len);
        uint8_t key[32];
        memset(key, 1, 32);
        uint8_t tag[16];
        size_t ad_len = 48;
        uint8_t *ad = (uint8_t *) malloc(128);
        memset(ad, 1, ad_len);
        uint8_t val;
        start = clock();
        int t = SIZE;
        while(t--) {
            snow5g_aead_encrypt(plain, key, cipher, ad, tag, len);
        }
        end = clock();
        snow5g_aead_decrypt(plain, key, cipher, ad, tag, &val, len);
        res+=val;
        free(plain);
        free(cipher);
        free(ad);
    }
    else{
        size_t plain_len = len;
        uint8_t *plain = (uint8_t *) malloc(plain_len);
        memset(plain, 1, plain_len);
        uint8_t *cipher = (uint8_t *) malloc(plain_len);
        uint8_t key[32];
        memset(key, 1, 32);
        uint8_t tag[16];
        size_t ad_len = 48;
        uint8_t *ad = (uint8_t *) malloc(128);
        memset(ad, 1, ad_len);
        uint8_t val;

        int t = SIZE;
        start = clock();
        while(t--) {
            snow5g(plain, key, cipher, len);
        }
        end = clock();
        res+=cipher[0];
    }
    double t = (float)(end - start) / CLOCKS_PER_SEC;
    double speed = (len * SIZE / t) / 125000000;
    return speed;
}

double speed_test_decode_work(size_t len, int AEAD) {
    clock_t start, end;
    if(AEAD==1) {
        size_t plain_len = len;
        uint8_t *plain = (uint8_t *) malloc(plain_len);
        memset(plain, 1, plain_len);
        uint8_t *cipher = (uint8_t *) malloc(plain_len);
        memset(cipher, 1, plain_len);
        uint8_t key[32];
        memset(key, 1, 32);
        uint8_t tag[16];
        size_t ad_len = 48;
        uint8_t *ad = (uint8_t *) malloc(128);
        memset(ad, 1, ad_len);
        uint8_t val;
        snow5g_aead_encrypt(plain, key, cipher, ad, tag, len);
        start = clock();
        int t = SIZE;
        while(t--) {
            snow5g_aead_decrypt(plain, key, cipher, ad, tag, &val, len);
            res+=val;
        }
        end = clock();
        free(plain);
        free(cipher);
        free(ad);
    }
    else{
        size_t plain_len = len;
        uint8_t *plain = (uint8_t *) malloc(plain_len);
        memset(plain, 1, plain_len);
        uint8_t *cipher = (uint8_t *) malloc(plain_len);
        uint8_t key[32];
        memset(key, 1, 32);
        uint8_t tag[16];
        size_t ad_len = 48;
        uint8_t *ad = (uint8_t *) malloc(128);
        memset(ad, 1, ad_len);
        uint8_t val;

        int t = SIZE;
        start = clock();
        while(t--) {
            snow5g(plain, key, cipher, len);
            res+=cipher[0];
        }
        end = clock();
    }
    double t = (float)(end - start) / CLOCKS_PER_SEC;
    double speed = (len * SIZE / t) / 125000000;
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
     printf("--------speed test Encryption Only(Gbps)----------\n");
     for (int i = 0; i < len_test_case; i++)
     {
          encrypto_speed[i] = speed_test_encode_work(test_case[i], 0);
          decrypto_speed[i] = speed_test_decode_work(test_case[i], 0);
          printf("length: %d, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
     }
        printf("--------speed test Encryption Only(GCM)----------\n");
     for (int i = 0; i < len_test_case; i++)
     {
          encrypto_speed[i] = speed_test_encode_work(test_case[i], 1);
          decrypto_speed[i] = speed_test_decode_work(test_case[i], 1);
          printf("length: %d, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
     }

}

int main()
{
    printf("========SNOW-V========\n");
    speed_test();

    return 0;
}
