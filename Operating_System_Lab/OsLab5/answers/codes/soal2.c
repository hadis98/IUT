#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <fcntl.h>
#define MAXCHILD 5
#define MAXIMUM 20

int main()
{

    pid_t child[MAXCHILD];
    int inChild = 0, pipe;
    int status = 0;
    char path[20];
    // char path2[20];
    sprintf(path, "1.pipe");
    mkfifo(path, 0777);    
    // sprintf(path2, "2.pipe");
    char buffer[10];
    bzero(buffer, 10);
    int child_id;
    for (int i = 0; i < MAXCHILD; i++)
    {
        child_id = i;
        child[i] = fork();
        if (child[i] == 0)
        {
            inChild = 1;
            break;
        }
    }
    while (inChild == 1) // child
    {
        printf("child %d starts\n", child_id);
        srand(getpid());
        int t = rand() % 10 + 1;
        sleep(t);
        pipe = open(path, O_RDWR);
        while (1)
        {
            bzero(buffer,10);
            read(pipe, buffer, 10);
            int buf = atoi(buffer);
            printf("child %d pipevalue: %d\n", child_id, buf);
            bzero(buffer,10);
            // pipe2= open(path, O_RDWR);
            if (buf == 0)
            {   bzero(buffer,10);
                sprintf(buffer, "%d", buf);
                write(pipe, buffer, 10);
                bzero(buffer,10);
                printf("child %d reach the point\n", child_id);
                exit(0);
            }
            else if (buf == child_id)
            {
                // pipe2 = open(path, O_RDWR);
                bzero(buffer,10);
                sprintf(buffer, "%d", buf - 1);                                
                write(pipe, buffer, 10);
                bzero(buffer,10);
            }else{                            
                bzero(buffer,10);
                sprintf(buffer, "%d", buf);
                write(pipe, buffer, 10);
                bzero(buffer,10);
            }
        }
        inChild =-1;
    }

    while (inChild == 0) // parent
    {
    pipe = open(path, O_WRONLY);
        bzero(buffer,10);
        sprintf(buffer, "%d", MAXCHILD - 1);       
        write(pipe, buffer, 10);
        bzero(buffer,10);
        for (int i = 0; i < MAXCHILD; i++)
        {
            wait(&status);
        }
        printf("The program finished successfully\n");
        break;
    }

    return 0;
}