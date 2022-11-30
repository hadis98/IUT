#include <iostream>
using namespace std;
class person
{
protected:
	char * _name;
	int _nc;
public:
	person(char * name, int nationalCode)
	{
		_name = new char[strlen(name)];
		strcpy(_name, name);
		_nc = nationalCode;
		cout << "Person consrtuctor called\n";
	}
	char * getName() { return _name; }
	void setName(char* name) { _name = name; }
	int getNc() { return _nc; }
	void setNc(int nc) { _nc = nc; }
	~person(){ cout << "person destructor called\n"; }
}; 
class employee : public person
{
	double _salary;
public:
	employee(int salary, char * name, int nationalCode) :person(name, nationalCode)
	{
		_salary = salary;
	}
	double getSalary(){ return _salary; }
	double calc_salary(int hours){ return hours*_salary; }
};
class part_time : public employee
{
public:
	part_time(int promisedHours , int salary, char * name, int nationalCode)
		:employee(salary, name, nationalCode)
	{
		_promised_hours = promisedHours;
	}
	double calc_salary(int hours)
	{
		if (hours < _promised_hours)

			return (0.6* hours);

		else
			return employee::calc_salary(hours);
	}
private:
	int _promised_hours;
};
int main()
{

	part_time t = part_time(10, 10, "ali", 3234);
	t.calc_salary(2);
	system("pause");
}