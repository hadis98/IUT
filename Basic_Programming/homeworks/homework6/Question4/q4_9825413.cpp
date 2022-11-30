#include <stdio.h>
int prime(int);
int bmm(int, int);
int main()
{
	int a,i,n=1;
	scanf("%d",&a);
	if(a==1) 
	{
		printf("%d",1);
	 } 
	 else
	 {
	 		if(prime(a)) 
	{
		printf("%d",a-1);
	}
	else 
	{
		for(i=2;i<=a;i++)
	if(bmm(a,i)==1) n++;
	printf("%d",n);
		
	}
	 }

	
	
	
	
	return 0;
}
int prime(int a)
{
	int i;
	for(i=2;i<=a/2;i++)
	{
		if(a%i==0) return 0;
	}
	if(i>a/2) return 1;
}
int bmm(int a, int b)
{
	if(a%b==0) return b;
	else
	
	return bmm(b,a%b);
}
