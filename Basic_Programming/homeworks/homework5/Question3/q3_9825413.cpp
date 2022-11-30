#include <stdio.h>
int main()
{
	int a,z,sum=0,m;
	scanf("%d",&a);
	m=a;
	while(a)
	{
		z=a%10;
		sum+=z*z*z;
		
		a/=10;
	}


if(sum ==m) printf("Yes");
else printf("No");
return 0;
}
