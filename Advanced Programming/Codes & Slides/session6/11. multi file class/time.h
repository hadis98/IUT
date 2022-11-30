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
