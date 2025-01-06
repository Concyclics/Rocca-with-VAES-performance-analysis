gcc -O3 -march=armv9-a+crypto HiAE/*.c -o HIAE -w
gcc -O3 -march=armv9-a+crypto aegis/*.c -o AEGIS -w
gcc -O3 -march=armv9-a+crypto snow-v/*.c -o SNOW-V -w
gcc -O3 -march=armv9-a+crypto rocca/rocca.c -o ROCCA -w
gcc -O3 -march=armv9-a+crypto rocca/rocca_s.c -o ROCCA-S -w
