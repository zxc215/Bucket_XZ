from scapy.all import *
import threading
import time

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
	time.sleep(1)
	sendp(packet, iface = "enp4s8f2")

def main():
	sniff(iface = "enp4s8f3", prn=lambda x: processPacketInNewThread(x))


if __name__ == '__main__':
    main()
