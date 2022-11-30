#include <stdio.h>
#include <math.h>
int bmm(long int ,long  int );
int main()
{
	long int j,g;
	scanf("%ld%ld",&j,&g);
	if(j!=0 && g==0) printf("%ld",j);
	else if(bmm(j,g)<0) printf("%ld",-bmm(j,g));
	else
	printf("%ld",bmm(j,g));
	
	
	return 0;
}
int bmm(long int a, long int b)
{ 

	return (a%b==0 ? b: bmm(b,a%b));
}

	
