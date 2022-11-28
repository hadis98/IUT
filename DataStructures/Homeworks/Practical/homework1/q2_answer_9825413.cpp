#include<iostream>
#include<math.h>
#include<string>
#include <sstream>
using namespace std;
int mystack[100];
int top = -1;
void push(int x)
{
    mystack[++top] = x;
}

int pop()
{
    int answer = mystack[top];
    mystack[top] =0;
    top--;
    return answer;
}
int calculateNumber(int [] , int);
int isOperator(char);
int calculatExpression(char ,int ,int );
int calculateReverse(int [] , int );
int main(){
    int num1,num2,n3,Enternum,len,numbers[200],x,y,count=0,FinalAnswer;
    string exp;
    cin>>Enternum;
    getchar();
    getline(cin, exp);
    len = exp.length();
    if(isdigit(exp[0]) || (exp[0]=='-' && isdigit(exp[1]))) //******************** postfix ************************
    {
        for (int i = 0; i < len; i++)
        {
            if(isdigit(exp[i])){
                if(isdigit(exp[i+1])){ /// next number is a digit
                    while (isdigit(exp[i]))
                    {
                        numbers[count] = int(exp[i]) - 48;
                        i++;
                        count++;
                    }
                    push(calculateNumber(numbers,count));
                }
                else /// next is a space
                {
                    push(exp[i]-48);
                }
                
            }
            else if(exp[i] == ' ') // if char is space 
                continue;
            else if(exp[i]=='-' && isdigit(exp[i+1])){ // negative number //
                if(isdigit(exp[i+2])){ // number bigger than 1-9
                    count =0;
                   while (isdigit(exp[i+1]))
                    {
                        numbers[count] = int(exp[i+1]) - 48;
                        i++;
                        count++;
                    }
                    push(-(calculateNumber(numbers,count)));
                }

                else  // number is 1-9
                {
                    push(-(exp[i+1]-48));
                    i++;
                }
                   
            }
             else if(isOperator(exp[i])){ // if we have just operator pop from stack and calculate expression //
                num1 = pop();
                num2 = pop();
                push(calculatExpression(exp[i],num1,num2));
                
            }
        }
    FinalAnswer = pop();
    }
    else //***************** prefix ******************
    {
        for (int i = len-1; i >=0; i--) // begin from the end of expression
        {
            if(isdigit(exp[i])){ // if char is digit
                count=0;
                if(isdigit(exp[i-1])){ // if is bigger than 1-9
                    while (isdigit(exp[i]))
                    {
                        numbers[count] =int(exp[i]) - 48;
                        i--;
                        count++;    
                    }
                    int answer = calculateReverse(numbers,count);
                    if(exp[i] == '-') // if it is negative
                        push(-(answer));
                    else 
                        push(answer);

                }
                else // digit is 1-9
                {
                    if(exp[i-1]=='-')
                        push(-(int(exp[i])-48));
                    else 
                        push(int(exp[i])-48);
                }
                    

            }
            else if(exp[i] == ' ')
                continue;
            else if(isOperator(exp[i])){
                num1 = pop();
                num2 = pop();
                push(calculatExpression(exp[i],num2,num1));
            }
        }
        FinalAnswer = pop();
    }
    
cout<<FinalAnswer;
    return 0;
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
int calculateReverse(int arr[] , int n){
int array[100];
int j=n-1;
for (int i = 0; i < n; i++)
{
    array[i] = arr[j];
    j--;
}
return(calculateNumber(array,n));
}

int isOperator(char x){
if(x=='*' || x=='-' || x=='/' || x=='+' || x=='^')
    return 1;
else 
    return 0;
}
int calculatExpression(char op,int num1,int num2){
    int answer;
switch (op)
{
case '*':
{
    answer = num1 * num2;
    break;
}
case '+':
{
    answer = num1 + num2;
    break;
}
case '-':
{
    answer = num2 - num1;
    break;
}
case '/':
{
    answer = num2 / num1;
    break;
}
case '^':
{
    answer = pow(num2,num1);
    break;
}
default:
    break;
}
return answer;
}