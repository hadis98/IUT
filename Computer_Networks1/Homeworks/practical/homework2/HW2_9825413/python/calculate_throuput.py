import os
import pyshark


cap = pyshark.FileCapture('pysharkOutput.pcap')	

totPkt=0
totData_tcp=0

ref=float(cap[0].sniff_timestamp)

thr_dict = {}
timediff =0
capturedDatas= 0
packets_length =0
packets_headers =0
try:
    for pkt in cap:
        try:
            # print("packet len: ",pkt.tcp.len)
            # print("captured: ",pkt.captured_length)
            # print("length: ",pkt.length)
            # print(pkt.tcp.hdr_len)
            capturedDatas +=  int(pkt.captured_length)
            packets_length += int(pkt.length)
            #if was tcp:
            try:
                packets_headers += int(pkt.tcp.hdr_len)
                totData_tcp = totData_tcp+ int(pkt.tcp.len)
                # print("header len: ",pkt.tcp.hdr_len)
                
            except :
                pass
            
            # print("captured Datas: ",capturedDatas)
            # print("packets length: ",packets_length)
            totPkt= totPkt + 1
            timediff=float(pkt.sniff_timestamp)-ref
            # print('time: ',timediff)
        except:
            pass

except:
    pass


capturedDatas = capturedDatas *0.000008
packets_length = packets_length * 0.000008
packets_headers = packets_headers * 0.000008
print("total packets: ",totPkt)
print("total packet headers size (Megabit): for TCP",packets_headers)
# print("total Data size(byte) for TCP: ",totData_tcp)
print("all captured packets size:(headers + datas)",capturedDatas)
print("packets_length (headers + datas)",packets_length)
#convert to Megabit
totData_tcp = totData_tcp*0.000008
print("time (s): ",timediff)
print("data size(Mbit): for TCP ",totData_tcp)
print('whole throughput(Mbit/s) for TCP: ',totData_tcp/timediff)
print('whole throughput(round) for TCP: ',round(totData_tcp/timediff))

# print('whole throughput(Mbit/s) for UDP: ',capturedDatas/timediff)
# print('whole throughput(round) for UDP: ',round(capturedDatas/timediff))

os._exit(1)