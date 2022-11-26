import http.client
import json 
class StaticEntryPusher(object):
    def __init__(self,server):
        self.server = server
    def get(self,data):
        ret = self.rest_call({},'GET')
        return json.loads(ret[2])

    def Set(self,data):
        ret = self.rest_call(data,'POST')
        return ret[0] == 200
    
    def remove(self,objtype,data):
        ret = self.rest_call(data,'DELETE')
        return ret[0] == 200
    
    def rest_call(self,data,action):
        path ='/wm/staticentrypusher/json'
        header = {
            'Content-Type':'application/json',
            'Accept':'application/json'
        }
        body = json.dumps(data)
        Conn = http.client.HTTPConnection(self.server, 8080)
        Conn.request(action,path,body,header)
        response = Conn.getresponse()
        ret = (response.status,response.reason,response.read())
        print (ret)
        Conn.close()
        return ret
pusher = StaticEntryPusher('127.0.0.1')

entry1 ={
    "switch":"00:00:00:00:00:00:00:08",
    "name": "entry1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=2"
}

entry2 = {
    "switch": "00:00:00:00:00:00:00:01",
    "name": "entry2",
    "eth_type": "0x0800",
    "ipv4_src": "10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority": "32768",
    "in_port": "4",
    "active": "true",
    "actions": "output=3"
}

entry3 = {
    "switch": "00:00:00:00:00:00:00:02",
    "name": "entry3",
    "eth_type": "0x0800",
    "ipv4_src": "10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority": "32768",
    "in_port": "2",
    "active": "true",
    "actions": "output=3"
}

entry4 = {
    "switch": "00:00:00:00:00:00:00:03",
    "name": "entry4",
    "eth_type": "0x0800",
    "ipv4_src": "10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority": "32768",
    "in_port": "3",
    "active": "true",
    "actions": "output=5"
}

entry5 = {
    "switch": "00:00:00:00:00:00:00:04",
    "name": "entry5",
    "eth_type": "0x0800",
    "ipv4_src": "10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority": "32768",
    "in_port": "2",
    "active": "true",
    "actions": "output=3"
}

entry6 = {
    "switch": "00:00:00:00:00:00:00:05",
    "name": "entry6",
    "eth_type": "0x0800",
    "ipv4_src": "10.0.0.12",
    "ipv4_dst": "10.0.0.8",
    "priority": "32768",
    "in_port": "3",
    "active": "true",
    "actions": "output=2"
}

pusher.Set(entry1)
pusher.Set(entry2)
pusher.Set(entry3)
pusher.Set(entry4)
pusher.Set(entry5)
pusher.Set(entry6)
