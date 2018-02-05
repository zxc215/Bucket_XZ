from socket import *

HOST = '127.0.0.1'
PORT = 9999

s = socket(AF_INET,SOCK_DGRAM)
s.connect((HOST,PORT))

message = "0x0a0000640x0a0000020x00640x00c8"
s.sendall(message)
s.close()
