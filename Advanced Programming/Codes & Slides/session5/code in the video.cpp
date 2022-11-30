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
class employee {
private:
	float salary;
	char* name;
	int hireYear;
public:
	//constructor 
	 employee(char* _name=NULL, float _salary=2000, int _hireYear=1999) {
		 name = (char*)malloc(100);
		 if (_name != NULL)
			 strcpy(name, _name);
		 else
			 strcpy(name, " ");
		 salary = _salary;
		 hireYear = _hireYear;
	 }
	//setter and getter function 
	float getSalary() { return salary; }
	void setSalary(float _salary);
	void setName(char * _name) { strcpy(name, _name); }
	char* getName() { return name; }
	void setHireYear(int _year) { hireYear = _year; }
	int getHireYear() { return hireYear; }

};

void employee::setSalary(float _salary) {
		salary = _salary; 
		getSalary();
}
void printEmployee(employee obj) {
	cout<<obj.getHireYear()<<" ";
	cout<<obj.getName()<<endl;
	cout<<obj.getSalary();
}
employee compareEmployees(employee obj1, employee obj2) {
	if (obj1.getSalary() > obj2.getSalary())
		return obj1;
	else
		return obj2;
}


int main() {
	employee emp1, emp3("Mina", 2800, 2012);
	//emp1.employee("Null", 1999, 2000); emp3.employee("Mina", 2800, 2012);

	// emp1.employee()
	// emp1: name, salary, hireYear
	// emp2: name, salary, hireYear
	// emp3: name, salary, hireYear
	employee * ptr;
	ptr = (employee*)malloc(sizeof(employee)); //new
	ptr = new employee("Goli",2000,2018);
	ptr = new employee[100];
	//free(ptr)
	delete ptr;
	
	employee empArray[100];
	empArray[10].setName("mina");
	//ptr = &emp1;
	emp1.setName("Ali");
	emp1.setHireYear(1999);
	emp1.setSalary(2500);

	(*ptr).getName();
	ptr->setName("aaa");
	//printf("%d", emp1.getHireYear());
	printEmployee(emp1);
	employee emp2;
	emp2.setName("Hasan");
	emp2.setHireYear(1987);

	employee tmp = compareEmployees(emp1, emp2);
	printEmployee(tmp);
	return 0;
}