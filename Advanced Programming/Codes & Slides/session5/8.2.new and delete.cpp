#include <iostream>
using namespace std;

class time
{
public:
	time(int = 0, int = 0, int = 0);   //constructor
	void setTime(int, int, int);  //set hour, minute, second
	void printStandard();         //print standard time format
private:
	int hour;     //0 - 23
	int minute;   //0 - 59
	int second;   //0 - 59
};


//member function for time class
time::time(int hr, int min, int sec)
{
	setTime(hr, min, sec);
}
//*********************
//set a new time value using military time. perform validity
//check on the data values. set invalid values to zero.
void time::setTime(int h, int m, int s)
{
	hour = (h >= 0 && h < 24) ? h : 0;
	minute = (m >= 0 && m < 60) ? m : 0;
	second = (s >= 0 && s < 60) ? s : 0;
}
//***********************
void time::printStandard()
{
	cout << ((hour == 0 || hour == 12) ? 12 : hour % 12)
		<< ":" << (minute < 10 ? "0" : "") << minute
		<< ":" << (second < 10 ? "0" : "") << second
		<< (hour < 12 ? " AM" : " PM");
}
// MAIN
int main()
{
	time* t;
	t = new time(12, 10, 7  );
	t->printStandard();
	delete t;
	
	time *t1;
	t1=new time[100];
	//do some processing
	delete[] t1;
	
	
	int *intPtr;
	intPtr=new int[100];
	//do some processing
	delete[] intPtr;
	
	
	
	cin.get();
}