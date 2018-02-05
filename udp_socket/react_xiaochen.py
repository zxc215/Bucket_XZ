from scapy.all import *
import threading
import binascii
from socket import *
import time
import socket as Soc

HOST = '127.0.0.1'
PORT = 9999

pool = {}

def ServerFunc():
    s = socket(AF_INET,SOCK_DGRAM)
    s.bind((HOST,PORT))
    while True:
        data,address = s.recvfrom(1024)
        print data
        remove_packet(data)
    s.close()


def remove_packet(tuples):
    if tuples in pool:
        for p in pool[tuples]:
            sendp(p,iface = 'enp4s8f2')
        pool[tuples] = []
        print "after remove"
        print pool[tuples]

class FuncThread(threading.Thread):
    def __init__(self, target, *args):
        self._target = target
        self._args = args
        threading.Thread.__init__(self)

    def run(self):
        self._target(*self._args)

def processPacketInNewThread(x) :
    t1 = FuncThread(processPacket, x)
    t1.start()

def processPacket(packet):
    if packet[Ether]:
        eth_src,eth_dst = parse_Ether(packet)

        if packet[IP]:
            #decimal string
            ip_src,ip_dst,proto = parse_IP(packet)
            #hex string
            ip_src_hex = convert_ip_to_hex(ip_src)
            ip_dst_hex = convert_ip_to_hex(ip_dst)
            proto_hex = '{0:#0{1}x}'.format(packet[IP].proto,4)

            if int(packet[IP].proto) == 6:
                #decimal string
                sport,dport = parse_TCP(packet)
                #hex string
                sport_hex = '{0:#0{1}x}'.format(packet[TCP].sport,6)
                dport_hex = '{0:#0{1}x}'.format(packet[TCP].dport,6)
            elif int(packet[IP].proto) == 17:
                #decimal string
                sport,dport = parse_UDP(packet)
                #hex string
                sport_hex = '{0:#0{1}x}'.format(packet[UDP].sport,6)
                dport_hex = '{0:#0{1}x}'.format(packet[UDP].dport,6)


            try:
                tuples = ip_src_hex + ip_dst_hex + sport_hex + dport_hex
                print tuples
                insert_packet(packet,tuples)
                print pool


            except Exception, err:
                print("Exception")
                print(err)

def insert_packet(packet,tuples):
    if tuples in pool:
        pool[tuples].append(packet)
    else:
        pool[tuples] = [packet]

def parse_Ether(packet):
    eth_src = str(packet[Ether].src)
    eth_dst = str(packet[Ether].dst)
    return eth_src,eth_dst

def parse_IP(packet):
    ip_src = str(packet[IP].src)
    ip_dst = str(packet[IP].dst)
    proto = str(packet[IP].proto)
    return ip_src,ip_dst,proto

def parse_TCP(packet):
    sport = str(packet[TCP].sport)
    dport = str(packet[TCP].dport)
    return sport,dport

def parse_UDP(packet):
    sport = str(packet[UDP].sport)
    dport = str(packet[UDP].dport)
    return sport,dport

def convert_ip_to_hex(string):
    return '0x'+binascii.hexlify(Soc.inet_aton(string))

def main():
    t = threading.Thread(target = ServerFunc)
    t.daemon = True
    t.start()
    
    sniff(iface='enp4s8f3', prn=lambda x: processPacketInNewThread(x))


if __name__ == '__main__':
    main()
