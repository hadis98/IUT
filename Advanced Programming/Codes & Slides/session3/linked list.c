#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct node {
	int data;
	node *next;

};
node * head = NULL;
void insert(int inputData) {
	node* tmp = head;
	if (head == NULL) {
		head = (node*)malloc(sizeof(node));
		head->data = inputData;
		head->next = NULL;
	}
	while (tmp->next != NULL)  //null->next
		tmp = tmp->next;
	node* newNode = (node*)malloc(sizeof(node));
	newNode->data = inputData;
	tmp->next = newNode;
	newNode->next = NULL;

}

void remove(int delData) {

}
node* search(int searchData) {
	node* tmp=head;
	while (tmp->next != NULL) {
		if (tmp->data == searchData)
			return tmp;
		tmp = tmp->next;
	}
	return NULL;
}
int main() {
	node n1;
	node* result=search(2);
	if (result != NULL)
	{
		printf("%d", result->data);
	}
	insert(12);
}
