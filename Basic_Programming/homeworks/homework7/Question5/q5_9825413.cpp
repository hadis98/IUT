#include <stdio.h>
int main()
{
	int i,j,a,n,f[1000],g[1000],m=0,t=0;
	scanf("%d",&n);
	for(i=0;i<n;i++)
	{
		scanf("%d",&a);
		if(a%2==0) 
		{ 
		   f[m]=a;
		   m++;
		   
		}
		else 
		{
		g[t]=a;
		t++;
		}

	}
	printf("Even: ");
		for(i=0;i<m;i++)
	{
		printf("%d ",f[i]);
	}
	printf("\n");
		printf("Odd: ");
		for(i=0;i<t;i++)
	{
		printf("%d ",g[i]);
	}
	return 0;
	
}





