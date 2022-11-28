#include <iostream>
using namespace std;
#include <bits/stdc++.h>

int partition (int arr[], int low, int high);
void quickSort(int arr[], int low, int high);
int calculateNumber(int arr[] , int n);
int main(){
string str;
getline(cin,str);
int len = str.length();
int arr[50000],count=0,calcArray[500],finalCount=0; 
for(int i=0;i<len;i++)
    if(isdigit(str[i])){
        if(isdigit(str[i+1])){
            count = 0;
         while (isdigit(str[i]))
        {
            calcArray[count] = int(str[i])-48;
            i++;
            count++;
        }
            arr[finalCount] = calculateNumber(calcArray,count);
          
        }
        else 
            arr[finalCount] = int(str[i])-48;
        
            finalCount++;
    }
        else if(str[i]=='-'){
        if(isdigit(str[i+2])){
         count = 0;
         while (isdigit(str[i+1]))
        {
            calcArray[count] = int(str[i+1])-48;
            i++;
            count++;
        }
            arr[finalCount] = -calculateNumber(calcArray,count);
        }
        else 
        {
            arr[finalCount] = -(int(str[i+1])-48);
            i++;
        }
            
        finalCount++;
    }

quickSort(arr,0,finalCount-1);
for(int i=0;i<finalCount;i++)
    cout<<arr[i]<<" ";

    return 0;
}
int partition (int arr[], int low, int high)  
{  
    int pivot = arr[high]; 
    int i = (low - 1); 
  
    for (int j = low; j <= high - 1; j++)  
    {  
        
        if (arr[j] < pivot)  
        {  
            i++; 
            swap(arr[i], arr[j]);  
        }  
    }  
    swap(arr[i + 1], arr[high]);  
    return (i + 1);  
}  
  
void quickSort(int arr[], int low, int high)  
{  
    if (low < high)  
    {  

        int pi = partition(arr, low, high);  
        quickSort(arr, low, pi - 1);  
        quickSort(arr, pi + 1, high);  
    }  
}  
int calculateNumber(int arr[] , int n){
    int number = 0;
    int j=n-1;
for (int i = 0; i < n; i++)
{
    number += arr[i] * pow(10,j);
    j--;
}
return number;
}