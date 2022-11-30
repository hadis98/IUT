#include <stdio.h>
#include <string.h>
void swap(char *a , char *b);
void revers(char s[]);
void extend(char s[], int n);
void shrink(char s[],int n);
void shiftl(char s[],int m);
void shiftr(char s[],int m);
int main()
{
	char s[1000],a[1000];
	gets(s);
	int n=strlen(s);
	while(1)
	{
	   
	    scanf("%s",a);
	    	if(strcmp(a,"EXIT")==0) break;
	    
		if(strcmp(a,"PRINT")==0) printf("%s\n",s);
		
		
			if(strcmp(a,"REVERSE")==0)  revers(s);
	if(strcmp(a,"SHIFT-R")==0)	
	{
		int m;
		scanf("%d",&m);
		shiftr(s,m);
		
	}
	
		if(strcmp(a,"SHIFT-L")==0)	
	{
				int m;
		scanf("%d",&m);
		shiftl(s,m);
	}
	
	
	if(strcmp(a,"EXTEND")==0)	
	{
		int m; scanf("%d",&m);
		extend(s,m);
		
	}
	if(strcmp(a,"SHRINK")==0)
	{
		int m; scanf("%d",&m);
		shrink(s,m);
		
	}
	if(strcmp(a,"PUT")==0)
	{
		int m; scanf("%d",&m);
		char ch,ch2;
		ch=getchar();
		ch2=getchar();
		s[m-1]=ch2;
		
	}
	}

	return 0;
}
void revers(char s[])
{
	int i;
	char f[1000];
	int n=strlen(s);
	for(i=0;i<n/2;i++)
	{
		
			swap(&s[n-i-1],&s[i]);
	}

}
void swap(char *a , char *b)
{
	char temp;
	temp=*a;
	*a=*b;
	*b=temp;
}
void extend(char s[], int n)
{
	char s2[1000];
	int i;
	for(i=0;i<n;i++)
	{
		s2[i]='*';
	}
	s2[n]='\0';
	strcat(s,s2);
	
	
	
}
void shrink(char s[],int n)
{
	char s2[1000];
		int m=strlen(s),j,i;
	for(i=0,j=0;i<m-n,j<m-n;i++,j++)
	{
		s2[j]=s[i];
	}
	s2[j]='\0';
	strcpy(s,s2);
}
void shiftr(char s[],int m)
{
	char s2[1000];
	int i,n=strlen(s);

if(n!=0)
	{	if(m>n) m=m%n;
			for(i=0;i<n;i++)
	{
		s2[i]=s[(n+i-m)%n];
	}
	s2[i]='\0';
	strcpy(s,s2);
	}

}
void shiftl(char s[],int m)
{
		char s2[1000];
	int i,n=strlen(s);
	if(n!=0)
	{
		if(m>n) m=m%n;
	
	for(i=0;i<n;i++)
	{
		s2[i]=s[(i+m)%n];
	}
  s2[i]='\0';
	strcpy(s,s2);	
	}

}

