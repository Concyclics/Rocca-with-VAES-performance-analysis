# %%
import pandas as pd
import seaborn as sns

# %%
df = pd.DataFrame(columns=["Cipher", "Mode", "CPU", "Length", "Speed"])


# %%
def addfile_2(cpu, filename, cipher, dftmp):
    with open(filename, "r", encoding="utf8", errors='ignore') as f:
        lines = f.readlines()
        for line in lines:
            if "---" in line:
                line = line.replace("-", '').replace("(Gbps)", "")
                mode = line.replace("speed test", "").strip()
                if "GCM" in mode:
                    mode = "AEAD"
            elif "length" in line:
                length, speed = line.split(',')[:2]
                length = int(length.split(":")[1])
                speed = float(speed.split(":")[1])
                dftmp = pd.concat([dftmp, pd.DataFrame([[cipher, mode, cpu, length, speed]], columns=dftmp.columns)], ignore_index=True)
    return dftmp

def addfile_3(cpu, filename, dftmp):
    with open(filename, "r", encoding="utf8", errors='ignore') as f:
        lines = f.readlines()
        for i in range(len(lines)):
            if "type" in lines[i] and "bytes" in lines[i]:
                #type           8192 bytes
                length = int(lines[i].split()[1])
                speed = float(lines[i+1].split()[1][:-2]) / 1000 / 1000 * 8
                cipher = lines[i+1].split()[0].upper()
                if "GCM" in cipher or "gcm" in cipher:
                    mode = "AEAD"
                else:
                    mode = "Encryption Only"
                dftmp = pd.concat([dftmp, pd.DataFrame([[cipher, mode, cpu, length, speed]], columns=dftmp.columns)], ignore_index=True)
    return dftmp

def addfile_4(cpu, filename, dftmp):
    with open(filename, "r", encoding="utf8", errors='ignore') as f:
        lines = f.readlines()
        for line in lines:
            if "====" in line:
                cipher = line.replace("=", '').replace("test", "").strip()
            if "---" in line:
                line = line.replace("-", '').replace("(Gbps)", "")
                mode = line.replace("speed test", "").strip()
                if "GCM" in mode:
                    mode = "AEAD"
            elif "length" in line:
                length, speed = line.split(',')[:2]
                length = int(length.split(":")[1])
                speed = float(speed.split(":")[1])
                dftmp = pd.concat([dftmp, pd.DataFrame([[cipher, mode, cpu, length, speed]], columns=dftmp.columns)], ignore_index=True)
    return dftmp


# %%
# %%
df = pd.DataFrame(columns=["Cipher", "Mode", "CPU", "Length", "Speed"])
df = addfile_4("E5-2620v3", "./E5-2620v3/bench_log", df)
df

# %%
#Devices = ["Apple M1", "Apple M2 Max", "Apple M3 Pro", "AMD EPYC 9334", "Intel Xeon Gold 6326", "Intel Xeon Gold 6230", "Intel Xeon Silver 4108", "Intel Xeon E5-2620 v3", "AMD EPYC 7763", "AMD Ryzen 9 7950X", "Intel Core i9-13980HX"]
Devices = ["AMD EPYC 9334", "Intel Xeon Gold 6326", "Intel Xeon E5-2620 v3", "AMD Ryzen 9 7950X", "Apple M3 Pro", "HiSilicon Kunpeng 920", "HiSilicon Kunpeng 920X"]
#Devices_dir = ["M1", "M2Max", "M3Pro", "EPYC9334", "IceLake", "Xeon6230", "Xeon4108", "E5-2620v3", "EPYC7763", "7950X", "13980HX"]
Devices_dir = ["EPYC9334", "IceLake", "E5-2620v3", "7950X", "M3Pro", "Kunpeng920", "Kunpeng920X"]
df = pd.DataFrame(columns=["Cipher", "Mode", "CPU", "Length", "Speed"])
for device_id in range(len(Devices)):
    df = addfile_4(Devices[device_id], f"{Devices_dir[device_id]}/bench_log", df)
    df = addfile_3(Devices[device_id], f"{Devices_dir[device_id]}/AES_log", df)
df

# %%
df = df[df["Length"].isin([64, 256, 1024, 2048, 4096, 8192, 16384])]
df

# %%
df["Cipher"].unique()

# %%
df.to_csv("logs.csv", index=False)
#对每一类去掉最大最小值进行平均
for CPU in df["CPU"].unique():
    for cipher in df["Cipher"].unique():
        for mode in df["Mode"].unique():
            for length in df["Length"].unique():
                df_tmp = df[(df["CPU"] == CPU) & (df["Cipher"] == cipher) & (df["Mode"] == mode) & (df["Length"] == length)].copy()
                print(length, CPU, cipher, mode, len(df_tmp))
                #df = df.drop(df_tmp["Speed"].idxmin())
df_avg = df.groupby(['Cipher', 'Mode', 'CPU', 'Length']).mean().reset_index()
df_avg.to_csv("logs_avg.csv", index=False)
df_avg

# %%


# %%
CPU_name = "Intel Core i9-13980HX"
Mode_name = 'AEAD'
import matplotlib.pyplot as plt
sns.lineplot(data=df_avg[(df_avg['CPU'] == CPU_name) & (df_avg['Mode'] == Mode_name)& (df_avg['Length'] < 17000) & (df_avg['Length'] >=64)], x='Length', y='Speed', hue="Cipher", palette="tab10")
plt.title("Benchmark on " + CPU_name)

# %%
#Devices = ["Apple M1", "Apple M2 Max", "Apple M3 Pro", "AMD EPYC 9334", "Intel Xeon Gold 6326", 
#          "Intel Xeon Gold 6230", "Intel Xeon Silver 4108", "Intel Xeon E5-2620 v3", "AMD EPYC 7763",
#            "AMD Ryzen 9 7950X", "Intel Core i9-13980HX"]
ciphers_name = ["HiAE", "Rocca", "Rocca-S", "AEGIS", "SNOW-V", "AES-256"]
for device in Devices:
    print("\\multicolumn{16}{|c|}{\\textbf{" + device + "}}\\\\\n\\hline")
    for cipher in ciphers_name:
        s = ""
        for mode in ["Encryption Only", "AEAD"]:
            if cipher == "SNOW-V":
                if mode == "AEAD":
                    s += f"& SNOW-V-GCM "
                else:
                    s += f"& SNOW-V "
            elif cipher == "AEGIS":
                s += f"& AEGIS-128L "
            elif cipher == "HiAE":
                s += f"& HiAE (this work) "
            elif "AES-256" in cipher:
                if mode == "AEAD":
                    cipher = "AES-256-GCM"
                else:
                    cipher = "AES-256-CTR"
                s += f"& {cipher} "
            else:
                s += f"& {cipher} "
        
            for lens in [16384, 8192, 4096, 2048, 1024, 256, 64]:
                speed_value = df_avg.loc[(df_avg["Cipher"] == cipher) & (df_avg["Mode"] == mode) & (df_avg["Length"] == lens) & (df_avg["CPU"] == device), "Speed"].values
                if len(speed_value) > 0:
                    if speed_value[0] == max(df_avg.loc[(df_avg["Mode"] == mode) & (df_avg["Length"] == lens) & (df_avg["CPU"] == device), "Speed"].values):
                        s += " & \\textbf{" f"{speed_value[0]:.2f}" + "} "
                        #s += f" & {speed_value[0]:.2f} "
                    else:
                        s += f" & {speed_value[0]:.2f} "
                else:
                    s += " & N/A "
        print(s[1:] + "\\\\")
    print("\\hline")


