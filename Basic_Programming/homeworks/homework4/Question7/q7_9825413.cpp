#include <stdio.h>
#include <math.h>
int main()
{
  long int n;
  scanf("%ld",&n);
  if(n%2!=0) 
  { 
         if (n==1) printf("0 0");
      else if(n%4==3)
       {
       	     long int i=1;
       	   long   int x=-((n+1)/4);
    	while (i<=n)
    	{
  	    	
  	     i++;
	    }
       	printf("%ld %ld",x,x);
	   }
     else 
     {
     	long int i=1;
     	long int x=(-(n-1)/4);
     	while (i<=n)
     	{
     		i++;
		 }
     	printf("%ld %ld",x,x);
	 }
  	
  }

 else 
 {
 	if(n%4==0)
 	
 	{  long int i=1;
 	  long int x=(-n/4);
 	  while (i<=n)
 		{ 
 		  i++;
		 }
		 
 		printf("%ld %ld",x,-x);
	 }
 	else 
 	{
 		long int i=1;
		long	int x=(n+2)/4;
 		long	int y=(-(((n+2)/4)-1))+0;
 		while (i<=n)
 		{

 			i++;
		 }
 		printf("%ld %ld",x,y);
	 }
 }
return 0;
}
