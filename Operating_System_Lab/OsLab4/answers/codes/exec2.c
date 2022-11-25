#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h> //gettimeofday
#include <time.h>     //time
int main(){
    sleep(5);
    printf("exec2\n");
    return 0;
}