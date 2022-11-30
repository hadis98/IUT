// A simple C program to show function pointers as parameter 
#include <stdio.h> 
  
// Two simple functions 
void fun1() { printf("Fun1\n"); } 
void fun2() { printf("Fun2\n"); } 
  
// A function that receives a simple function 
// as parameter and calls the function 
void wrapper(void (*fun)()) 
{ 
    fun(); 
} 
  
int main() 
{ 
    wrapper(fun1); 
    wrapper(fun2); 
    return 0; 
}