#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>

#define MAX_TRY 3

int counter = 0;

void handler(int signo)
{
    switch (signo)
    {
    case SIGINT:
        counter++;
        printf("Interrupt signal received \n");
        if (counter >= MAX_TRY)
        {
            kill(getpid(), SIGKILL);
        }
        break;
    }
}

int main()
{
    struct sigaction action1;
    action1.sa_handler = handler;
    action1.sa_flags = 0;
    sigaction(SIGINT, (struct sigaction *)&action1, NULL);
    while (1)
        ;
    return 0;
}