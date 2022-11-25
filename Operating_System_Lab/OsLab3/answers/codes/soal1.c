#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

// convert string to ocatal
// argc == number of arguments
int main(int argc, char *argv[])
{
    if (strcmp(argv[1], "-c") == 0)
    {
        open(argv[3], O_CREAT | O_RDWR, strtol(argv[2], NULL, 8));
    }
    else if (strcmp(argv[1], "-w") == 0)
    {
        char str[200];
        fgets(str, 200, stdin);
        int file = open(argv[2], O_CREAT | O_WRONLY, 00755);
        write(file, str, strlen(str));
    }
    else if (strcmp(argv[1], "-r") == 0)
    {
        char readBuffer[256];
        int readFile = open(argv[2], O_RDONLY, 00777);

        if (readFile)
        {
            int haveContent = read(readFile, readBuffer, 256);
            while (haveContent > 0)
            {
                haveContent = read(readFile, readBuffer, 256);
                printf("%s\n", readBuffer);
            }
        }
    }
    else if (strcmp(argv[1], "-m") == 0)
    {
        char name[256];
        // for (int i = strtol(argv[5], NULL, 10); i < strtol(argv[6], NULL, 10); i++){}
        for (int i = atoi(argv[5]); i <=atoi(argv[6]); i++)
        {
            // printf("%s %s %s %s %s %d\n", argv[2], argv[3], argv[4], argv[5], argv[6], i);
            sprintf(name, "%s/%s_%d.%s", argv[2], argv[3], i, argv[4]);
            int file = open(name, O_CREAT);
            close(file);
        }
    }
    return 0;
}