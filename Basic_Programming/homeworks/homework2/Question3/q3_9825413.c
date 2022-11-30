#include <stdio.h>
int main()
{
 int a,b,c;
 scanf("%d%d%d",&a,&b,&c);
 int x=a*a;
 int y=b*b;
 int z=c*c;
 if(x==y+z)
 {
 	printf("YES");

 }

 else if(y==x+z)

 {
 	printf("YES");

 }


 else if(z==x+y)

 {
 	printf("YES");

 }
 else


 {
     printf("NO");
 }


return 0;


}

