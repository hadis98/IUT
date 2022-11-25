#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#define SIG_IGN ((__sighandler_t) 1)
#define SIGINT 2
void INThandler(int);

FILE *f;
main(int argc, char *argv[])
{
    signal(SIGINT, INThandler);
    char address[200];
    char buffer[300];
    scanf("%s", address);

    pid_t child;
    pid_t tpid;

    f = fopen("log.txt", "w");
    if (f == NULL)
    {
        printf("Error opening the file");
        return -1;
    }
    fprintf(f,"log.txt\n-------------------------------------------------------------\n");
    fprintf(f,"Date \t\t Time \t\t Execution Time \t path \n-------------------------------------------------------------\n");
    int status;
    struct timeval start, stop;
    double time_taken;
    gettimeofday(&start, NULL);
    child = fork();
    int inChild = 0;
    if (child == 0)
    {
        inChild = 1;
    }

    while (inChild == 1)
    {        
        execvp(address, NULL);
        inChild = -1;
    }

    while (inChild == 0)
    {
        sleep(1);
        pid_t tpid;
        tpid = wait(&status);
        gettimeofday(&stop, NULL);
        long sec = stop.tv_sec - start.tv_sec;
        float m1 = start.tv_usec;
        float m2 = stop.tv_usec;
        long elapsed = sec * 1000 + (m2 - m1) / 1000;
        time_t timestamp = time(NULL);
        struct tm *now = localtime(&timestamp);
        printf("%4d-%02d-%02d \t %02d:%02d:%02d \t %ld \t %s\n",
               now->tm_year + 1900, now->tm_mon + 1, now->tm_mday,
               now->tm_hour, now->tm_min, now->tm_sec, elapsed, address);
        fprintf(f, "%4d-%02d-%02d \t %02d:%02d:%02d \t %ld \t\t %s\n-------------------------------------------------------------\n",
                now->tm_year + 1900, now->tm_mon + 1, now->tm_mday,
                now->tm_hour, now->tm_min, now->tm_sec, elapsed, address);        
        scanf("%s", address);
        gettimeofday(&start, NULL);
        int newChild = fork();
        if (newChild == 0)
        {
            execvp(address, NULL);
        }
    }
    fclose(f);
}

void INThandler(int sig)
{
    char c;
    signal(sig, SIG_IGN);
    fclose(f);
    exit(0);
}