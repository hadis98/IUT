#include <stdio.h>
#include <string.h>
int main()
{   
  int i,j;
	char s[50];
	char s2[50];
	char s3[100];
	scanf("%s",s);
	scanf("%s",s2);
		while(s[i]!='\0')
	{
		s3[j]=s[i];
		i++;
		j++;
	}
	i=0;
	while(s2[i]!='\0')
	{
		s3[j]=s2[i];
		i++;
		j++;
	}
	s3[j]='\0';
	printf("%s",s3);
	
	return 0;
}
