#pragma once
#include <iostream>
#include <string.h>
using namespace std;
#include "date.h"
//composit classes
//some attributes are of other classes types
//class date{ int year; int month; int day; 



//Class Interface 
class employee {
private:
	float salary;
	char name[100];
	date hireYear;
	const date birthYear;
	static int counter;

public:
	//const: constructor-body -  destructor-body
	//constructor 
	employee(char* _name , float _salary , date _hireYear , date _birthYear);
	
	//setter and getter function 

	//functions signatures
	float getSalary() const;
	void setSalary(float _salary);
	void setName(char * _name);
	const char* getName() const;
	void setHireYear(int _year);
    date getHireYear() const;
	const date getBirthYear();
	static int getCounter();
	//void setBirthYear(int _year) { birthYear = _year; }
	//destructor
	~employee();
};

