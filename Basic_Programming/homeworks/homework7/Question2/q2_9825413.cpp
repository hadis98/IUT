#include <stdio.h>
int main()
{
	int a,i,j,n,m,f[20][20],s,d,sum=0,z;
	scanf("%d%d",&n,&m);
	for(i=0;i<n;i++)
	for(j=0;j<n;j++)
	{
		scanf("%d",&f[i][j]);
	}
	for(z=1;z<=m;z++)
	{
		scanf("%d%d",&s,&d);
		i=s-1;
		j=d-1;
		sum+=f[i][j];
	}
	printf("%d",sum);
	return 0;
}
