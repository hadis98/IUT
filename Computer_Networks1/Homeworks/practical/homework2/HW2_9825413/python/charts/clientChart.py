import matplotlib.pyplot as plt
import numpy as np
import json

start_time =[]
end_time =[]
bits_per_second =[0]
num_packets =0
with open('../file.json') as json_file:
    data = json.load(json_file)
    for packet in data["intervals"]:
        num_packets +=1
        start_time.append(packet["streams"][0]["start"])
        end_time.append(packet["streams"][0]["end"])
        bits_per_second.append(round(packet["streams"][0]["bits_per_second"]*0.000001))

print("*"*10,"CLIENT","*"*10)
print('\n\n')
print("number of packets in json file: ",num_packets)
print('\n')
start_time.append(end_time[len(end_time)-1])
# print(start_time)
print("time(start and end) in json file: ",start_time)
print('\n')
print("throughput in json file(in order): ",bits_per_second)
#######################PLOT#######################
x = np.array(start_time)
y = np.array(bits_per_second)
plt.plot(x,y,'bo',x,y,'k')
plt.ylabel('Client Throughput (Mbit/s)', fontsize = 20)
plt.xlabel("Time (s)", fontsize = 20)
plt.show()