#include <stdio.h>
int main()
{
	
long long	int n,i,j,k,m,z;
long	long int sum ;
	scanf("%d%d%d",&n,&k,&m);
long long	int f[100][100];
 long long	int g[100][100];
long long int h[100][100]= {0};
	for(i=0;i<n;i++)
	{
		for(j=0;j<k;j++)
		{
			scanf("%lld",&f[i][j]);
		}
	}
		for(i=0;i<k;i++)
	{
		for(j=0;j<m;j++)
		{
			scanf("%lld",&g[i][j]);
		}
	}
		for(i=0;i<n;i++)
	{
		for(j=0;j<m;j++)
		{ 
		sum=0;
		 for(z=0;z<k;z++)
		 {
		 h[i][j]+=f[i][z]*g[z][j];
		 }
		}
	}
		for(i=0;i<n;i++)
	{
		for(j=0;j<m;j++)
		{
		printf("%lld ",h[i][j]);
		}
		printf("\n");
	}
	
	
	return 0;
}
