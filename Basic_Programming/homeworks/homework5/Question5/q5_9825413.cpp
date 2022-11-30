#include <stdio.h>
#include <math.h>
int main()
{
	int i,z,a,n;
	scanf("%d",&a);
	for(i=1;i<=7;i++)
	{
		int x=pow(2,i);
		int x1=pow(2,i+1);
		if(x<=a && x1>=a) 
		{
			z=a%x;         
			n=2*z+1;
			break;
			
			
		}
	
	}
	printf("%d",n);
	return 0;
}
