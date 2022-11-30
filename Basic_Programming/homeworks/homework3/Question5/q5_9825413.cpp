#include <stdio.h>
int main()
{
   double  a,b,e,c,d,f,x,y;
   scanf("%lf%lf%lf",&a,&b,&e); 
   scanf("%lf%lf%lf",&c,&d,&f);
   
      if(a*d==b*c)
   printf("No, or infinitely many solutions");


   else
    {
	          double y=(e*c-a*f)/(b*c-a*d);
   		     double x=(b*f-e*d)/(b*c-a*d);
   
           printf("%lf\n%lf",x,y);
	 
     }


return 0;
}
