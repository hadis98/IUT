#include <iostream>
using namespace std;

class Student
{
public:
	void input();
	void output();
	float getAverage();
private:
	int stno;
	char name[10];
	float average;
};

void Student::input()
{
	cout << "Enter name, stno , average : ";
	cin >> name >> stno >> average;
}
//******************
float Student::getAverage()
{
	return average;
}
//*****************
void Student::output()
{
	cout << "\nname is : " << name << "\nstno is : " << stno
		<< "\naverage is : " << average;
}


Student enter()  //this function is of type of Student
{
	Student st;
	st.input();
	return st;      //return on object
}
//**************************
int main()
{
	int n, i;
	Student st1, st2, st;
	st = enter();  //enter() return an object
	st1 = enter();
	if (st.getAverage() > st1.getAverage())
	{
		st2 = st1;
		st1 = st;
	}

	return 0;
}

