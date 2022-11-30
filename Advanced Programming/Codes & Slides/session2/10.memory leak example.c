#include <stdlib.h>

//memory leakage
int main()
{
	int count = 0;
	char *pointer = NULL;
	for (count = 0; count < 10; count++) {
		pointer = (char *)malloc(sizeof(char) * 100);
		//some process
		//free(pointer);
	}

	//free(pointer);

	return 0;
}