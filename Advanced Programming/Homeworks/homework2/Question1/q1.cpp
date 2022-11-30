#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct Node {
    char *data;
    Node *next;
};
Node* find(Node* head, int index){
    Node *temp;
     temp=(Node *)malloc(sizeof(Node));//1
     temp = head;
    for(int i = 0; i < index; i++){
        temp = temp->next;
    }
    return temp;
}
void Insert(Node* head, int index, char* data){
    Node *temp;
    temp=(Node *)malloc(sizeof(Node));//2
    temp = find(head, index-1);//5
    Node *t = (Node*)malloc(sizeof(Node));//3
    t->data=(char*)malloc(sizeof(data)+1);//4
    strcpy(t->data,data);
    t->next = temp->next;
    temp->next = t;
    return;
}
void Delete(Node* head, int index){
    Node *temp ;
     temp=(Node *)malloc(sizeof(Node));
    temp= find(head,index-1);
    Node *t = (Node*)malloc(sizeof(Node));
    t= temp->next;
    temp->next = temp->next->next;
    free(t);
    return;
}
int main(){
Node* head;
head=(Node*)malloc(sizeof(100));
head->data="hello";
printf("%s",head->data);
Insert(head,1,"hadis");
printf("%s",head->next->data);
Delete(head,1);
Insert(head,1,"ghafouri");
printf("%s",head->next->data);
    return 0;
}