gcc-14 -O3 -march=native HiAE/*.c -o HIAE_run -w
gcc-14 -O3 -march=native aegis/*.c -o AEGIS_run -w
gcc-14 -O3 -march=native snow-v/*.c -o SNOW-V_run -w
gcc-14 -O3 -march=native rocca/rocca.c -o ROCCA_run -w
gcc-14 -O3 -march=native rocca/rocca_s.c -o ROCCA-S_run -w
echo "Compilation done"