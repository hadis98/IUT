#include <iostream> 
#include "Employee.h" // Employee class definition 
#include "Date.h" // Date classdefinition 
using namespace std;
Employee::Employee(const string& first, const string& last,
	const Date &dateOfBirth, const Date &dateOfHire)
	://firstName(first), // initialize firstName
	//lastName( last ), // initialize lastName
	birthDate( dateOfBirth ), // initialize birthDate
	hireDate( dateOfHire ) // initialize hireDate
	// output Employee object to show when constructor is called 
	{
		
		firstName = first;
		lastName = last;
		

		cout << "Employee object constructor:" << firstName<< ' ' << lastName << endl;
	} // end Employee constructor
void Employee::print() const
{ 
	cout << "Birthday: ";
	birthDate.print(); 
	cout << endl;
} // end function print

Employee::~Employee()  
{
	cout << "Employee object destructor: " << lastName << ", " << firstName << endl;
} // end ~Employeedestructor