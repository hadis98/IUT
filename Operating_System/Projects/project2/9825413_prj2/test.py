import  os
import random
import logging
import threading

mutex = threading.Lock()
path = "/dev/iutnode"

def thread_function(name):
    logging.info("Thread %s: starting", name)    
    for item in range(1000000):
        instruct = "e,"
        randUser = random.randint(1,99)
        instruct+=str(randUser)
        instruct+=",0,1"
        write_device(path,instruct)
        instruct=''    
    logging.info("Thread %s: finishing", name)

def read_device(path):
    fd = os.open(path,os.O_RDONLY)
    data = os.read(fd,2000)
    print(f'Number of bytes read:{len(data)}')
    print(data.decode())
    os.close(fd)


def write_device(path,command):
    fd = os.open(path,os.O_WRONLY)
    line = str.encode(command)
    os.write(fd,line)    
    os.close(fd)


if __name__ == "__main__":
    format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=format, level=logging.INFO,
                        datefmt="%H:%M:%S")
    threads = list()
    for index in range(2):
        logging.info("Main : create and start thread %d.", index)
        x = threading.Thread(target=thread_function, args=(index,))
        threads.append(x)
        x.start()

    for index, thread in enumerate(threads):
        logging.info("Main    : before joining thread %d.", index)
        thread.join()
        logging.info("Main    : thread %d done", index)

print("read device")
read_device(path)
