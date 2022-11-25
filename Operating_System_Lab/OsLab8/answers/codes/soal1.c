#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#define THREADS 4
#define TIMOUT 10
#define SIZE 8

int sum = 0;
int stride = SIZE / 2;
// double stride = SIZE / 2;

int A[SIZE] = {8, 5, -1, 3, 9, 3, 1, 4};


void *routine(void *x)
{

    int num = *(int *)x;
    int i = num;
    printf("i=%d stride=%d  %d , %d\n", i, stride, A[i], A[(i + stride)]);
    if (A[i] > A[(i + stride)])
    {
        printf("swap \n");
        A[i] = A[(i + stride)];
    }

    pthread_exit(NULL);
}

int main()
{
    pthread_t threads[stride];
    int thread_id[stride];

    int number = stride;
    printf("s=%d \n", stride);
    for (int s = number; s > 0; s = s / 2)
    {
        printf("s=%d  stride=%d  %d \n", s, stride, floor((double)stride));
        for (int i = 0; i < stride; i++)
        {
            thread_id[i] = i;
            pthread_create(&threads[i], NULL, routine, (void *)&thread_id[i]);
        }
        for (int i = 0; i < stride; i++)
        {
            pthread_join(threads[i], NULL);
        }
        stride = stride / 2;
    }

    printf("Minimum Element is : %d\n", A[0]);
    return 0;
}