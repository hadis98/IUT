#include <stdio.h>
#include <string.h>
void open2(char s[]);
void close(char s[]);
int main()
{

   char s[1000];
	int n,j,m;
	scanf("%d",&n);
	for(j=0;j<n;j++)
	{
		scanf("%d",&m);
	 scanf("%s",s);
	 if(m==1) 
	 {open2(s);
	 printf("\n");
	 	
	 }
	 else 
	 {close(s);
	 	printf("\n");
	 }
	}

return 0;
}
void open2(char s[])
{
	char s2[1000];
	int f[1000];
	int n=1,i=0,j=0,z=0;
	while(i<strlen(s))
	{
			if(s[i]==s[i+1])
	{
		
		i++;
		n++;
	}
	else 
	{ s2[z]=s[i];
	    z++;
		i++;
		f[j]=n;
		n=1;
		j++;
	}
	}
	int w=z;
 for(j=0,z=0;z<w;z++,j++)
 {
 	if(f[j]!=1)
 	printf("%c%d",s2[z],f[j]);
 	else printf("%c",s2[z]);
 }	
}
void close(char s[])
{
	
		char s2[1000],s3[1000];
	int f2[1000];
	int n=1,i=0,j=0,z=0,t=0,n2=0,i2;
	while(i<strlen(s)+1)
	{
		if(s[i]>=58 && s[i+1]>=58)
		{
			s3[t]=s[i];
			t++;
			f2[n2]=1;
			n2++;
			i++;
		}
		else 
		{
			s3[t]=s[i];
			t++;
			f2[n2]=s[i+1]-48;
			n2++;
			i+=2;
		}
	}
	int y=t;
	 if(s3[y-1]>=58)
	 {
	 					for(int t1=0,n2=0;t1<y;t1++,n2++)
	{ 
		if(f2[n2]==1) printf("%c",s3[t1]);
		else 
		{
			for(i2=0;i2<f2[n2];i2++) printf("%c",s3[t1]);
		}
	}
	printf("%c",s3[y-1]);
	 }
	 else 
	 {
	 		for(int t1=0,n2=0;t1<y;t1++,n2++)
	{ 
		if(f2[n2]==1) printf("%c",s3[t1]);
		else 
		{
			for(i2=0;i2<f2[n2];i2++) printf("%c",s3[t1]);
		}
	}
	 }
}
