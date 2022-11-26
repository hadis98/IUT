import pyshark
import os

totPkt=0
totData=0
network_interface = 'lo'
file = "./pysharkOutput.pcap"
output = open(file, "w")
#save liveCapture to a .pcap file and use it later 
capture = pyshark.LiveCapture(interface=network_interface , bpf_filter='port 4040',output_file=file)
capture.sniff(timeout=10)
# try:
#     for pkt in capture:
#         try:
#             totData = totData+ int(pkt.tcp.len)
#             print(totData)
#             totPkt= totPkt + 1
#             print(totPkt)
#         except:
#             pass
# except:
#     pass


# totData = totData*0.000008
# print('whole throughput: ',totData/10)

output.close()

print("number of packets: ",len(capture))

#count number of retransmissions with .pcap file and use display_filter methods:
cap = pyshark.FileCapture('pysharkOutput.pcap', display_filter='tcp.analysis.retransmission')

counter = 0
try:
    for packet in cap:
        try:
            counter+=1
        except:
            print(counter)
            
except:
    pass
print("number of retransmissions: ",counter)

os._exit(1)

