#include <stdio.h>
int main()
{
  long int a,b,bmm,min,kmm,x=1;
  scanf("%ld%ld",&a,&b);
  bmm=a;
  min=b;
  
  while(x!=0)
{
x=(bmm%min);
bmm=min;
min=x;
}
  kmm=(a*b)/bmm;
  printf("%ld %ld",bmm,kmm);
return 0;
}
