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
    int server_socket;
    char buffer[256];
    char buffer2[256];
    char hello_msg[256];
    struct sockaddr_in server_address, client_address;

    if ((server_socket = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {
        printf("error: socket creation failed\n");
        return -1;
    }

    // Filling server information
    server_address.sin_family = AF_INET;
    server_address.sin_addr.s_addr = inet_addr("127.0.0.1");
    server_address.sin_port = htons(6000);

    if (bind(server_socket, (const struct sockaddr *)&server_address, sizeof(server_address)) < 0)
    {
        printf("error: bind failed\n");
        return (-1);
    }

    while (1)
    {
        int client_address_len = sizeof(client_address);
        int n1, n2;
        n1 = recvfrom(server_socket, (char *)buffer, 255, MSG_WAITALL, (struct sockaddr *)&client_address, &client_address_len);
        buffer[n1] = '\0';

        n2 = recvfrom(server_socket, (char *)buffer2, 255, MSG_WAITALL, (struct sockaddr *)&client_address, &client_address_len);
        buffer2[n2] = '\0';

        printf("A message from a client: %s\n", buffer);
        printf("A message from a client: %s\n", buffer2);
        sprintf(hello_msg, "%d", atoi(buffer) + atoi(buffer2));

        sendto(server_socket, (const char *)hello_msg, strlen(hello_msg), MSG_CONFIRM,
               (const struct sockaddr *)&client_address, client_address_len);
        printf("sum of numbers sent to the client.\n");
    }

    return 0;
}