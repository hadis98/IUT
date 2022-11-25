#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>

#define SERVER_PORT 6000

int main()
{
    int client_socket;
    char buffer[256];
    char file_path[256];

    // making the server address record with a recognized server IP and port
    struct sockaddr_in server;
    server.sin_family = AF_INET;
    server.sin_port = htons(SERVER_PORT);
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    // making socket family = AF_INET, type = SOCK_STREAM , protocol = TCP
    client_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

    // connecting to the server
    if (connect(client_socket, (struct sockaddr *)&server, sizeof(server)) == 0)
        printf("Client is connected to the server!\n");
    else
        printf("Error in connecting to the server\n");

    bzero(file_path, 256);
    scanf("%s", file_path);
    // send(client_socket, file_path, sizeof(file_path), 0);
    write(client_socket, file_path, sizeof(file_path));
    FILE *fp;
    fp = fopen("client_cpy.txt", "w");
    if (fp == NULL)
    {
        printf("Error opening file");
        return 1;
    }

    int n;
    while (1)
    {
        // n = recv(client_socket, buffer, 256, 0);
        n = read(client_socket, buffer, 256);
        if (n <= 0)
        {
            break;
            return;
        }
        fprintf(fp, "%s", buffer);
        bzero(buffer, 256);
    }
    fclose(fp);
    close(client_socket);
    return 0;
}