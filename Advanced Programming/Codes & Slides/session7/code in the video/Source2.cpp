#include <iostream>
using namespace std;
void swap(int& a, int& b) { //call by reference int &a=x, int &b=y
	int t;
	t = a;  //*
	a = b; b = t;

}
void square(int *x,int *y) {
	*x = *x * *x;
	*y = *y * *y;
}
void square2(int &x, int &y) {
	x = x * x;
	y = y * y;
}

/*int main() {
	int *ptr;
	int x = 100;
	ptr = &x;

	int &ref=x; //reference must be initialized
	ref++;
	x++;
	int y = 200;
	swap(x, y);
	cout << x << y;
	square(&x, &y);
	square2(x, y);
}
*/

#include <iostream> 
using namespace std;

double vals[] = { 10.1, 12.6, 33.1, 24.1, 50.0 };

double& setValues(int i) {
	if (i<5 && i>-1)
		return vals[i];   // return a reference to the ith element
}
double* setValues2(int i) {
	if (i<5 && i>-1)
		return vals+i;   // return a reference to the ith element
}
// main function to call above defined function.
int main1111() {
	*(setValues2(1))= 12;
	setValues(1) = 12;
	cout << "Value before change" << endl;
	for (int i = 0; i < 5; i++) {
		cout << "vals[" << i << "] = ";
		cout << vals[i] << endl;
	}
	cout << setValues(2);
	setValues(1) = 20.23; // change 2nd element
	vals[1] = 20.23;

	setValues(3) = 70.8;  // change 4th element

	cout << "Value after change" << endl;
	for (int i = 0; i < 5; i++) {
		cout << "vals[" << i << "] = ";
		cout << vals[i] << endl;
	}

	return 0;
}










