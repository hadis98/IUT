#include <stdio.h>
int main()
{
	int i,j,a,n,f[100];
	f[0]=5;
	 f[1]=-3;
	 f[2]=1;
	scanf("%d",&n);
	for(i=3;i<=n;i++)
	f[i] = 3*f[i-1] - 2*f[i-2] + f[i-3];
	printf("%d",f[n]);
	return 0;
}
