#include <stdio.h>

int main()
{
	char sentence[] = "Rudolph is 12 years old";
	char str[20];
	int i;

	sscanf(sentence, "%s %*s %d", str, &i); //note that %*s means read a string and ignore it!
	printf("%s -> %d\n", str, i);

	return 0;
}