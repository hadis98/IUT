 #include <stdio.h>
#define PI 3.1415
#define ERROR_MESSAGE "Error. Please contact the provider on 09123456789.\n"
#define DEBUG
int main()
{
	float radius, area;
	printf("Enter the radius: ");
	scanf("%d", &radius);
	
	area = PI*radius*radius;
	printf("Area=%.2f", area);

	if (area < 0)
	{
		printf("%s", ERROR_MESSAGE);
	}


#ifdef DEBUG
	/* Your debugging statements here */
#endif
	
	printf("Current time: %s \n", __TIME__);   //calculate the current time

	printf("Current file name: %s \n", __FILE__);   //String containing the file name

	printf("Current date: %s \n", __DATE__);   //String containing the current date

	#ifndef DEBUG
	#error "This is an error message"
	#endif

	return 0;
}