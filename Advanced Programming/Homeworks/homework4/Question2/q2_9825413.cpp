#include <iostream>
using namespace std;
#include <cstring>
template<class T>
T* add(T a1[],int num1,T a2[],int num2)//********* add two arrays with types (int ,string, float)
{
    T a3[100];
for (int i = 0 , j=0; i < num1 , j<num2 ; i++ , j++)
{
    a3[i]=a1[i];
}

for (int i = num1, j=0; i < num1+num2,j<num2; i++,j++)
{
    a3[i]=a2[j];
}
for (int i = 0; i < num1+num2; i++)
{
    cout<<a3[i]<<" ";
}
return a3;
}
template <class T>
T add(T a,T b)//******* int and float*******
{
    return a+b;
}
bool add (bool a, bool b)// ******* bool *******
{
    return a && b;
}
template <class T>
T *add(T array[],int n,T num)//********* add number to last element in array *********
{
   // T arr[n+1];
   T arr[200];
    array[n]=num;
    for (int i = 0; i < n+1; i++)
    {
        arr[i]=array[i];
    }
        for (int i = 0; i < n+1; i++)
    {
        cout<<arr[i]<<" ";
    }
    return arr;
    
}
template <class T>
T *add(T num,T array[],int n) //********* add number to first place *************
{
    T arr[n+1];
    arr[0]=num;
   for (int i = 0; i < n; i++)
   {
       arr[i+1]=array[i];
   }
    for (int i = 0; i < n+1; i++)
    {
        cout<<arr[i]<<" ";
    }
   return arr;
}
string add(string a,int x)//********** add int to string **************
{
string s=to_string(x);
a=a+s;
return a;
}
string add(string a, double x)//********* add double to string *************
{
string s=to_string(x);
a=a+s;
return a;
}
template <class T>
string add(string a,T arr[],int num)//********** add array to string ********
{
    char b[100];
    int i;
    for (int j = 0; j < num; j++)
    {
        cout<<arr[j]<<" ";
        cout<<arr[j]+'0'<<" ";
    }
    cout<<endl;
    for (i = 0; i <num; i++)
    {
        b[i]=arr[i]+'0';
    }
    b[i]='\0';
    cout<<b<<endl;
    a.append(b);
    cout<<a<<endl;
    return a;
}
string add(string a, string b)//******* add two strings **********
{
    return a.append(b);
}
int main()
{
int a1[5]={6,7,8,9,10};
int a2[5]={1,2,3,4,5};
int size=sizeof(a1)/sizeof(a1[0]);
int size2=sizeof(a2)/sizeof(a2[0]);
double a3[5]={6.2,7.4,8,9.3,10.1};
double a4[5]={1.3,2,3.5,4,5.7};
int size3=sizeof(a3)/sizeof(a3[0]);
int size4=sizeof(a4)/sizeof(a4[0]);
add(a3,size3,a4,size4);
char name1[10]="hadis";
char name2[10]="ghafouri";
int len1=strlen(name1);
int len2=strlen(name2);
add(name1,len1,name2,len2);
cout<<endl;
cout<<add(true,false)<<"*************"<<endl;
int c=3,d=5;
cout<<add(c,d)<<endl;
add(a1,size,4);
cout<<endl;
add(a3,size3,2.2);
cout<<endl;
add(2,a1,size);
cout<<endl;
int p[3]={1,2,3};
float e[3]={1.3,4.5,6.3};
add("hadis",p,3);
add("hadis",e,3);
float r=3.3,y=5.5;
cout<<add(r,y);
string n1="hadis";
string n2="ghafouri";
cout<<endl;
cout<<add(n1,n2)<<endl;
string w1="hadis";
cout<<add(w1,33)<<endl;
cout<<add(w1,3.3)<<endl;
    return 0;
}
