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

# %%
ciphers = ["HIAE", "ROCCA", "ROCCA-S", "AEGIS", "SNOW-V"]
ciphers_name = ["HiAE", "Rocca", "Rocca-S", "Aegis", "Snow-V"]
for id in range(0, 1):
    for i in range(200):
        df = addfile_2("Intel Core i7-1360P", f"{ciphers[id]}_log_{i}", ciphers_name[id], df)
df

# %%
df.to_csv("logs.csv", index=False)

# %%
df_avg = df.copy()
df_avg

# %%
df_avg.columns

# %%
df_avg = df_avg.groupby(['Cipher', 'Mode', 'CPU', 'Length']).mean().reset_index()
df_avg

# %%
df_avg.to_csv("logs_avg.csv", index=False)

# %%
CPU_name = 'Intel Core i7-1360P'
Mode_name = 'Encryption Only'
import matplotlib.pyplot as plt
sns.lineplot(data=df_avg[(df_avg['CPU'] == CPU_name) & (df_avg['Mode'] == Mode_name)& (df_avg['Length'] < 17000)], x='Length', y='Speed', hue="Cipher", palette="tab10")
plt.title("LOL family on " + CPU_name + " (VAES) with AEAD Mode")

# %%
ciphers_name = ["HiAE", "Rocca", "Rocca-S", "Aegis", "Snow-V"]
for cipher in ciphers_name:
    s = ""
    for mode in ["Encryption Only", "AEAD"]:
        s += f"& {cipher} "
        for lens in [16384, 8192, 4096, 2048, 1024, 256, 64]:
            s += f" & {df_avg[df_avg["Cipher"].isin([cipher]) & df_avg["Mode"].isin([mode]) & df_avg["Length"].isin([lens])]["Speed"].values[0]:.2f} "
    print(s[1:] + "\\\\")



