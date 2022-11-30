#include <iostream>
#include <iomanip>
#include "Time.h"
using namespace std;

Time::Time(int hour, int minute, int second)
{
	setTime(hour, minute, second);
}

void Time::setTime(int hour, int minute, int second)
{
	setHour(hour);
	setMinute(minute);
	setSecond(second);
}
void Time::setHour(int h)
{
	if (h >= 0 && h < 24)
		hour = h;
	else
		hour = 0;
}

void Time::setMinute(int m)
{
	if (m >= 0 && m < 60)
		minute = m;
	else
		minute = 0;
}
void Time::setSecond(int s)
{
	if (s >= 0 && s < 60)
		second = s;
	else
		second = 0;
}
int Time::getHour() const // get functions should be const
{
	
	return hour;
}

int Time::getMinute() const
{
	return minute;
}

int Time::getSecond() const
{
	return second;
}

void Time::printUniversal() const
{
   cout << setfill('0') << setw(2) << hour << ":" << setw(2) << minute << ":" << setw(2) << second;
} 

void Time::printStandard()
{
	cout << ((hour == 0 || hour == 12) ? 12 : hour % 12)
		<< ":" << (minute < 10 ? "0" : "") << minute
		<< ":" << (second < 10 ? "0" : "") << second
		<< (hour < 12 ? " AM" : " PM");
}

