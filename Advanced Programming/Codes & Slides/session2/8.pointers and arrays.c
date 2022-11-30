#include <stdio.h>
int main()
{
	char charArr[10];
	int i;
	char *ptr;
	ptr = charArr;

	for (i = 0; i < 9; i++)
		scanf("%c", ptr++); // scanf("%c", &charArr[i]);
	*ptr = '\0';
	
	// instead of the above loop: scanf("%9s",charArr); 
	
	printf("\n You entered: %s\n", ptr - 9); //	printf("\n You entered: %s\n", charArr);


	for (i = 0; i < 4; ++i)
	{
		printf("Address of charArr[%d] = %p\n", i, &charArr[i]);
	}

	return 0;
}