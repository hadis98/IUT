#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#define THREADS 4
#define TIMOUT 10
#define SIZE 6

int sum = 0;
// int stride = SIZE / 2;
float stride = ((float)SIZE /(float) 2);

int A[SIZE] = {8, 5, -1, 3, 9, 2};

void *routine(void *x)
{

    int num = *(int *)x;
    int i = num;
    printf("i=%d stride=%f  %d , %d\n", i, stride, A[i], A[(i +(int)floor(stride))]);
    if (A[i] > A[(i + (int)floor(stride))])
    {
        printf("swap \n");
        A[i] = A[(i + (int)floor(stride))];
    }

    pthread_exit(NULL);
}

int main()
{
    pthread_t threads[(int)floor(stride)];
    int thread_id[(int)floor(stride)];

    int number = stride;
    printf("s=%f \n", stride);
    for (float s = number; s > 0; s =((float)s/(float) 2))
    {
        printf("s=%f  stride=%f  %f \n", s, stride, floor(stride));
        for (int i = 0; i < stride; i++)
        {
            thread_id[i] = i;
            pthread_create(&threads[i], NULL, routine, (void *)&thread_id[i]);
        }
        for (int i = 0; i < stride; i++)
        {
            pthread_join(threads[i], NULL);
        }
        stride = floor(stride / 2) ;
    }

    printf("Minimum Element is : %d\n", A[0]);
    return 0;
}