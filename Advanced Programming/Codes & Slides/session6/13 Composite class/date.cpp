#include <iostream>
#include "date.h"
using namespace std;
Date::Date(int mn, int dy, int yr)
{
	if (mn > 0 && mn <= 12) // validate the month
		month = mn;
	else
		month = 1;
	year = yr; // could validate yr
	day = checkDay(dy); // validate the day
	cout << "Date object constructor for date";
	print();
	cout << endl;
}

void Date::print() const
{
	cout << month << '/' << day << '/' << year;
}

Date::~Date()
{
	cout << "Date object destructor for date ";
	print();
	cout << endl;
}

int Date::checkDay(int testDay) const
{
	static const int daysPerMonth[13] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	if (testDay > 0 && testDay <= daysPerMonth[month]) 
		return testDay;
	else
	{
		cout << "Invalid day for current month and year";
		return -1;
	}
}
