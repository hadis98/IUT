
#include "employee.h"
using namespace std;
int employee::counter = 0;
employee::employee(char* _name , float _salary , date _hireYear , date _birthYear ) :birthYear(_birthYear)//, hireYear(_hireYear)
{ //:const_attr(value) ==> initialization list
	if (_name != NULL)
		strcpy(name, _name);
	else
		strcpy(name, " ");
	salary = _salary;
	counter++;
	


}
float employee::getSalary() const {
	return salary;
}
employee employee::compareSalary(employee obj) {

}

void employee::setSalary(float _salary) {
	this->salary = _salary;
	int sal1, sal2, x, y, z;
	sal1++;
	//....
	sal1 = this->salary + sal2;
}
void employee::setName(char * _name) { strcpy(name, _name); }
const char* employee::getName() const { return name; }
void employee::setHireYear(int _year) { hireYear = _year; }
date employee::getHireYear() const { return hireYear; }
const date employee::getBirthYear() { return birthYear; }
employee::~employee() {
	counter--;
}
 int employee::getCounter() {
	 return counter;
}