#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#define MAXCHILD 5
#define MAXIMUM 25

int total = 0;

pid_t pid[MAXCHILD];
void handler(int signo)
{
    char path[20];
    sprintf(path, "1.pipe");
    int pipe, value;
    char buffer[10];
    pipe = open(path, O_RDONLY);
    switch (signo)
    {
    case SIGUSR1:
        bzero(buffer, 10);
        read(pipe, buffer, 10);
        printf("SIGUSR1 received \n");
        printf("pipevalue: %d\n", atoi(buffer));
        value = atoi(buffer);
        bzero(buffer, 10);
        total += value;

        if (total > MAXIMUM)
        {
            printf("total = %d\n", total);
            for (int i = 0; i < MAXCHILD; i++)
            {
                printf("kill child[%d]\n", pid[i]);
                kill(pid[i], SIGKILL);
            }
            exit(0);
        }

        break;
    }
}

int main()
{
    int pipe;
    char path[20];
    sprintf(path, "1.pipe");
    mkfifo(path, 0777);
    char buffer[10];
    bzero(buffer, 10);
    struct sigaction action1;

    sigset_t set1;
    sigemptyset(&set1);
    action1.sa_handler = handler;
    action1.sa_mask = set1;
    action1.sa_flags = 0;
    int inchild = 0;

    sigaction(SIGUSR1, (struct sigaction *)&action1, NULL);

    pid_t parent = getpid();
    for (int i = 0; i < MAXCHILD; i++)
    {
        pid[i] = fork();
        if (pid[i] == 0)
        {
            inchild = 1;
            break;
        }
    }
    while (inchild == 0)
        ;
    while (inchild == 1)
    {
        srand(getpid());
        pipe = open(path, O_RDWR);
        while (1)
        {
            int t = rand() % 10;
            if (t == 0)
                t = 1;
            bzero(buffer, 10);
            sprintf(buffer, "%d", t);
            printf("child[%d]  t=%d\n", getpid(), t);
            write(pipe, buffer, sizeof(buffer));
            bzero(buffer, 10);
            kill(parent, SIGUSR1);
            sleep(t);
        }
        inchild = -1;
    }

    return 0;
}