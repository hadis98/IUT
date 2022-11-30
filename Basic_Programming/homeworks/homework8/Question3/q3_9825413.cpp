#include <stdio.h>
#include <string.h>
int main()
{
	char c2,c3;
	scanf("%c %c",&c2,&c3);
	char s[71];
	scanf("%s",s);
	int i=0;

int d=int(c3) - int (c2) ;
//if(d>20) d=26-d;

	for(i=0;i<strlen(s);i++)
	{ 
	 if(s[i]-d>=97)
	 s[i]=s[i]-d;
	 else 
	 s[i]=s[i]+26-d;

	}
printf("%s",s);
	
	return 0;
}






