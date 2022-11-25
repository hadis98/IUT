#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h> //gettimeofday
#include <time.h>     //time
int main(){
    sleep(3);
    printf("exec1\n");
    return 0;
}