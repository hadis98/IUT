#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#define MAXCHILD 5
#define MAXIMUM 20

int main()
{

    pid_t child[MAXCHILD];
    int fd[2];
    int inChild = 0;
    int status = 0;
    char number[10];
    int x = pipe(fd);
    for (int i = 0; i < MAXCHILD; i++)
    {
        child[i] = fork();
        if (child[i] == 0)
        {
            inChild = 1;
            break;
        }
    }
    while (inChild == 1) // child
    {
        close(fd[0]);
        srand(getpid());
        int t = rand() % 10 + 1;
        printf("t=%d\n", t);
        sprintf(number, "%d", t);
        printf("number=%s\n",number);
        write(fd[1], number, 10);
        sleep(t);
    }
    int total = 0;
    while (inChild == 0) // parent
    {
        close(fd[1]);
        printf("in parent");
        while (1)
        {            
            if (read(fd[0], number, 10) > 0)
            {                
                total += atoi(number);
                printf("total = %d\n", total);
            }
            if (total > MAXIMUM)
            {
                kill(0, SIGKILL);
            }
        }
    }

    return 0;
}