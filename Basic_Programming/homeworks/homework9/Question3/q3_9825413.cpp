#include <stdio.h>
#include <string.h>
int main()
{
	
	char s1[101],s2[101],s3[201],s4[201],ch,ch2;
	gets(s1);
	ch=getchar();
	ch2=getchar();
	gets(s2);
int i,m,n;
	if(ch=='*')
	
	{
	s3[0]='1';
	
		for(int i=1;i<=strlen(s1)+strlen(s2)-2;i++)
	{
		s3[i]='0';
	}
	for(i=0;i<=strlen(s1)+strlen(s2)-2;i++)
		printf("%c",s3[i]);
	}
	else 
	{
		if(strcmp(s1,s2)>0)//ex: 100 ,10 ..110
		{
				 n=strlen(s1);//3
	 m=strlen(s2);//2
	s4[0]='1';
	for(int i=1;i<n-m;i++)
	{
		s4[i]='0';
	}
  s4[n-m]='1';
  for (int i=n-m+1;i<n;i++)
  {
  	s4[i]='0';
  }
for(i=0;i<n;i++)
printf("%c",s4[i]);
//printf("%s",s4);
			
		}
		
		else if(strcmp(s1,s2)<0) 
		{
		 n=strlen(s2);
	 m=strlen(s1);
	s4[0]='1';
	for(int i=1;i<n-m;i++)
	{
		s4[i]='0';
	}
  s4[n-m]='1';
  for (int i=n-m+1;i<n;i++)
  {
  	s4[i]='0';
  }

for(i=0;i<n;i++)
printf("%c",s4[i]);	
	
		}
		else 
		{
			s3[0]='2';
			for(int i=1;i<strlen(s1);i++)
			{  s3[i]='0';
				}	
			for(int i=0;i<strlen(s1);i++)
			printf("%c",s3[i]);
		}
		
	}

	return 0;
}
