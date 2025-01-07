for i in {1..50} 
do
    ./HIAE_run > HiAE_log_$i
    ./AEGIS_run > AEGIS_log_$i
    ./SNOW-V_run > SNOW-V_log_$i
    ./ROCCA_run > ROCCA_log_$i
    ./ROCCA-S_run > ROCCA-S_log_$i
    echo "Finished loop $i"
done

for i in {1..3}
do
    openssl speed -bytes 16384 -evp aes-256-ctr > AES-256-CTR_log_$i
    openssl speed -bytes 8192 -evp aes-256-gcm > AES-256-GCM_log_$i
    for len in 8192 4096 2048 1024 256 64
    do
        openssl speed -bytes $len -evp aes-256-ctr >> AES-256-CTR_log_$i
        openssl speed -bytes $len -evp aes-256-gcm >> AES-256-GCM_log_$i
    done
done
echo "Finished"
