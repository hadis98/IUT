// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>
// #include <unistd.h>
// #include "sys/types.h"
// #include <sys/wait.h>
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define MAXCHILD 5

int main()
{

    int child[MAXCHILD];
    int inChild = 0;
    // int status = 0;
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
        // printf("child [%d]\n", getpid());
        for (int i = 0; i < 100000000000; i++);
        inChild = -1;
    }

    while (inChild == 0)
    {
        sleep(1);
        for (int i = 0; i < MAXCHILD; i++)
        {
            
            wait();            
            // if (child_d > 0)
            //     printf("child[%d] is dead now \n", child_d);
            // else if (child_d == -1)
            //     printf("no child to wait for \n");
        }
    }

    return 0;
}