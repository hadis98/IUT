#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>

int main(int argc, char *argv[]) // argv[0] = ip  argv[1]=port
{
    int i = 0;
    int clientSocket;
    struct sockaddr_in serverAddr;
    socklen_t addr_size;

    clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(7799);
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);
    char message[1000];
    char buffer[1024];
    addr_size = sizeof serverAddr;
    connect(clientSocket, (struct sockaddr *)&serverAddr, addr_size);
    for (int i = 0; i < 10; i++)
    {

        bzero(buffer, 1024);
        if (i == 9)
        {
            strcpy(message, "bye");
            close(clientSocket);
        }
        else
        {
            strcpy(message, "Hello");
        }

        if (send(clientSocket, message, strlen(message), 0) < 0)
        {
            printf("Send failed\n");
        }
        bzero(buffer, 1024);

        if (recv(clientSocket, buffer, 1024, 0) < 0)
        {
            printf("Receive failed\n");
        }

        printf("Data received: %s\n", buffer);
        bzero(buffer, 1024);
    }

    return 0;
}