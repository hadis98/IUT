#include <stdio.h>
int main()
{
	int a,m,i,m2,z,q,r,n,j;
	scanf("%d",&n);
	for(j=1;j<=n;j++)
	{
		
		scanf("%d",&a);
	
	q=1;
	z=4;
	m=2;
	m2=1;
	if(a==1)
	printf("3\n");
	else
	{
	
	while(q)
	{
		for(i=2;i<=z/2;i++) 
		{
			 r=z%i;
			 if(r==0) break;
		}
		if(i>z/2) 
		{
			m++;
			for(i=2;i<=m/2;i++)
			{
				r=m%i;
				if(r==0) break;
			}
			
			if(i>m/2) 
			{
				m2++;
				if(m2==a) {
					printf("%d\n",z);
					q=0;
					
				}
			}
		}
		z++;
	}
	
		
	}
}
	
	return 0;
}
