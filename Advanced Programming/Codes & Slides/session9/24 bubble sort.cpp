#include <iostream>
using namespace std;

void bubble(int *items, int count)
{
	int t;

	for (int a = 1; a < count; a++)
		for (int b = count - 1; b >= a; b--)
			if (items[b - 1] > items[b]) {
				t = items[b - 1];
				items[b - 1] = items[b];
				items[b] = t;
			}
}

int main()
{
	int iarray[7] = { 7, 5, 4, 3, 9, 8, 6 };

	cout << "Here is unsorted integer array: ";
	for (int i = 0; i < 7; i++)
		cout << iarray[i] << ' ';
	cout << endl;

	bubble(iarray, 7);

	cout << "Here is sorted integer array: ";
	for (int i = 0; i < 7; i++)
		cout << iarray[i] << ' ';
	cout << endl;






	double darray[5] = { 4.3, 2.5, -0.9, 10.2, 3.0 };
	cout << "Here is unsorted double array: ";
	for (int i = 0; i < 5; i++)
		cout << darray[i] << ' ';
	cout << endl;

	//bubble(darray, 5);

	cout << "Here is sorted double array: ";
	for (int i = 0; i < 5; i++)
		cout << darray[i] << ' ';
	cout << endl;

	return 0;
}

