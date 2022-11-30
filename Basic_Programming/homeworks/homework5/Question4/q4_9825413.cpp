#include <stdio.h>
int main()
{ 
 int n,a,i,k=0,sum,j,e,v;
 scanf("%d",&n);
 for(j=1;j<=n;j++)
 {  e=0;
    v=0;
 	scanf("%d",&a);
 	int a2=a;
 	while(a2)
 	{
 		a2/=10;
 		v++;
 		
	 }
 	for(i=a-9*v;i<=a;i++,sum=0)
 	{   int j=i;
 		int m=i;
 		while(j)
 		{
 			int z=j%10;
 			sum+=z;
 			j/=10;
		 }
		 if(m+sum==a) 
		 {
		 	printf("Yes\n");
		 	break;
		 }
	
	
	 }
	 if(i>a || e==1) printf("No\n");
 }
	
	return 0;
}
