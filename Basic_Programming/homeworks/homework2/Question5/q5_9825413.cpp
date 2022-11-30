#include <stdio.h>
#include <math.h>
int main()
{

{    float a,b,c;
    
     scanf("%f",&a);
      
     scanf("%f",&b);
   
     scanf("%f",&c);
    
    float x1,x2;
    if (a==0)
    {
        if (b==0)
        {
          printf("IMPOSSIBLE");

       }
      else
       {  
            x1=-c/b;
       if (x1==0)
	   
	    printf("%.3f",c/b);
	    
	    else 
	    {   
	       	
    
          printf("%.3f",x1);

	    	
		}
      
    }
    }
else
{
      float delta =b*b-4*a*c;
      if (delta==0)

       {

          x1=-b/(2*a);
          printf("%.3f",x1+0);
        }

      else if (delta>0)
      {
         
          x1=(-b+ sqrt(delta))/(2*a);
        x2=(-b- sqrt(delta))/(2*a); 
        
        if (x2>x1)
        {
      	 printf("%.3f\n",x1+0);
        printf("%.3f",x2+0);
        	
		}
        else
		{
			printf("%.3f\n",x2);
			printf("%.3f",x1);
		}
       
      }
      else
       { 
           printf("IMPOSSIBLE");
       }

       }

       }
         return 0;
    }

    
    




