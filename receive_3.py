from scapy.all import *

sniff(iface = "enp4s8f3", prn = lambda x: hexdump(x))
