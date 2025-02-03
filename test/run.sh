echo "Cipher Benchmark" > bench_log
for i in {1..50} 
do
    echo "Round" $i >> bench_log
    echo "bench HiAE" >> bench_log
    ./HIAE_run >> bench_log
    echo "bench AEGIS" >> bench_log
    ./AEGIS_run >> bench_log
    echo "bench SNOW-V" >> bench_log
    ./SNOW-V_run >> bench_log
    echo "bench ROCCA" >> bench_log
    ./ROCCA_run >> bench_log
    echo "bench ROCCA-S" >> bench_log
    ./ROCCA-S_run >> bench_log
    echo "Finished loop $i"
done

echo "Openssl AES" > AES_log
for i in {1..10}
do
    echo "Round" $i >> AES_log
    openssl speed -bytes 16384 -evp aes-256-ctr >> AES_log
    openssl speed -bytes 16384 -evp aes-256-gcm >> AES_log
    for len in 8192 4096 2048 1024 256 64
    do
        openssl speed -bytes $len -evp aes-256-ctr >> AES_log
        openssl speed -bytes $len -evp aes-256-gcm >> AES_log
    done
done
echo "Finished"
