#ifndef DATE_H
#define DATE_H
class Date
{
private:
	int month;
	int day;
	int year;
	int checkDay(int) const;

public:
	Date(int = 1, int = 1, int = 1900);
	void print() const;
	~Date(); 
};
#endif