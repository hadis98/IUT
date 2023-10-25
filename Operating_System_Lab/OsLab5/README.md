
## What is a Pipe?
- Conceptually, a pipe is a connection between two processes, such that the standard output from one process becomes the standard input of the other process. 
- In UNIX Operating System, Pipes are useful for communication between related processes(inter-process communication).
- Pipe is one-way communication only i.e we can use a pipe such that One process write to the pipe, and the other process reads from the pipe.
- It opens a pipe, which is an area of main memory that is treated as a “virtual file”.
- The pipe can be used by the creating process, as well as all its child processes, for reading and writing.
- If a process tries to read before something is written to the pipe, the process is suspended until something is written.
- <img  width="400px" src="https://media.geeksforgeeks.org/wp-content/uploads/Process.jpg">

- ``` C
    Parameters :
    fd[0] will be the fd(file descriptor) for the 
    read end of pipe.
    fd[1] will be the fd for the write end of pipe.
    Returns : 0 on Success.
    -1 on error.
    ```
- Pipes behave FIFO(First in First out), Pipe behave like a queue data structure. 

### Parent and child sharing a pipe
- When we use fork in any process, file descriptors remain open across child process and also parent process.
- If we call fork after creating a pipe, then the parent and child can communicate via the pipe.
- <img width="400px" src="https://media.geeksforgeeks.org/wp-content/uploads/sharing-pipe.jpg">

### Named Pipe or FIFO
- In computing, a named pipe (also known as a FIFO) is one of the methods for inter-process communication. 
- It is an extension to the traditional pipe concept on Unix.
- A traditional pipe is “unnamed” and lasts only as long as the process.
- A named pipe, however, can last as long as the system is up, beyond the life of the process. It can be deleted if no longer used.
- Usually a named pipe appears as a file and generally processes attach to it for inter-process communication.
- A FIFO special file is entered into the filesystem by calling mkfifo() in C.
- Once we have created a FIFO special file in this way, any process can open it for reading or writing, in the same way as an ordinary file.
- However, it has to be open at both ends simultaneously before you can proceed to do any input or output operations on it.

- In order to create a FIFO file, a function calls i.e. mkfifo is used.
    - ``` CPP    
        int mkfifo(const char *pathname, mode_t mode); 
    ```
- mkfifo() makes a FIFO special file with name pathname. Here mode specifies the FIFO’s permissions.



## Reference
- [Pipe System Call](https://www.geeksforgeeks.org/pipe-system-call/)