gcc -O3 -march=armv9-a+crypto HiAE/*.c -o HIAE_run -w
gcc -O3 -march=armv9-a+crypto aegis/*.c -o AEGIS_run -w
gcc -O3 -march=armv9-a+crypto snow-v/*.c -o SNOW-V_run -w
gcc -O3 -march=armv9-a+crypto rocca/rocca.c -o ROCCA_run -w
gcc -O3 -march=armv9-a+crypto rocca/rocca_s.c -o ROCCA-S_run -w
echo "Compilation done"