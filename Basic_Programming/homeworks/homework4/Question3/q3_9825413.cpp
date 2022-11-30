#include <stdio.h>
int main()
{
int i=1;
int sum=0;
while(1)
{
	int a;
    
	scanf("%d",&a);
	if(a==-1) break ;
	sum+=a;
	
}

printf("%d\n",sum);
if(sum<160) printf("Fail");
else printf("Pass");


return 0;

}
