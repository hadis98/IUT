#include <stdio.h>
#define TRUE 1
#define FALSE 0
int main ()
{
	 int i,a,x,y,z,m;
	 
	 int prime;
	int n;
	scanf("%d",&n);
	for (a = 2; a <n; a++ )
	{
		prime = TRUE;
		for (i = 2; i <= a/2; i++ ) 
			if ((a % i) == 0)
				prime = FALSE;
			if (prime)   
			{   
			
			  x=a%10;
			  y=a/10;
			  m=y%10;
			  z=a/100;
			  if(x==1||y==1||z==1||x==4||x==6||x==8||x==9||y==4||y==6||y==8||y==9||z==4||z==6||z==8||z==9
			  ||m==4||m==6||m==8||m==9||m==1) prime = FALSE;
			   
			   if(a>100 && m==0)prime = FALSE;
				if(prime) 
				printf ("%d ", a);	
			}
			
			
				
	}	
 return 0;
}
