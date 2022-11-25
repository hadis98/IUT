#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <unistd.h>

#define THREADS 3
#define SIZE 4

sem_t sem1;
int product = 0;

int A[SIZE] = {1, 2, 3, 4};
int B[SIZE] = {1, 2, 2, 4};

void *routine(void *x)
{

    printf("threadIdx = %d\n", *(int *)x);
    int num = *(int *)x;
    sem_wait(&sem1);

    for (int i = num; i < SIZE; i += THREADS)
    {
        product += A[i] * B[i];
    }

    sem_post(&sem1);
    pthread_exit(NULL);
}

int main()
{
    sem_init(&sem1, 0, 1);
    pthread_t threads[THREADS];
    int thread_id[THREADS];
    
    printf("array A: \n");
    for (int i = 0; i < SIZE; i++)
    {
        printf("%d ", A[i]);
    }
    printf("\narray B: \n");
    for (int i = 0; i < SIZE; i++)
    {
        printf("%d ", B[i]);
    }

    printf("\n");

    for (int i = 0; i < THREADS; i++)
    {
        thread_id[i] = i;
        pthread_create(&threads[i], NULL, routine, (void *)&thread_id[i]);
    }

    for (int i = 0; i < THREADS; i++)
    {
        pthread_join(threads[i], NULL);
        printf("thread[%d] finished\n", i);
    }

    printf("Product is : %d\n", product);
    return 0;
}