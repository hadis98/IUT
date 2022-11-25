#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#define MAXCHILD 7

int main()
{

    pid_t child[MAXCHILD];
    int inChild = 0;
    int status = 0;
    for (int i = 0; i < MAXCHILD; i++)
    {
        child[i] = fork();
        if (child[i] == 0)
        {
            inChild = 1;
            break;
        }
    }
    while (inChild == 1)
    {
        srand(getpid());
        int r = rand() % 10;
        printf("message from child %d: waited for %d seconds\n", getpid(), r);
        sleep(r);
        inChild = -1;
    }

    while (inChild == 0)
    {
        sleep(5);
        // for(int i=0; i<=100000000000; i++); //answer of question2
        for (int i = 0; i < MAXCHILD; i++)
        {
            int alive;
            alive = waitpid(child[i], &status, WNOHANG);
            if (alive == 0)
            {
                printf("child[%d] is active now \n", child[i]);
            }
            else
            {
                printf("child[%d] is dead now \n", child[i]);
                int newChild = fork();
                child[i] = newChild;
                int inChildNew = 0;
                if (newChild == 0)
                {
                    inChildNew = 1;
                }
                while (inChildNew == 1)
                {
                    srand(getpid());
                    int r = rand() % 10;
                    printf("message from child %d: waited for %d seconds\n", getpid(), r);
                    sleep(r);
                    inChildNew = -1;
                }
            }
        }
    }

    return 0;
}