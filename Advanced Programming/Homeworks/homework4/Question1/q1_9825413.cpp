#include <iostream>
using namespace std;
#include <cstring>
struct answer
{
    string type;
    int ans_int;
    float ans_float;
    string ans_string;
}javab[100];

template <class T>
class MYclass
{
    T a;
    T b;
    public:
        MYclass(T x, T y){a=x,b=y;}
        T sum(){return a+b;}
};
template<>
class MYclass <char>
{
    char *a=new char[100];
    char *b=new char[100];
    public:
        MYclass(char * x,char *y){
            strcpy(a,x);
            strcpy(b,y);
        }
        char * concat(){ 
            strcat(a,b);
            return a;
        }
};
int main()
{
    int n,count=0;
cout<<"enter a number: ";
cin>>n;
for (int i = 0; i < n; i++)
{
   string str;
   cin>>str;
   if (str[0]=='s')
   {
     char *a=new char[100];
    char *b=new char[100];
       cin>>a;
       cin>>b;
     MYclass <char>obj1(a,b);
     javab[i].type="string";
     javab[i].ans_string=obj1.concat();
   }
   else if (str[0]=='i')
   {
       int a,b;
       cin>>a;
       cin>>b;
       MYclass <int>obj2(a,b);
       javab[i].type="int";
       javab[i].ans_int=obj2.sum();
   }
   else
   {
       float a,b;
       cin>>a;
       cin>>b;
       MYclass <float>obj3(a,b);
       javab[i].type="float";
       javab[i].ans_float=obj3.sum();
   }
   
   
    
}
for (int i = 0; i < n; i++)
{
    if (javab[i].type=="int")
    {
        cout<<javab[i].ans_int<<endl;
    }
    else if (javab[i].type=="float")
    {
        cout<<javab[i].ans_float<<endl;
    }
    else
    {
        cout<<javab[i].ans_string<<endl;
    }
    
}

return 0;
}
