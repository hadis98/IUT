#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>

int main()
{
    int client_socket;
    char buffer[256];
    char num1[10];
    char num2[10];
    struct sockaddr_in server_address, client_address;

    if ((client_socket = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {
        printf("error: socket creation failed\n");
        return -1;
    }

    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(6000);
    server_address.sin_addr.s_addr = inet_addr("127.0.0.1");
    scanf("%s",num1);
    scanf("%s",num2);
    sendto(client_socket, (const char *)num1, strlen(num1), MSG_CONFIRM,
           (const struct sockaddr *)&server_address, sizeof(server_address));

    sendto(client_socket, (const char *)num2, strlen(num2), MSG_CONFIRM,
           (const struct sockaddr *)&server_address, sizeof(server_address));

    printf("messages are sent.\n");
    int n, server_address_len;

    n = recvfrom(client_socket, (char *)buffer, 255, MSG_WAITALL, (struct sockaddr *)&server_address, &server_address_len);
    buffer[n] = '\0';
    printf("sum of numbers from server : %s\n", buffer);
    close(client_socket);
    return 0;
}