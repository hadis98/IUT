#include <stdio.h>
int main()
{
	int a,b,c,d,e,f,g,h,i,j;
	    scanf("%d%d",&a,&b);
	
		scanf("%d%d",&c,&d);
	
		scanf("%d%d",&e,&f);
	
	
		scanf("%d%d",&g,&h);
		scanf("%d%d",&i,&j);
	if(a!=c&&a!=e&&a!=g&&a!=i&&c!=e&&c!=g&&c!=i&&e!=g
	&&e!=i&&g!=i&&b!=d&&b!=f&&b!=h&&b!=j&&d!=f&&d!=h&&d!=j
	&&f!=h&&f!=j&&j!=h)
	{
		
		if(a+b!=c+d&&a+b!=e+f&&a+b!=g+h&&a+b!=i+j&&c+d!=e+f&&
		c+d!=g+h&&c+d!=j+i&&e+f!=h+g&&e+f!=i+j&&h+g!=i+j)
		   {
		   	   if(a-b!=c-d&&a-b!=e-f&&a-b!=g-h&&a-b!=i-j&&c-d!=e-f&&c-d!=g-h&&
				  c-d!=i-j&&e-f!=g-h&&e-f!=i-j&&g-h!=i-j)
				  printf("No");
				  else 
				  printf("Yes");
		   }
		else 
		printf("Yes");
	}
	
	else
	printf("Yes");
	
	return 0;
}
