#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>

#define THREADS 4
#define TIMOUT 10

int sum=0;
void *routine(void *x)
{
    int *t = (int *)malloc(sizeof(int));
    *t = rand() % TIMOUT;
    printf("threadIdx = %d, execution time=%d\n", *(int *)x, *t);
    for (int i = 0; i < *t; i++)
        printf("threadIdx = %d; run = %d\n", *(int *)x, i);
    pthread_exit((void *)t);
}

int main()
{
    pthread_t threads[THREADS];
    int thread_id[THREADS];
    for (int i = 0; i < THREADS; i++)
    {
        thread_id[i] = i;
        pthread_create(&threads[i], NULL, routine, (void *)&thread_id[i]);
    }

    int *retval = (int *)malloc(sizeof(int));
    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], (void **)&retval);
        sum += *retval;
        printf("threadIdx %d finished, return_value = %d \n", i, *retval);
    }
    printf("%d",sum);
    return 0;
}