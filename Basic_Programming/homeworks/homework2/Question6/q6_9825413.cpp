#include <stdio.h>
#include <math.h>
int main()
{
	int n;
	scanf("%d",&n);
	
	if(n%2==0)
	{
		int x=((n/2)+1)*((n/2)+1);
		printf("%d",x);
		
	}
	else 
	{
		int z=(floor(n/2)+1)*(floor(n/2)+2);
		printf("%d",z);
		
	}
	
	
	return 0;
	
}




