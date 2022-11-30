#ifdef _MSC_BUILD
#define scanf scanf_s
#endif
#include <stdio.h>
#include <math.h>
int main()
{
	float a, b;
	scanf("%f%f", &a, &b);


	float x = sqrt(pow(a, 2) + pow(b, 2));
	int h = floor(x);

	printf("%d", h);


	return 0;
}
