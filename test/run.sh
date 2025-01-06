./HIAE_run > HiAE_log_1
./HIAE_run > HiAE_log_2
./HIAE_run > HiAE_log_3
./AEGIS_run > AEGIS_log_1
./AEGIS_run > AEGIS_log_2
./AEGIS_run > AEGIS_log_3
./SNOW-V_run > SNOW-V_log_1
./SNOW-V_run > SNOW-V_log_2
./SNOW-V_run > SNOW-V_log_3
./ROCCA_run > ROCCA_log_1
./ROCCA_run > ROCCA_log_2
./ROCCA_run > ROCCA_log_3
./ROCCA-S_run > ROCCA-S_log_1
./ROCCA-S_run > ROCCA-S_log_2
./ROCCA-S_run > ROCCA-S_log_3
openssl speed -bytes 16384 -evp aes-256-ctr > AES-256-CTR_log_1
openssl speed -bytes 16384 -evp aes-256-ctr > AES-256-CTR_log_2
openssl speed -bytes 16384 -evp aes-256-ctr > AES-256-CTR_log_3
openssl speed -bytes 8192 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 8192 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 8192 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 4096 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 4096 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 4096 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 2048 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 2048 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 2048 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 1024 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 1024 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 1024 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 256 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 256 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 256 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 64 -evp aes-256-ctr >> AES-256-CTR_log_1
openssl speed -bytes 64 -evp aes-256-ctr >> AES-256-CTR_log_2
openssl speed -bytes 64 -evp aes-256-ctr >> AES-256-CTR_log_3
openssl speed -bytes 16384 -evp aes-256-gcm > AES-256-GCM_log_1
openssl speed -bytes 16384 -evp aes-256-gcm > AES-256-GCM_log_2
openssl speed -bytes 16384 -evp aes-256-gcm > AES-256-GCM_log_3
openssl speed -bytes 8192 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 8192 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 8192 -evp aes-256-gcm >> AES-256-GCM_log_3
openssl speed -bytes 4096 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 4096 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 4096 -evp aes-256-gcm >> AES-256-GCM_log_3
openssl speed -bytes 2048 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 2048 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 2048 -evp aes-256-gcm >> AES-256-GCM_log_3
openssl speed -bytes 1024 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 1024 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 1024 -evp aes-256-gcm >> AES-256-GCM_log_3
openssl speed -bytes 256 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 256 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 256 -evp aes-256-gcm >> AES-256-GCM_log_3
openssl speed -bytes 64 -evp aes-256-gcm >> AES-256-GCM_log_1
openssl speed -bytes 64 -evp aes-256-gcm >> AES-256-GCM_log_2
openssl speed -bytes 64 -evp aes-256-gcm >> AES-256-GCM_log_3
echo "Finished"