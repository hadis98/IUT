#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#define SIZE 1024
#define SERVER_PORT 6000
#define MAX_USESRS 5

int main()
{
    char buffer[256];
    char file_path[256];
    int server_socket, client_socket;

    struct sockaddr_in sesrver_address, client_address;
    sesrver_address.sin_family = AF_INET;
    sesrver_address.sin_port = htons(SERVER_PORT);
    sesrver_address.sin_addr.s_addr = inet_addr("127.0.0.1");

    server_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

    bind(server_socket, (struct sockaddr *)&sesrver_address, sizeof(sesrver_address));

    listen(server_socket, MAX_USESRS);
    int clientsize = sizeof(client_address);
    if ((client_socket = accept(server_socket, (struct socaddr *)&client_address, &(clientsize))) >= 0)
        printf("A connection from a client is recieved\n");
    else
        printf("Error in accepting the connection from the client\n ");

    FILE *fp;
    char ch;
    char data[SIZE] = {0};
    bzero(file_path, 256);
    read(client_socket, file_path, 256);
    printf("%s\n", file_path);
    fp = fopen(file_path, "r");
    if (fp == NULL)
    {
        printf("Error opening file");
        return 1;
    }
    printf("contents of file:\n");
    // first solution
    /*
    while (fgets(data, SIZE, fp) != NULL)
    {

        printf("%s", data);
        if (write(client_socket, data, sizeof(data)) == -1)
        {
            perror("Error in sending data(server)");
            exit(1);
        }
    }
    */

    // second solution

    do
    {
        char c = fgetc(fp);
        if (c != -1 && write(client_socket, &c, 1) != 1)
        {
            perror("Error in sending data(server)");
            exit(1);
        }
        if (feof(fp))
            break;
        printf("%c", c);
    } while (1);

    printf("\ncontents of file %s sent to client successfully\n", file_path);
    fclose(fp);
    return 0;
}