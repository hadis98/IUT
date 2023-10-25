
### System Calls
 the 8 categories of system calls in POSIX are:

- Process control
    - These system calls are used to create, terminate, and control the execution of processes.
    - For example, fork(2), exec(3), wait(2), exit(3), kill(2), etc.

- File manipulation
    - These system calls are used to create, delete, read, write, and manipulate files and directories.
    - For example, open(2), close(2), read(2), write(2), unlink(2), mkdir(2), etc.

- Device manipulation
    - These system calls are used to access and control devices such as disks, terminals, printers, etc.
    - For example, ioctl(2), readv(2), writev(2), etc.

- Information maintenance
    - These system calls are used to get and set information about the system, processes, files, devices, etc.
    - For example, time(2), gettimeofday(2), uname(2), getpid(2), stat(2), etc.

- Communications
    - These system calls are used to create, delete, and communicate via interprocess communication mechanisms such as pipes, sockets, message queues, shared memory, etc.
    - For example, pipe(2), socket(2), send(2), recv(2), mmap(2), etc.

- Protection
    - These system calls are used to manage the security and access rights of processes, files, devices, etc.
    - For example, chmod(2), chown(2), umask(2), setuid(2), etc.

- Signals
    - These system calls are used to send and handle signals between processes.
    - Signals are a way of notifying processes about events or conditions that require their attention. 
    - For example, signal(2), sigaction(2), kill(2), alarm(3), etc.

- Threads
    - These system calls are used to create, terminate, and synchronize threads within a process. 
    - Threads are a way of executing multiple tasks concurrently within a single process.
    - For example, pthread_create(3), pthread_exit(3), pthread_join(3), pthread_mutex_lock(3), etc.



## Reference
- [pipe system call](https://www.geeksforgeeks.org/pipe-system-call/)
