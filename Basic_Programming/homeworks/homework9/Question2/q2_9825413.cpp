#include <stdio.h>
#include <string.h>
int main()
{
	long int m,n,i,j;
	int k=0;
	scanf("%ld%ld",&m,&n);
	int f1[100000],f2[100000];
	for(i=0;i<m;i++)
	{
		scanf("%lld",&f1[i]);
	}
		for(i=0;i<n;i++)
	{
		scanf("%lld",&f2[i]);
	}
	if(m==n)
	{
		for(i=0;i<n;i++)
		{
			if(f1[i]==f2[i]) 
			{
				k=1;
			}
			
			else 
			{
				k=0;
				break;
			}
		} 
		if(k==0) printf("None");
		if(k==1) printf("Both");
	}
	else if(n>m)
	{
		
		for(i=0;i<m;i++)
		{
			if(f1[i]==f2[i]) 
			{
				k=1;
			}
			else {
				k=0;
				break;
			}
			
		}
		if(k==1) printf("Mohammad Javad");
		if(k==0) printf("None");
	}
	else 
	{
		
				for(i=0;i<n;i++)
		{
			if(f1[i]==f2[i]) 
			{
				k=1;
			}
			else {
				k=0;
				break;
			}
			
		}
		if(k==1) printf("Mostafa");
		if(k==0) printf("None");
		
		
	}
	
}
