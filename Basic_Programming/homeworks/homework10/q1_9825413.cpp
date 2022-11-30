#include <stdio.h>
void swap(int *a, int *b);
int main()
{
	int arr2[] = { 3,2,4,1,5,6,9,7 };
	int *arr;
	arr = arr2;

	int i, j;
	for (i = 0; i < 8 - 1; i++)
	{
		for (j = 0; j < 8 - 1; j++)
		{
			if (*(arr + j + 1) < *(arr + j))
				swap(arr + j + 1, arr + j);
		}
	}
	for (i = 0; i < 8; i++)
		printf("%d ", *(arr + i));
	//getchar();
	// getchar();
	return 0;
}
void swap(int *a, int *b)
{
	int temp;
	temp = *a;
	*a = *b;
	*b = temp;
}
