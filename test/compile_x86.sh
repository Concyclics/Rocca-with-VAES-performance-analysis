gcc -O3 -march=native -w HiAE/*.c -o HIAE_run
gcc -O3 -march=native -w aegis/*.c -o AEGIS_run
gcc -O3 -march=native -w snow-v/*.c -o SNOW-V_run
gcc -O3 -march=native -w rocca/rocca.c -o ROCCA_run
gcc -O3 -march=native -w rocca/rocca_s.c -o ROCCA-S_run
echo "Compilation done"
