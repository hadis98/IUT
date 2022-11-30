#ifndef EMPLOYEE_H 
#define EMPLOYEE_H

#include <string> 
#include "Date.h" // include Date class definition 
using namespace std;
class Employee 
{
	string firstName; // composition:member object 
	string lastName; // composition: member object 
	const Date birthDate;
	const Date hireDate;
public:
	Employee(const string &, const string &, const Date &, const Date &);
	void print() const;
	~Employee();
};
#endif

