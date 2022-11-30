#include <stdio.h>
int main()
{
	
		int a,i,j,n,m,f[20][20],s,d,sum=0,z;
	scanf("%d",&n);
	for(i=0;i<n;i++)
	{
			for(j=0;j<n;j++)
	{
		if(i+j==n-1 || i==j) printf("1");
		else printf("0");
	}
		printf("\n");
	}

	
	return 0;
}
