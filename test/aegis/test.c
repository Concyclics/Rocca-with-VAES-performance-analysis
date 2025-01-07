/* 
    This program generates test vectors for AEGIS-128L. 

	Note the message length is a multiple of bytes. 
	
	The authentication tag is appended to the ciphertext. 
*/

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "crypto_aead.h"
#include <time.h>
#if defined(__x86_64__)
#include <immintrin.h>
#include <wmmintrin.h>
#elif defined(__ARM_NEON)
#include <arm_neon.h>
#include "sse2neon.h"
#endif

double speed_test_encode_work(size_t len, uint8_t AEAD) {
     uint8_t iv[16];
     memset(iv, 1, 16);
     uint8_t key[16];
     memset(key, 1, 16);
     int SIZE = 65536;
     clock_t start, end;
     int t = SIZE;
     size_t plain_len = len;
     size_t ad_len = 32;
     uint8_t ad[ad_len];
     memset(ad, 1, ad_len);
     uint8_t msg[plain_len];
     uint8_t ciphertext[plain_len];
     memset(msg, 1, plain_len);
     unsigned long long clen = plain_len;
     start = clock();
     while(t--) {
          crypto_aead_encrypt(ciphertext, &clen, msg, plain_len, ad, ad_len, 0, iv, key, AEAD);
     }
     end = clock();
    
     double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
     double speed = ((double) SIZE * plain_len) / (cpu_time_used*(125000000));
     return speed;
}

double speed_test_decode_work(size_t len, uint8_t AEAD) {
     uint8_t iv[16];
     memset(iv, 1, 16);
     uint8_t key[16];
     memset(key, 1, 16);
     int SIZE = 65536;
     clock_t start, end;
     int t = SIZE;
     size_t plain_len = len;
     size_t ad_len = 4096;
     uint8_t ad[ad_len];
     memset(ad, 1, ad_len);
     uint8_t msg[plain_len];
     uint8_t ciphertext[plain_len];
     memset(msg, 1, plain_len);
     unsigned long long clen = plain_len;

     start = clock();
     while(t--) {
          crypto_aead_decrypt(ciphertext, &clen, 0, msg, plain_len, ad, ad_len, iv, key, AEAD);
     }
     end = clock();
    
     double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
     double speed = ((double) SIZE * plain_len) / (cpu_time_used*(125000000));
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
          printf("length: %d, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
     }
     printf("--------speed test AEAD(Gbps)----------\n");
     for (int i = 0; i < len_test_case; i++)
     {
          encrypto_speed[i] = speed_test_encode_work(test_case[i], 1);
          decrypto_speed[i] = speed_test_decode_work(test_case[i], 1);
          printf("length: %d, encrypt: %.2f, decrypt: %.2f\n", test_case[i], encrypto_speed[i], decrypto_speed[i]);
     }

}

int main()
{
     printf("========AEGIS========\n");
     speed_test();
	return 0;
}
