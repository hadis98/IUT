#include <iostream> 
#include "Employee.h" // Employee class definition 
using namespace std;

int main()
{
	cout<<Employee::getCount(); //compile error bcs private static member
	cout << "Number of employees before instantiation of any objects is " << Employee::getCount() << endl;
	{
		Employee e1("Susan", "Baker");
		cout<<e1.count;
		Employee e2("Robert", "Jones");
		cout << "Number of employees after objects are instantiated is " << Employee::getCount();
		cout << "\n\nEmployee1:" << e1.getFirstName() << "" << e1.getLastName() << "\nEmployee 2: "
			<< e2.getFirstName() << "" << e2.getLastName() << "\n\n";
	}
	cout << "\nNumber of employees after objects are deleted is " << Employee::getCount() << endl;
	cin.get();
}
