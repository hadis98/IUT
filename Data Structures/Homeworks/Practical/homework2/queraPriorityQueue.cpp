#include <iostream>
#include <bits/stdc++.h>
using namespace std;
struct PriorityQueue
{
    int data;
    int priority;
};
struct PriorityQueue Arr[30],Arr2[30];
int heapSize=0;
int ArrSize=30;
int getRightChild(int index);
int getLeftChild(int index);
int getParent(int index);
void minHeapify(int index);
void decreaseKey(int index,struct PriorityQueue str);
void insert(struct PriorityQueue str);
int extractMin();
int main(){
int number,numbInsertion,tempArr[30];
struct PriorityQueue tempStruct;
cin>>number;
for (int i = 0; i < number; i++)
    cin>>Arr[i].data;
for (int i = 0; i < number; i++)
    cin>>Arr[i].priority;

for (int i = 0; i < number; i++)
    insert(Arr[i]);
cin>>numbInsertion;
for (int i = 0; i < numbInsertion; i++) 
{
    tempArr[i]=extractMin();
    cin>>tempStruct.data>>tempStruct.priority;
    insert(tempStruct);   
}
for(int i=0;i<numbInsertion;i++)
  cout<<tempArr[i]<<" ";
for(int i=0;i<number;i++)
  cout<<extractMin()<<" ";
    return 0;
}

int getRightChild(int index) {
  if((((2*index)+1) < ArrSize) && (index >= 1))
    return (2*index)+1;
  return -1;
}

int getLeftChild(int index) {
    if(((2*index) < ArrSize) && (index >= 1))
        return 2*index;
    return -1;
}

int getParent(int index) {
  if ((index > 1) && (index < ArrSize)) {
    return index/2;
  }
  return -1;
}
void minHeapify(int index) {
  int left_child_index = getLeftChild(index);
  int right_child_index = getRightChild(index);

 
  int smallest = index;

  if ((left_child_index <= heapSize) && (left_child_index>0)) {
    if (Arr2[left_child_index].priority < Arr2[smallest].priority)
      smallest = left_child_index;
    
    else if(Arr2[left_child_index].priority == Arr2[smallest].priority)
       if(Arr2[left_child_index].data<=Arr2[smallest].data)
           smallest = left_child_index;
  }

  if ((right_child_index <= heapSize && (right_child_index>0))) {
    if (Arr2[right_child_index].priority < Arr2[smallest].priority)
      smallest = right_child_index;

    else if(Arr2[right_child_index].priority == Arr2[smallest].priority)
          if(Arr2[right_child_index].data<=Arr2[smallest].data)
            smallest = right_child_index;
  }

 
  if (smallest != index) {
    swap(Arr2[index],Arr2[smallest]);
    minHeapify(smallest);
  }
}

void decreaseKey(int index,struct PriorityQueue str){
    Arr2[index] = str;
    while ((index>1) && (Arr2[getParent(index)].priority>=Arr2[index].priority))
    {
      if(Arr2[getParent(index)].priority == Arr2[index].priority){
        if(Arr2[getParent(index)].data > Arr2[index].data)
            swap(Arr2[index],Arr2[getParent(index)]);
      }
      else 
        swap(Arr2[index],Arr2[getParent(index)]);
        index = getParent(index);
    }
    
}
void insert(struct PriorityQueue str){
    heapSize++;
    decreaseKey(heapSize,str);
}

int extractMin() {
  int minm = Arr2[1].data;
  Arr2[1] = Arr2[heapSize];
  heapSize--;
  minHeapify(1);
  return minm;
}