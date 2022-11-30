#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void f(int, int);
void g(int*, int*, int);
struct Student
{
	int  *age;
	char *name;
}s1;


int main() {

	int age = 20;
	s1.age = &age;
	s1.name = "Ali";

	//conditional break point
	int z = 0;
	for (int i = 0; i < 100; i++)
		z++;


	printf("\nRoll Number of Student : %d", *(s1.age));
	printf("\nName of Student        : %s", s1.name);


	s1.name = (char*)malloc(100);
	strcpy(s1.name, "Ali Ahmadi");

	printf("\nRoll Number of Student : %d", *s1.age);
	printf("\nName of Student        : %s", s1.name);

	int a = 10, b = 30;
	f(a, b);
	
}
void f(int x, int y)
{
	int t = x;
	x = y; y = t;
	printf("value of x and y before g function: %d  %d\n", x, y);

	g(&x, &y, t);
	printf("value of x and y after g function: %d  %d\n", x, y);

}
void g(int* v, int* w, int z){
	*v = 100;
	*w = 200;
	z++;
	printf("value of *v, *w and z: %d   %d   %d\n", *v, *w, z);
}
