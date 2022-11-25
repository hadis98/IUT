#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *cientThread(void *arg)
{
    printf("In thread\n");
    char message[1000];
    char input[1000];
    char buffer[1024];
    bzero(buffer, 1024);
    int clientSocket;
    struct sockaddr_in serverAddr;
    socklen_t addr_size;

    // Create the socket.
    pthread_mutex_lock(&lock);
    clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(7799);
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);

    // Connect the socket to the server using the address
    addr_size = sizeof serverAddr;
    connect(clientSocket, (struct sockaddr *)&serverAddr, addr_size);
        
    scanf("%s", input);
    printf("%s \n", input);
    // strcpy(message, "Hello");

    // if (send(clientSocket, message, strlen(message), 0) < 0)
    // {
    //     printf("Send failed\n");
    // }
    bzero(buffer, 1024);    
    if (send(clientSocket, input, strlen(input), 0) < 0)
    {
        printf("Send failed\n");
    }    
    // Read the message from the server into the buffer
    if (recv(clientSocket, buffer, 1024, 0) < 0)
    {
        printf("Receive failed\n");
    }

    printf("Data received: %s\n", buffer);
    bzero(buffer, 1024);
    pthread_mutex_unlock(&lock);
    close(clientSocket);
    pthread_exit(NULL);
}

int main(int argc, char *argv[])//argv[0] = ip  argv[1]=port
{
    int i = 0;
    pthread_t tid[100];
    for (int i = 0; i < 5; i++)
    {
        if (pthread_create(&tid[i], NULL, cientThread, NULL) != 0)
            printf("Failed to create thread\n");
    }

    sleep(5);
    for (int j = 0; j < 5; j++)
    {
        pthread_join(tid[j], NULL);
        printf("thread %d finished\n", j);
    }

    return 0;
}