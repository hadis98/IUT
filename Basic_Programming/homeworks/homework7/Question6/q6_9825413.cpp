#include <stdio.h>
int main()
{
	int i,n,j,a;
	int c=1;
	scanf("%d",&n);
	for(i=1;i<=n;i++)
	{  c=1;
		for(j=1;j<=i;j++)
		{
			printf("%d ",c);
			c=c*(i-j)/j;
			
		}
		printf("\n");
	}
	
	
	return 0;
}
