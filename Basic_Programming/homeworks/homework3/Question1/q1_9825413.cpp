
#include <stdio.h>
#include <math.h>
int main()
{
	float n;
	scanf("%f",&n);
	float  m;
	scanf("%f",&m);
   float BMI=n/(m*m);
  printf("%.2f\n",BMI);
    if(BMI<18.5)
     printf("Underweight");
      else if(BMI>=18.5&&BMI<25)
       printf("Normal");
        else if(BMI>=25&&BMI<30)
   printf("Overweight");
    else
      printf("Obese");


	return 0;
}

