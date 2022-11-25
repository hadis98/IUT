#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdlib.h>
#include <semaphore.h>
#include <signal.h>
#define SERVER_PORT 6000
long long int central_num = 1;
sem_t mutex;

struct thread_vals
{
    int id;
    int client_idx;
};

void *routine(void *x)
{

    struct thread_vals *current = (struct thread_vals *)x;
    printf("id = %d\n", *(int *)x);
    int client_idx = current->client_idx;
    int id = current->id;
    char buffer[256];
    char data[256];
    int size;
    bzero(data, 256);
    bzero(buffer, 256);

    while (1)
    {
        sem_wait(&mutex);
        bzero(data, 256);
        sprintf(buffer, "%lld", central_num);
        write(client_idx, buffer, 256);
        bzero(buffer, 256);
        size = read(client_idx, data, 256);
        data[size] = '\0';
        int added_value = atoi(data);
        central_num += added_value;
        printf("recived value = %d\n", added_value);
        printf("central number = %lld\n", central_num);

        if (central_num % 3 == 0)
        {
            printf("ROUTINE:player %d won the game and central value is %lld\n", id, central_num);
             kill(0, SIGKILL);
            // exit(0);
            pthread_exit((void *)added_value);
        }
        else
        {
            sem_post(&mutex);
            pthread_exit((void *)added_value);
        }
    }
}

int main(int argc, char *argv[])
{
    if (argc < 1)
    {
        printf("not enough args");
        return -1;
    }
    sem_init(&mutex, 0, 1);
    int max_player = atoi(argv[1]);
    int server_socket, client_socket[max_player];

    struct sockaddr_in server_address, client_address[max_player];
    struct thread_vals values[max_player];

    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(SERVER_PORT);
    server_address.sin_addr.s_addr = inet_addr("127.0.0.1");

    server_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    bind(server_socket, (struct sockaddr *)&server_address, sizeof(server_address));
    listen(server_socket, max_player);

    int clientsize = sizeof(client_address[0]);
    pthread_t threads[max_player];

    for (int i = 0; i < max_player; i++)
    {

        if ((client_socket[i] = accept(server_socket, (struct sockaddr *)&client_address[i], &(clientsize))) >= 0)
        {
            values[i].id = i;
            values[i].client_idx = client_socket[i];
            printf("connection created\n");
            pthread_create(&threads[i], NULL, routine, (void *)&values[i]);
        }
        else
        {
            printf("Error from the client\n ");
            return -1;
        }
    }

    int *retval = (int *)malloc(sizeof(int));

    for (int i = 0; i < max_player; i++)
    {
        pthread_join(threads[i], (void **)&retval);
        printf("player %d played, added %d to the central value and the new central value is %lld\n", i, retval, central_num);
        if (central_num % 3 == 0)
        {
            printf("player %d won the game and central value is %lld\n", i, central_num);
            kill(0, SIGKILL);
        }
        close(client_socket[i]);
    }

    printf("server is closed");
    return 0;
}