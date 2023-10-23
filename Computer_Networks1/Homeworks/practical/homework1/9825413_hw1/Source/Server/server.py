import socket
import os
import random

def ChooseCommands():
    data ="""
HELP                :show help
LIST                :list files
DWLD filePath       :download file
CD dirName          :change directory
PWD                 :show current directory
QUIT                :exit
    """
    return data

def printWorkingDir():
    path = os.getcwd()
    ans =''
    if path.endswith('main'):
        ans ='/'
        return ans
    else:
        pos = path.index('main')
        ans =path[pos+4:len(path)]
        return ans

def ListItems():
    with os.scandir() as items:
        res =''
        totalSize=0
        for item in items:
            if item.is_file():
                size = item.stat().st_size
                res += f'{item.name} \t {size}b \n'
                totalSize +=size
            elif item.is_dir():
                res += f'> {item.name} \n'
        res += f'total size: {totalSize}b \n'
        return res


def changeDir(conn,data):
    path = os.getcwd()
    if 'main' in path:
        if path.endswith('main') and data =='cd ..':
            message = 'Bad Request!!'
            conn.sendall(message.encode())
        else:
            found =0
            destDir = data[3:]
            with os.scandir() as items:
                for item in items:
                    if destDir == item.name or destDir =='..':
                        os.chdir(destDir)
                        found =1
                        break
                if found:
                    message = 'directory changed successfully'
                    conn.sendall(message.encode())
                else:
                    message = 'Bad Request... directory not found...'
                    conn.sendall(message.encode())

def downloadFile(conn,data):
    found =0
    path = os.getcwd()
    fileName = data[5:]    
    if 'main' in path:        
        items = os.scandir()
        for item in items:
            print(item.name)
            if fileName == item.name:
                found =1
                break
        if found:
            portRandom =random.randrange(3000,50000)
            conn.sendall(str(portRandom).encode())
            dwldSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            dwldSocket.bind((HOST,portRandom))
            dwldSocket.listen()
            conn2 , addr = dwldSocket.accept() #Wait for an incoming connection. Return a new socket representing the connection, and the address of the client.
            with open(fileName,'rb') as destFile:
                conn2.sendall(destFile.read())
                destFile.close()
                conn2.close()
        else:
            conn.sendall('Bad Request....\nWrong Command!!...'.encode())    
        
      
os.chdir('main')
HOST = '127.0.0.1'
PORT = 2121
serverSocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
serverSocket.bind((HOST,PORT))
serverSocket.listen()
conn,addr = serverSocket.accept()
print(f'connected with:{HOST,PORT} ')

while True:
    print('waitaing to receive data.....')
    Data = conn.recv(1024).decode()
    print(f'\nrecieved instruction: {Data}\n')

    if Data =='help':
       conn.sendall(ChooseCommands().encode()) 
    elif Data =='quit':
        break
    elif Data == 'pwd':
        conn.sendall(printWorkingDir().encode())
    elif Data =='list':
        data = ListItems()
        conn.sendall(data.encode())
    elif Data.startswith('dwld'):
        downloadFile(conn,Data)
    elif Data.startswith('cd'):
        changeDir(conn,Data)
    else:
        message = 'Bad Request....\nWrong Command!!...'
        conn.sendall(message.encode())
