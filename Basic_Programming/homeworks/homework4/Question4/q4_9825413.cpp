#include <stdio.h>
int main()
{
  int n;
  float a,sum;
  float max=-100;
 float min=100;
  scanf("%d",&n);
  int i=1;
  while (i<=n)
{  
    i++;
	scanf("%f",&a);
	if(a>max)
	max=a;
	if(a<min)
	min=a;
	sum+=a;
}


float avg=sum/n;
printf("Max: %.3f\nMin: %.3f\nAvg: %.3f",max,min,avg);

return 0;
}
