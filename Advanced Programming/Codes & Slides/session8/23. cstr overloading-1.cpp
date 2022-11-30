#include <iostream>
#include <stdio.h>
using namespace std;
class date {
	int day, month, year;
public:
		date(char *d);
		date(int m, int d, int y);
		date(){}
		void show_date();
		void show_date(int i);
};
// Initialize using string. 
date::date(char *d) {
sscanf(d, "%d/%d/%d", &month, &day, &year);
}
// Initialize using integers. 
date::date(int m, int d, int y) {
	day = d; month = m; year = y;
}
void date::show_date() {
	cout << month << "/" << day;
	cout << "/" << year << "\n";
}
int main() {
	date ob1(12, 4, 2003), ob2("10/22/2003");
	ob1.show_date();
	ob2.show_date(); 

	char s[80];
	cout << "Enter new date: ";
	cin >> s;
	date d(s); 
	d.show_date();
	return 0;
}