import socket 
import os

HOST ='127.0.0.1'
PORT =2121

clientSocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

clientSocket.connect((HOST,PORT))
while True:
    command = input('enter your command:')
    clientSocket.sendall(command.encode())
    if command=='quit' or command=='QUIT':
        break

    Data = clientSocket.recv(1024).decode()
    if command.startswith('dwld') and Data!='Bad Request....\nWrong Command!!...':
        clientSocket2 = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        clientSocket2.connect((HOST,int(Data)))
        fileName = open(os.path.join('.',command[5:]),'wb')
        fileInfo = clientSocket2.recv(1048579)
        if not Data:
            break
        fileName.write(fileInfo)
        fileName.close()
        clientSocket2.close()
        print('file Downloaded')
    else:
        print( Data)
