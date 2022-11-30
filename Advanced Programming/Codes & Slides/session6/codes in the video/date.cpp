#include "date.h"
#include <iostream>
using namespace std;


date::date(int _year, int _month, int _day)
{
	year = _year;
	month = _month;
	day = _day;
}
void date::printDate() {
	cout << year << "/ " << month << "/ " << day << endl;
}

date::~date()
{
}
