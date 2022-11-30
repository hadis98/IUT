#include <stdio.h>
void sort(int[],int);
int main()
{
	int f[20],n,i,temp;
	scanf("%d",&n);
	for(i=0;i<n;i++)
	scanf("%d",&f[i]);
	sort(f,n);
	for(i=0;i<n;i++)
	printf("%d  ",f[i]);
	return 0;
}
void sort(int f[],int n)
{  int i,temp,k=0;
		for(i=0;i<n-1;i++)
	{
		for( int j=0;j<n-1;j++)
		{
			if(f[j]>f[j+1]) 
			{  k=1;
				temp=f[j];
				f[j]=f[j+1];
				f[j+1]=temp;
			}
			
		}
		if(k==0) break;
	}

}
