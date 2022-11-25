#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>

#define N 5
#define THINKING 2
#define HUNGRY 1
#define EATING 0
#define LEFT (id + 4) % N
#define RIGHT (id + 1) % N

int state[N];
int philosephers[N] = {0, 1, 2, 3, 4};

sem_t mutex;
sem_t S[N];

void test(int id)
{
    if (state[id] == HUNGRY && state[LEFT] != EATING && state[RIGHT] != EATING)
    {
        state[id] = EATING;
        printf("Philosopher %d takes fork %d and %d\n", id + 1, LEFT + 1, id + 1);
        printf("Philosopher %d is Eating\n", id + 1);
        int t = rand() % 3;
        sleep(t);
        sem_post(&S[id]); // signal
    }
}

void take_fork(int id)
{
    sem_wait(&mutex);
    state[id] = HUNGRY;
    printf("Philosopher %d is Hungry\n", id + 1);
    test(id);
    sem_post(&mutex);
    sem_wait(&S[id]);
}

void put_fork(int id)
{
    sem_wait(&mutex);
    state[id] = THINKING;
    printf("Philosopher %d putting fork %d and %d down\n",
           id + 1, LEFT + 1, id + 1);
    printf("Philosopher %d is thinking\n", id + 1);
    test(LEFT);
    test(RIGHT);
    sem_post(&mutex);
}

void *philosepher(void *num)
{
    while (1)
    {
        int *i = num;
        int t = rand() % 3;
        sleep(t);
        take_fork(*i);
        t = rand() % 3;
        sleep(t);
        put_fork(*i);
    }
}

int main()
{
    int i;
    pthread_t thread_id[N];
    sem_init(&mutex, 0, 1);

    for (int i = 0; i < N; i++)
    {
        sem_init(&S[i], 0, 0);
    }

    for (int i = 0; i < N; i++)
    {
        pthread_create(&thread_id[i], NULL, philosepher, &philosephers[i]);
        printf("Philosopher %d is thinking\n", i + 1);
    }

    for (i = 0; i < N; i++)
    {
        pthread_join(thread_id[i], NULL);
    }
}