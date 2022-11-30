#include <iostream>
using namespace std;
int isINQueue(int [],int,int);
int main(){

int numNaghs = 0,numDisk,numMemory,indexQueue =0;
cin>>numMemory;
cin>>numDisk;
int arrDisk[numDisk],Queue[numMemory];
for (int i = 0; i < numDisk; i++)
    cin>>arrDisk[i];

for (int i = 0; i < numMemory; i++)
    Queue[i]=arrDisk[i];

numNaghs = numMemory;
int j=numMemory;
for (int i = numMemory; i < numDisk; i++)
{
    
   if(!isINQueue(Queue,numMemory,arrDisk[i])){
       indexQueue = j%numMemory;
       Queue[indexQueue] = arrDisk[i];
       numNaghs++;
       j++;
   }

   
}

cout<<numNaghs<<endl;

    return 0;
}
int isINQueue(int arr[],int n,int num){
for(int i=0;i<n;i++){
    if(arr[i] == num)
        return 1;
}
return 0;
}