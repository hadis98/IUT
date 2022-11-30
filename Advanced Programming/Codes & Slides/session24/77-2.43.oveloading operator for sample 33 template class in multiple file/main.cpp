#include "atype.h"
int main()
{
	atype<int> intob; // integer array
	atype<double> doubleob; // double array
	const atype<int> aint;
	cout<<aint[12];
	//aint[12]=2; //error
	
	int i;
	cout << "Integer array: ";
	for (i = 0; i<SIZE; i++) intob[i] = i;
	for (i = 0; i<SIZE; i++) cout << intob[i] << " ";
	cout << '\n';
	cout << "Double array: ";
	for (i = 0; i<SIZE; i++) doubleob.operator[](i) = (double)i / 3;
	for (i = 0; i<SIZE; i++) cout << doubleob[i] << " ";
	cout << '\n';
	intob[12] = 100; // generates runtime error
	return 0;
}