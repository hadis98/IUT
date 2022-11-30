#include <iostream>
using namespace std;
class person
{
private:
	char  _name[100];
	int _nc;
public:
	person() {  cout << "person constructor is called. \n"; }
	char * getName() { return _name; }
	void setName(char* name) { strcpy(_name , name); }
	int getNc() { return _nc; }
	void setNc(int nc) { _nc = nc; }
	~person(){ cout << "person destructor is called\n"; }

};
class student : public person
{
	int _units;
	float _avg;
public:
	student(){ cout << "student constructor is called. \n";	}
	void setAvg(float avg){	_avg = avg;}
	void setUnits(int units){ _units = units; }
	void registerCourse(){}
	float getAvg(){ return _avg; }
	~student(){ cout << "student destructor is called\n"; }

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
	student ali;
	ali.setName("Ali");
	ali.setAvg(12);
	ali.setNc(123456);
	ali.setUnits(123);
	cout << ali.getName() << "\t" << ali.getAvg() << "\t" << sizeof(ali) << endl;
}