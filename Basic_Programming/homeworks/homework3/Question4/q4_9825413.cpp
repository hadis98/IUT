#include <stdio.h>
#include <math.h>
int main()
{
	long  int a ,b;
	scanf("%ld%ld",&a,&b);
	if(a>b)
	{
		if(a%2==0)
		{
			if((a/2)>=b)
			printf("%ld",2*b-1);
			else
			printf("%ld",(b-a/2)*2);
		}
		else 
		
		{
			long int m=floor(a/2)+1;
			if(b<=m)
			printf("%ld",2*b-1);
			
			else
			printf("%ld",(b-m)*2);
			
		}
		
	}
	
	else
		{
		if(b%2==0)
		{
			if((b/2)>=a)
			printf("%ld",2*a-1);
			else
			printf("%ld",(a-b/2)*2);
		}
		else 
		
		{
			long int m=floor(b/2)+1;
			if(m>=a)
			printf("%ld",2*a-1);
			
			else
			printf("%ld",(a-m)*2);
			
		}
		
	}
	return 0;
}
