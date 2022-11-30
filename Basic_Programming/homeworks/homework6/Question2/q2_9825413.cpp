#include <stdio.h>
int factorial(int);
int main()
{
	int a;
	scanf("%d",&a);
	int f=factorial(a);
	printf("%d",f);
	
	return 0;
}
int factorial(int a)
{
	if(a==1 || a==0) return 1;
	else
	
	return a*factorial(a-1);
}
