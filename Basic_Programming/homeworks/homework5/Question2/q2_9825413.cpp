#include <stdio.h>
int main()
{
int a,n;
scanf("%d%d",&a,&n);
int z=n%7;
int m=(z+a)%7;
switch (m)
{
	case 1: printf("Saturday"); break;
	case 2: printf("Sunday"); break;
	case 3: printf("Monday"); break;
	case 4: printf("Tuesday"); break;
	case 5: printf("Wednesday"); break;
	case 6: printf("Thursday"); break;
	case 7: printf("Friday"); break;
}



return 0;
}
