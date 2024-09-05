
import os

def runs(chunkid, P4, i1, i2, ACT, chunk, iters = 3):
    cmd = f'icx -Ofast -march=native -maes HAE_test.c HAE_{16}.c -o HAE -D P_4={P4} -D i_1={i1} -D i_2={i2} -w'
    os.system(cmd)
    for iter in range(iters):
        os.system(f'./HAE > log_{chunkid}_{iter}')
        with open(f'log_{chunkid}_{iter}', 'r') as tmp_log:
            lines = tmp_log.readlines()
            for line in lines:
                if 'length:' in line:
                    len, speed_enc, speed_dec = line.split(',')
                    len = len.split()[-1]
                    speed_enc = speed_enc.split()[-1]
                    speed_dec = speed_dec.split()[-1]
                    with open(f'log.csv', 'a+') as f:
                        f.write(f'{chunkid},{P4},{i1},{i2},{ACT},{len},{speed_enc},{speed_dec}\n')
        with open(f'log_{chunkid}_{iter}', 'a+') as tmp_log:
            tmp_log.write(f"\n\n{chunk}")

with open(f'log.csv', 'w') as f:
    f.write("chunkid,P4,i1,i2,S-box,length,speed(enc),speed(dec)\n")

file_path = 'result11.txt'

with open(file_path, 'r', encoding='utf-8') as file:
    lines = file.readlines()

chunks = []
for i in range(0, len(lines), 3):
    chunk = ''.join(lines[i:i + 3])
    chunks.append(chunk)

for index, chunk in enumerate(chunks):
    logtext = f'Chunk {index}:\n{chunk}'
    splited = chunk.split("\n")
    P4 = int(splited[0].split("-")[4])
    ACT = int(splited[0].split("-")[-1])
    i1 = int(splited[1].split("-")[6]) + 1
    i2 = int(splited[1].split("-")[12]) + 1
    logtext +=f"P4: {P4}, i1: {i1}, i2: {i2}\nActived S-Boxes: {ACT}"
    print(f"testing......\n{logtext}\n\n")
    runs(index, P4, i1, i2, ACT, chunk)
        


                    



