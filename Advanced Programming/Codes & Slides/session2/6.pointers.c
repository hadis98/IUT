#include <stdio.h>
int main()
{
	int var = 10;
	int *p;
	p = &var;

	printf("Address of var: %u\n", &var);
	printf("Address of var: %u\n", p);

	printf("Address of pointer p: %u\n", &p);

	/* Note I have used %u for p's value as it should be an address*/
	printf("Value of pointer p: %u \n", p);

	printf("Value of var: %d\n", var);
	printf("Value of var: %d \n", *p);
	printf("Value of var: %d \n", *(&var));
}