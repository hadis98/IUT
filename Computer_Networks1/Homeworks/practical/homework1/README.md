## FTP Client & Server Python Socket Programming
- In this project i built a client and server for a simplified version of FTP protocol.
- This project uses python socket programming.
- First I explained FTP protocol, how it works, its advantages and disadvantage.
- Then I explained my implementation of client and server program.
- Feel free to ask me about this project or suggest improvements.

## FTP introduction
### What is File Transfer Protocol (FTP) in Application Layer?
- File Transfer Protocol(FTP) is an application layer protocol that moves files between local and remote file systems.
- It runs on top of TCP, like HTTP.
- To transfer a file, 2 TCP connections are used by FTP in parallel: **control connection** and **data connection**.

### Why Use FTP?
- FTP is a standard communication protocol. 
- There are various other protocols like HTTP which are used to transfer files between computers, but they lack clarity and focus as compared to FTP. 
- Moreover, the systems involved in connection are heterogeneous systems, i.e. they differ in operating systems, directories, structures, character sets, etc.
- the FTP shields the user from these differences and transfers data efficiently and reliably. 
- FTP can transfer ASCII, EBCDIC, or image files. 
- The ASCII is the default file share format.
- In ASCII or EBCDIC the destination must be ready to accept files in this mode.
- The image file format is the default format for transforming binary files.


### Mechanism of File Transfer Protocol

- <img width="500px"  src="https://media.geeksforgeeks.org/wp-content/uploads/FTP.jpg"/>

### Types of Connection in FTP

- <img width="400px"  src="https://media.geeksforgeeks.org/wp-content/uploads/20230319113342/FTP-Connections.png"/>

1. **Control Connection**
    - For sending control information like user identification, password, commands to change the remote directory, commands to retrieve and store files, etc.
    - FTP makes use of a control connection.
    - The control connection is initiated on port number 21. 

2. **Data connection**
    - For sending the actual file, FTP makes use of a data connection.
    - A data connection is initiated on port number 20. 
    - FTP sends the control information out-of-band as it uses a separate control connection. 
    - Some protocols send their request and response header lines and the data in the same TCP connection. For this reason, they are said to send their control information in-band. HTTP and SMTP are such examples. 

### FTP Session
- When an FTP session is started between a client and a server, the client initiates a control TCP connection with the server side. 
- The client sends control information over this connection.
- When the server receives this, it initiates a **data connection** to the client side.
- Only one file can be sent over one data connection. 
- But the **control connection** remains active throughout the user session. 
- As we know **HTTP** is **stateless** i.e. it does not have to keep track of any user state.
- But **FTP** needs to maintain a state about its user throughout the session. 

### FTP Clients
- FTP works on a client-server model. 
- The FTP client is a program that runs on the user’s computer to enable the user to talk to and get files from remote computers.
- It is a set of commands that establishes the connection between two hosts, helps to transfer the files, and then closes the connection. 

### Advantages of FTP
- Speed.
- File sharing.
- Efficiency.

### Disadvantages of FTP
- File size limit is the drawback of FTP only 2 GB size files can be transferred.
- Multiple receivers are not supported by the FTP.
- FTP does not encrypt the data this is one of the **biggest drawbacks** of FTP.
- FTP is unsecured, we use login IDs and passwords making it secure but they can be attacked by hackers.

### What is path traversal attack?
- is a type of network attack that allows an attacker to access files and directories that are stored outside the web root folder of an application. 
- This can expose sensitive information, such as application code, configuration files, credentials, or system files, to the attacker
- A path traversal attack can happen when an application uses user input to construct a file path without proper validation or sanitization.
- To prevent path traversal attacks, applications should avoid using user input to construct file paths, or use proper validation and sanitization methods to remove any malicious characters or sequences from the input.
- Applications should also limit the access permissions of the web server user and use chrooted jails or code access policies to restrict the files that can be accessed by the applicationh
## Client program
- After running, the client program must connect to the server. Then start receiving user commands and sending them to the server.
- at the begining of executing client program, we have no other files in the folder of client
- as we can see, the client folder is empty
- <img width="700px"  src="https://i.postimg.cc/t4M7tHX8/image.png"/>

## Implemented FTP Commands in this project:
- HELP: Display list of commands
    - <img width="100%"  src="https://i.postimg.cc/HxTmbc13/image.png"/>
- LIST: To get the list of files and the size of each file.
    - At the end, the total size of all the files in the current folder will be displayed.
    - Folders are marked with a > sign at the beginning of their name
    - <img width="100%"  src="https://i.postimg.cc/fLPHDpCX/image.png"/>
- DWLD filePath: to download filePath from the server
    - after executing this command on client side, we have the specified file in our client folder
    - which means we have downloaded that file.
    - on client side: <img width="300px"  src="https://i.postimg.cc/9045PsJF/image.png"/>
    - on server side: <img width="300px"  src="https://i.postimg.cc/B6j4N8v0/image.png"/>
    - now we have file hi.txt on our client folder
    - <img width="700px"  src="https://i.postimg.cc/zDcvKr0W/image.png"/>
- PWD: Display our current location on the server
- CD dirName: To open the folder specified folder on the server side
    - <img width="700px"  src="https://i.postimg.cc/fbPm8rNg/image.png"/>
    - note: access is restricted to certain directories.
    - user can't access to all directories in server side.
    - after trying to access these restricted parts, user gets error like below.
    - <img width="300px"  src="https://i.postimg.cc/JhgmtbNk/image.png"/>
    - here, the user is trying to access the directory which he/she has not access to it.
    - this is related to the **"path traversal attack"**

## Server program
- we have a directory next to server.py file which is main directory 
- as we can see from below picture, we have different files and folder on our server
- <img width="400px"  src="https://i.postimg.cc/nLG435NZ/image.png"/>
- After running this program, your server program must
    - create a socket on the address 127.0.0.1 and port 2121
    - listen on this port so that the client can connect to it.
- After connecting the client, it must wait for the command to be sent from the client and give an appropriate response to it.
- If the request was to download a file:
    - the server first creates a random number between 3000 and 50000 as the port number for the data channel
    - and creates a **TCP socket** on it and sends the same number to the **client**
    - and waits for the client to connect to it.
- After connecting the client, it sends the entire requested file to the client **in one place** and not in pieces.

## What is a non-persistent connection?
- is a type of connection that is established and terminated for each data transfer. 
- It means that a new connection has to be created for every request and response between the client and the server
- We use non-persistent connection in FTP protocol because it allows us to send the end of file signal by closing the connection.
- This way, we do not need to use any extra protocol or mechanism to indicate the end of file. 

### Disadvantages of non-persistent connection
- It requires more time and resources to set up and tear down the connection for each file transfer
- It does not support concurrent file transfers, which can reduce the efficiency and performance of the FTP protocol.
- It can cause network congestion and overhead due to the frequent opening and closing of connections.
- Therefore, some FTP implementations use persistent connection for data transfer, which means that they keep the connection open until the client or the server decides to close it. 

## References
- [FTP](https://www.geeksforgeeks.org/file-transfer-protocol-ftp-in-application-layer/)
## License
- This project is licensed under [MIT License].
- You can use it for personal or educational purposes as long as you give credit to its author.
## Author
- This project was created by Hadis Ghafouri as first project for Computer Networks1 course at IUT.
- You can contact me by email at hadisghafouri@gmail.com.
