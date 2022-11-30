#include "time.h"
int main()
{
	time t1,         //all arguments defaulted
		t2(2),          //minute and second defaulted
		t3(21, 34),     //second defaulted
		t4(12, 25, 42), //all values specified
		t5(27, 74, 99); //all bad values specified
	cout << "Constructed with:\n"
		<< "All arguments defaulted: \n  ";
	cout << "\n  ";
	t1.printStandard();
	cout << "\nHour specified, minute and second defaulted:" << "\n  ";
	cout << "\n  ";
	t2.printStandard();
	cout << "\nHour and minute specified, second defaulted:" << "\n  ";
	cout << "\n  ";
	t3.printStandard();
	cout << "\nHour, minute and second specified:" << "\n  ";
	cout << "\n  ";
	t4.printStandard();
	cout << "\nAll invalid values specified:" << "\n  ";
	cout << "\n  ";
	t5.printStandard();
	cin.get();
}