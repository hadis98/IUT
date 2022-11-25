#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include<time.h>
#define SERVER_PORT 6000

int main(int argc, char *argv[])
{

    int client_socket;
    char buffer[256];
    char data[100];
    int size;
    struct sockaddr_in server;
    server.sin_family = AF_INET;
    server.sin_port = htons(SERVER_PORT);
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    client_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

    if (connect(client_socket, (struct sockaddr *)&server, sizeof(server)) == 0)
        printf("Client is connected to the server!\n");
    else
    {
        printf("Error in connecting to the server\n");
        return -1;
    }
    char temp_num[10];
    while (1)
    {
        size = read(client_socket, buffer, 256);
        buffer[size] = '\0';
        printf("server =>central num= %s\n", buffer);
        srand(time(0));
        int t = rand() % 10;
        sprintf(temp_num,"%d",t);
        printf("temp = %s\n",temp_num);
        // strcat(buffer,temp_num);
        // write(client_socket, buffer, 256);
        write(client_socket, temp_num, sizeof(temp_num));
        bzero(buffer, 256);
        bzero(temp_num, 10);
    }

    return 0;
}