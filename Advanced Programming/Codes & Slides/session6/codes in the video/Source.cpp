//sesseion #5
#include <stdio.h>
#include <string.h>

#include <iostream>
using namespace std;
/* 
class <class_name> {
   //members : data members (attributes) + member functions (behaviors)
   //access specifier: public, private, protected (inheritance)
   //public: accessible to all
   //private: accessible to member functions
   public: 
      int a;
   private:
      void testFunction();
	  void testFunction2();

} obj1;
int abc(){

   sampleClass obj2;
}
*/
//entities => employee (salary, birthdate, hiredate, getSalary, ....)

#include "employee.h"
//yoda:
int main() {
	date hireDate(1999, 10, 23);
	date birthDate(1870, 1, 23);
	employee emp1("ali", 2000, hireDate, birthDate);

	return 0;
}