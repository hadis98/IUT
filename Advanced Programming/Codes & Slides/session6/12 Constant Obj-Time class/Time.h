#ifndef TIME_H
#define TIME_H
class  Time
{
	int hour, minute, second;
public:
	Time(int = 0, int = 0, int = 0);
	void setTime(int, int, int); // settime
	void setHour( int ); // set hour
	void setMinute( int ); // setminute
	void setSecond( int ); // setsecond

	// get functions (normally declared const)
	int getHour()const; // return hour
	int getMinute()const; // return minute 
	int getSecond()const; // return second

	// print functions(normally declared const)
	void printUniversal() const; // print universal time
	void printStandard(); // print standard time (should be const)
};

#endif