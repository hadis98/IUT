#include <iostream>
#include <iomanip>
using namespace std;

double getMiddle(double[],int);
double findLowestNumber(double[],double[],int);

int main(){

int n;
cin>>n;
if(n==0)
  return 0;
double array1[n];
double array2[n];

for (int i = 0; i < n; i++)
    cin>>array1[i];

for (int i = 0; i < n; i++)
    cin>>array2[i];

double answer =findLowestNumber(array1,array2,n);
    cout << fixed << setprecision(1) << answer ;
    return 0;
}

double getMiddle(double array[],int n){
    double ans;
    if(n%2==0)
        ans = double(array[n/2]+array[(n/2)-1])/2;
    else
        ans= array[n/2];
    
    return ans;
}

double findLowestNumber(double array1[],double array2[],int n){
    double middle_arr1,middle_arr2,answer;
    int updatedNumEven,updatedNumOdd;
    updatedNumEven = n-(n/2)+1;
    updatedNumOdd = n-(n/2);
    if(n==1){
        answer = double(array1[0]+array2[0])/2;
        return answer;
    }
    if(n==2){
        double min=array1[1];
        double max=array1[0];
        if(array2[1] <min)
            min = array2[1];
       
        if(array2[0]>max)
            max = array2[0];
        answer = double(max+min)/2;
        return answer;
    }
    middle_arr1 = getMiddle(array1,n);
    middle_arr2 = getMiddle(array2,n);

    if(middle_arr1 == middle_arr2)
        return middle_arr1;
    
    if(middle_arr1<middle_arr2){
        if(n%2==0){
            answer = findLowestNumber(array1 + (n/2) -1,array2,updatedNumEven);
            return answer;
        }
        else{
            answer =findLowestNumber(array1+(n/2),array2,updatedNumOdd); 
            return answer;
        }
    }
    else{
         if(n%2==0){
             answer = findLowestNumber(array2 + (n/2) -1,array1,updatedNumEven);
            return answer;
        }
        else{
            answer = findLowestNumber(array2+(n/2),array1,updatedNumOdd);
            return answer;
        }
    }

}