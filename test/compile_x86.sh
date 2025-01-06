gcc -O3 -march=native -w HiAE/*.c -o HIAE
gcc -O3 -march=native -w aegis/*.c -o AEGIS
gcc -O3 -march=native -w snow-v/*.c -o SNOW-V
gcc -O3 -march=native -w rocca/rocca.c -o ROCCA
gcc -O3 -march=native -w rocca/rocca_s.c -o ROCCA-S
echo "Compilation done"
