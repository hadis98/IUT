#include <stdio.h>
#include <math.h>
int mabna(int ,int,int );
int p(int);
int main()
{
	int a,b,c,d,i=0,m=0;
	scanf("%d%d%d",&a,&b,&c);
	int m3=mabna(a,b,c);

	int e=m3;
	if(p(m3)==e) printf("YES");
	else printf("NO");
	
	
		return 0;
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
int mabna(int a,int b,int c)
{int m=0,i=0;
		while(a)
	{
		int r=a%10;
		 m=r* pow(b,i)+m;
		a/=10;
		i++; 
	}
	int j=0;
	int m3=0;
	while(m)
	{
		int z2=m%c;
		m3+=z2*pow(10.0,j);
		m/=c;
		j++;
	}
	return m3;
	
	
	
	
}
