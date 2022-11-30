#include <stdio.h>
int main()
{
	float a;
	scanf("%f",&a);
	if(a>0 && a<=50) 
	{
		printf("%.2f",a*0.5);
	printf("%.2f",a*1.2);
	}
	else if(a>50 && a<=150)
	{ float m=25+ (a-50)*0.75;
		printf("%.2f",1.2*m);
	}
	else if(a>150 && a<=250) 
	{
		float m= 100+ (a-150)*1.2;
		printf("%.2f",1.2*m);
	}
	else
	{
		float m= 220+ (a-250)*1.5;
		printf("%.2f",1.2*m);
	}
	return 0;
}
