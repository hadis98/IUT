#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <fcntl.h>  // for open
#include <unistd.h> // for close
#include <pthread.h>

char client_message[2000];
char buffer[1024];
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *socketThread(void *arg)
{
    int newSocket = *((int *)arg);
    bzero(client_message, 2000);

    while (1)
    {
        recv(newSocket, client_message, 2000, 0);
        // printf("client: %s \n", client_message);
        if (client_message == "bye")
        {
            printf("byyyyyyyyyy client\n");
            exit(0);
        }
        pthread_mutex_lock(&lock);
        char *message = malloc(sizeof(client_message) + 20);
        strcpy(message, "Hello Client");
        strcpy(buffer, message);
        printf("buffer: %s\n", buffer);
        free(message);
        sleep(1);
        send(newSocket, buffer, sizeof buffer, 0);
        pthread_mutex_unlock(&lock);
    }

    // pthread_mutex_unlock(&lock);

    printf("Exit socketThread \n");
    close(newSocket);
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    int serverSocket, newSocket;
    struct sockaddr_in serverAddr;
    struct sockaddr_storage serverStorage;
    socklen_t addr_size;

    // Create the socket.
    serverSocket = socket(PF_INET, SOCK_STREAM, 0);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(argv[1]);
    serverAddr.sin_addr.s_addr = inet_addr(argv[0]);

    memset(serverAddr.sin_zero, '\0', sizeof serverAddr.sin_zero);

    bind(serverSocket, (struct sockaddr *)&serverAddr, sizeof(serverAddr));

    if (listen(serverSocket, argv[2]) == 0)
        printf("Listening\n");
    else
        printf("Error\n");
    pthread_t tid[atoi(argv[2])];
    int i = 0;
    int num_threads = atoi(argv[2]);
    while (1)
    {
        // Accept call creates a new socket for the incoming connection
        addr_size = sizeof serverStorage;
        newSocket = accept(serverSocket, (struct sockaddr *)&serverStorage, &addr_size);

        if (pthread_create(&tid[i++], NULL, socketThread, &newSocket) != 0)
            printf("Failed to create thread\n");

        if (i >= num_threads)
        {
            i = 0;
            while (i < num_threads)
            {
                pthread_join(tid[i++], NULL);
            }
            i = 0;
        }
    }
    return 0;
}