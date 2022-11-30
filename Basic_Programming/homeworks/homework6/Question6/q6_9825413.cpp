#include <stdio.h>
#include <math.h>
int mabna(int,int);
int prime(int);
int p(int);
int main()
{
	int a,m,i,m2,z,q,n=2,b;
		scanf("%d%d",&a,&b);
	q=1;z=4;m=2;m2=1;
	while(q)
	{
		for(i=2;i<=z/2;i++) 
		{
		
		}
		if(prime(z)) 
		{
			
			if(p(z)==z) 
			{
				n++;
			}
				if(n==a) {
					printf("%d\n",mabna(z,b));
					q=0;
					
				}
		}
		z++;
	}
	return 0;
}
int prime(int a) //prime
{
	int i;
	for(i=2;i<=a/2;i++)
	{
		if(a%i==0) return 0;
		
	}
	if(i>a/2) return 1;
}
int p(int a) // 123 ...321
{  
 int m2=0;
 	while(a) 
	{ 
		int z=a%10;
		 m2=m2*10+z;
		a/=10;
	}
return m2;
}
int mabna(int a,int b)// dar mabnaie b	
{int m=0,i=0;
		while(a)
	{
		int r=a%10;
		 m=r* pow(10.0,i)+m;
		a/=10;
		i++; 
	}
	int j=0;
	int m3=0;
	while(m)
	{
		int z2=m%b;
		m3+=z2*pow(10.0,j);
		m/=b;
		j++;
	}
	return m3; 
}
