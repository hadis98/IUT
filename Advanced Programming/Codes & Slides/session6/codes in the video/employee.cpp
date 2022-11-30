
#include "employee.h"
using namespace std;

employee::employee(char* _name , float _salary , date _hireYear , date _birthYear ) :birthYear(_birthYear)//, hireYear(_hireYear)
{ //:const_attr(value) ==> initialization list
	if (_name != NULL)
		strcpy(name, _name);
	else
		strcpy(name, " ");
	salary = _salary;
	


}
float employee::getSalary() const { return salary; }
void employee::setSalary(float _salary) {
	salary = _salary;
}
void employee::setName(char * _name) { strcpy(name, _name); }
const char* employee::getName() const { return name; }
void employee::setHireYear(int _year) { hireYear = _year; }
date employee::getHireYear() const { return hireYear; }
const date employee::getBirthYear() { return birthYear; }
employee::~employee() {

}