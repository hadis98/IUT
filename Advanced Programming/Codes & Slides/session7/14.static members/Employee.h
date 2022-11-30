#ifndef EMPLOYEE_H 
#define EMPLOYEE_H

#include <string>
using namespace std;
class Employee
{
	string firstName;
	string lastName;
	static int count;

public:


	Employee(const string &, const string &); // constructor
	~Employee(); // destructor
	string getFirstName() const; // return first name 
	string getLastName() const; // return lastname
	// static member function 
	static int getCount(); // return number of objects instantiated


};
#endif