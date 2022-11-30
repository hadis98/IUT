#include <iostream>
using namespace std;

class time 
{
  public:
     time(int = 0, int = 0, int = 0);   //default constructor because of having default values
     void printStandard();         //print standard time format
  private:
     void setTime(int, int, int);  //set hour, minute, second
     int hour;     //0 - 23
     int minute;   //0 - 59
     int second;   //0 - 59
};


//member function for time class
time::time(int hr, int min, int sec)
{
  setTime(hr, min, sec);
}
//******************
//perform validity
//check on the data values. set invalid values to zero.
void time::setTime(int h, int m, int s)
{
  hour   = (h >= 0 && h < 24) ? h : 0;
  minute = (m >= 0 && m < 60) ? m : 0;
  second = (s >= 0 && s < 60) ? s : 0;
}
//***********************
void time::printStandard()
{
  cout << (( hour == 0 || hour == 12) ? 12 : hour % 12)
       << ":" << (minute < 10 ? "0" : "") << minute
       << ":" << (second < 10 ? "0" : "") << second
       << (hour < 12 ? " AM" : " PM");
}
// MAIN
int main()
{
    time t1,         //all arguments defaulted
	t2(2),          //minute and second defaulted
	t3(21, 34),     //second defaulted
	t4(12, 25, 42), //all values specified
	t5(27, 74, 99); //all bad values specified
    cout << "Constructed with:\n"
	<< "All arguments defaulted: \n  ";
    cout << "\n  ";
    t1.printStandard();
    cout << "\nHour specified, minute and second defaulted:" << "\n  ";
    cout << "\n  ";
    t2.printStandard();
    cout << "\nHour and minute specified, second defaulted:" << "\n  ";
    cout << "\n  ";
    t3.printStandard();
    cout << "\nHour, minute and second specified:" << "\n  ";
    cout << "\n  ";
    t4.printStandard();
    cout << "\nAll invalid values specified:" << "\n  ";
    cout << "\n  ";
    t5.printStandard();
    cin.get();
}