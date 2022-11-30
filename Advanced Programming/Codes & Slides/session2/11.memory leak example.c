#include <stdlib.h>
int * newArray(int size)
{
	int *myArray; //local variable  
	myArray = (int*)malloc(size * sizeof(int));// myarray--> size byte
	if (myArray == NULL)
		return NULL;
	for (int i = 0; i < size; i++)
		*(myArray + i) = 0;	
	//free(myarray);
	return myArray;
	}
int main()
{
	int *ptr=newArray(200);
	//some process  in the array
	ptr++;
	*ptr=5;
	//free
	
	newArray(300);
	newArray(400);
	return 0;

}