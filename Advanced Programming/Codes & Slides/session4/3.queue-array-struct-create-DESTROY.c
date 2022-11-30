#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 6
struct queue{
	int *intArray;
	int front;
	int rear;
	int itemCount;
};
typedef struct queue myqueue;


myqueue* create_q()
{
	myqueue *q1 = (myqueue*)malloc(sizeof(myqueue));
	q1->intArray = (int *)malloc(sizeof(int)*MAX);
	q1->front = 0;
	q1->rear = -1;
	q1->itemCount = 0;
	return q1;

}
void destroy(myqueue * q){
	free(q->intArray);
	free(q);
}
int peek(myqueue* s) {
	return s->intArray[s->front];
}

bool isEmpty(myqueue* s) {
	return s->itemCount == 0;
}

bool isFull(myqueue* s) {
	return s->itemCount == MAX;
}

int size(myqueue* s) {
	return s->itemCount;
}

void insert(int data, myqueue* s) {

	if (!isFull(s)) {

		if (s->rear == MAX - 1) {
			s->rear = -1;
		}

		s->intArray[++s->rear] = data;
		s->itemCount++;
	}
}

int removeData(myqueue* s) {
	int data = s->intArray[s->front++];

	if (s->front == MAX) {
		s->front = 0;
	}

	s->itemCount--;
	return data;
}

int main() {
	/* insert 5 items */
	myqueue* q1;
	q1 = create_q();
	insert(3, q1);
	insert(5, q1);
	insert(9, q1);
	insert(1, q1);
	insert(12, q1);

	// front : 0
	// rear  : 4
	// ------------------
	// index : 0 1 2 3 4 
	// ------------------
	// queue : 3 5 9 1 12
	insert(15, q1);

	// front : 0
	// rear  : 5
	// ---------------------
	// index : 0 1 2 3 4  5 
	// ---------------------
	// queue : 3 5 9 1 12 15

	if (isFull(q1)){
		printf("Queue is full!\n");
	}

	// remove one item 
	int num = removeData(q1);

	printf("Element removed: %d\n", num);
	// front : 1
	// rear  : 5
	// -------------------
	// index : 1 2 3 4  5
	// -------------------
	// queue : 5 9 1 12 15

	// insert more items
	insert(16, q1);

	// front : 1
	// rear  : -1
	// ----------------------
	// index : 0  1 2 3 4  5
	// ----------------------
	// queue : 16 5 9 1 12 15

	// As queue is full, elements will not be inserted. 
	insert(17, q1);
	insert(18, q1);

	// ----------------------
	// index : 0  1 2 3 4  5
	// ----------------------
	// queue : 16 5 9 1 12 15
	printf("Element at front: %d\n", peek(q1));

	printf("----------------------\n");
	printf("index : 5 4 3 2  1  0\n");
	printf("----------------------\n");
	printf("Queue:  ");

	while (!isEmpty(q1)) {
		int n = removeData(q1);
		printf("%d ", n);
	}
	destroy(q1);
	return 0;
}