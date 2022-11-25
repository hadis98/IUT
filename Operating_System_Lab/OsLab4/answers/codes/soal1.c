#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{

    while (1)
    {
        if (fork() == 0)
        {            
            printf("son[%d]\n", getpid());
            exit(0);
        }else{
            sleep(2);
            printf("parent[%d]\n",getppid());
            wait(NULL);
        }
    }

    return 0;
}