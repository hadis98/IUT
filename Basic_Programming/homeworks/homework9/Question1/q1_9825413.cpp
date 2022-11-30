#include <stdio.h>
long long int bmmarr(long long int a[],long long int n);
long long int bmm(long long int a,long long int b);
long long int sumarr(long long int a[],long long int n);
int main()
{ long long int n,i,sum;
long  long int f[1000000];
	scanf("%lld",&n);
	for( i=0;i<n;i++)
	{
		scanf("%lld",&f[i]);
	}
	
	if(bmmarr(f,n)==1) 
	{
		printf("%lld",sumarr(f,n));
	}
	else 
	{  sum=0;
	   long long  int bmm=bmmarr(f,n);
		for(i=0;i<n;i++)
		{
			sum+=f[i]/bmm;
		}
		printf("%lld",sum);
	}
	return 0;
}
long long int bmm(long long int a,long long int b)
{
	if(b==0) return a;
	else return bmm(b , a%b);
	
}
long long  int bmmarr(long long int a[],long long int n)
{
	long long int i,res=a[0];
	for(i=1;i<n;i++)
	{
		res=bmm(a[i],res);
	}
	if(res==1) return  1;
	else return  res;
}
long long int sumarr(long long int a[],long long int n)
{
	long long int i,res=0;
	for(i=0;i<n;i++)
	{
		res+=a[i];
	}
	return res;
}

