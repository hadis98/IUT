#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
int freq(char s[],char ch);
int main()
{
	
	char s[300],s2[300];
	char ch, ch2;
	int x,y,i;
	gets(s);
//	ch=getchar();

 //printf("%c",ch2);
 for(i=0;i<strlen(s);i++)
 {
 	   x=freq(s,s[i]);	
	if(islower(s[i])) 
	{
		y=(x*(s[i]-97)+1)%26;
		s2[i]=y+97;
	 } 
	else {
		
		y=(x*(s[i]-65)+1)%26;
		s2[i]=y+65;
		
	} 
 	
 }
	s2[i]='\0';
	printf("%s",s2);
	
	
	
	return 0;
}
int freq(char s[],char ch)
{
	int i=0,n=0,m=0;
	for(;i<strlen(s);i++)
	{
		if(isupper(ch))
		{
			if(s[i]==ch || s[i]==ch+32) n++;
		}
		else {
              if(s[i]==ch || s[i]==ch-32) n++;
		}
		
		
	}
	return n;
}
