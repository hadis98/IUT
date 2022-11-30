#include <stdio.h>
void swap(int a, int b);
int main()
{
	int a,b;
	
	scanf("%d%d",&a,&b);
	
	swap(a,b);
	printf("a=%d b=%d",a,b);
	
	
	return 0;
}
void swap(int n, int m)
{
	int temp;
	m=n;
	temp=m;
	n=temp;

}
