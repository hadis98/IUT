#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
int main()
{
///char str[100];
char *str=(char *)malloc(200);

fgets(str,100,stdin);
int n=0 , m=0,c=0;
for(int i=0;i<strlen(str);i++)
{
    if (*(str+i)==' ') n++;
    if(isalpha(*(str+i)))
    {
            if (*(str+i)=='a'|| *(str+i)=='u'||*(str+i)=='e'||*(str+i)=='i'||
     *(str+i)=='o' ||*(str+i)=='A'|| *(str+i)=='U'|| *(str+i)=='E'||*(str+i)=='I' ||*(str+i)=='O')
     {
          m++;
     }
       c++; 
    }

     
}
printf("%d\n%d\n",m,c-m);

    return 0;
}