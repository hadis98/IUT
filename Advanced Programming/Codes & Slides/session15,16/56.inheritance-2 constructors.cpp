#include <iostream>
using namespace std;
class person
{
	char  _name[100];
	int _nc;
public:
	person(char * name, int nationalCode)
	{
		if (name != NULL){
			strcpy(_name, name);
			_nc = nationalCode;
		}
		else{
			strcpy(_name, "");
			_nc = 0;
		}
		cout << "Person constructor called\n";
	}
	char * getName() { return _name; }
	void setName(char* name) { _name = name; }
	int getNc() { return _nc; }
	void setNc(int nc) { _nc = nc; }
	~person(){ cout << "person destructor called\n"; }
};
class student : public person
{
	int _units;
	float _avg;
public:
	student(char * name, int nationalCode) :person(name, nationalCode)
	{
		cout << "Student constructor called\n";
	}
	void setAvg(float avg){ _avg = avg; }
	void registerCourse(){}
	float getAvg(){ return _avg; }
	~student(){ cout << "student destructor called\n"; }
};
class employee : public person
{
	double _salary;
public:
	double getSalary(){ return _salary; }
	void setSalary(double salary){ _salary = salary; }
};
int main()
{
	student ali("ali", 123456);
	//ali.setName("Ali");
	ali.setAvg(12);
	//ali.setNc(123456);
	cout << ali.getName() << "\t" << ali.getAvg() << endl;
}