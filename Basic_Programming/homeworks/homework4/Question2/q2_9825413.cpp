#include <stdio.h>
#include <math.h>
int main()
{
   double x,n;
   double b=1;
  double z;
  scanf("%lf",&x);
  scanf("%lf",&n);
  int i=1;
while (i<=n-1)
{  
     b=b*i;
  	
	z=z+((double)pow(x,i)/b);
	 i++;
}
printf("%.3lf",z+1);
return 0;
}
