#include<stdio.h>
#include <stdlib.h>
#include <string.h>
struct Student
{
	int  *age;
	char *name;
}s1;	

int main()
{

	int test = 20;
	s1.age = &test;
	s1.name = "Ali";

	printf("\nRoll Number of Student : %d", *(s1.age));
	printf("\nName of Student        : %s", s1.name);

	s1.name = (char*)malloc(100);
	strcpy(s1.name, "Ali Ahmadi");

	printf("\nRoll Number of Student : %d", *s1.age);
	printf("\nName of Student        : %s", s1.name);

	return(0);
}