#include <iostream>
#include "employee.h"
#include "time.h"
using namespace std;
int main()
{
	
	char ch=0;
	scanf("%c", &ch);
	cout << ch;
	Date birth(7, 24, 1949); 
	Date hire(3, 12, 1988);
	Employee manager("Bob", "Blue", birth, hire);
	cout << endl;
	manager.print();
}