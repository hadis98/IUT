#include <stdio.h>
int main()
{
	int i=0,a,n=0,f[1000];
	while(1)
	{
		scanf("%d",&a);
		if(a==0) break;
		f[i]=a;
		i++;
		n++;
		
	}
	for(i=n-1;i>=0;i--)
	printf("%d\n",f[i]);
	
	return 0;
}
