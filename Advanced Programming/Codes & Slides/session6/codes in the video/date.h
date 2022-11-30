#pragma once
class date
{
	//default access is private
	int year;
	int month;
	int day;
public:
	date(int=0 , int=0, int=0);
	void printDate();
	~date();
};

