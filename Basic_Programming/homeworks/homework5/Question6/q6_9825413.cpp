#include <stdio.h>
int main()
{
	
	int a,b,n;
	scanf("%d",&n);
	for(a=1;a<=n;a++)
	{
		for(b=1;b<=n;b++)
		{
			if(a==1 || b==1 || a==n || b==n ||
			 a==b || a+b==n+1 || ( a+b>n&& a<=n/2+1 )
			  || ( b>n/2+1&& a>n/2+1 && a+b>n+2 && b>a))
			  printf("#");
			  else printf(" ");
			 
		}
		 printf("\n");
		
	}
	
	
	
	
	return 0;
}
