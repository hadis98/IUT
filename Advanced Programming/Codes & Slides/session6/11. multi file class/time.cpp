#include "time.h"
//member function for time class
time::time(int hr, int min, int sec)
{
	setTime(hr, min, sec);
}
//*********************
// perform validity
//check on the data values. set invalid values to zero.
void time::setTime(int h/*=0*/, int m/*=0*/, int s/*=0*/)
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
