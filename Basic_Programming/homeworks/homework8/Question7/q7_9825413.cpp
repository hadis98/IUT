#include <stdio.h>
#include <string.h>
int main()
{
 char s[100001],s1[100001];
 int a1,n,l,i;
 scanf ("%d%d",&a1,&n);
 s[0]='1';
 s[1]='\0' ;
 while(strlen(s)<=n )
 {
 l=strlen(s);
 for(i =0 ; s[i]!= '\0' ; i++ )
 {
 if(s[i]=='1')
 s1[i]='0' ;
 if(s[i]=='0')
 s1[i]='1' ;
 }
 s1[l]='\0' ;
 strcat(s,s1);
 }
 
 for(i=a1-1 ; i<n ; i++)
 printf("%c",s[i]);
 return 0;

}
