#include <iostream>
#include <vector> 
#include <cstdlib>
using namespace std;
class DailyTemp {
	int temp; public:
		DailyTemp() { temp = 0; } 
		DailyTemp(int x) { temp = x; }
		DailyTemp &operator=(int x) {
			temp = x;
			return *this;
		}
		double get_temp() { return temp; }
};
bool operator<(DailyTemp a, DailyTemp b) {
	return a.get_temp() < b.get_temp();
}
bool operator==(DailyTemp a, DailyTemp b) {
	return a.get_temp() == b.get_temp();
}
int main() {
	vector<DailyTemp> v;
	int i;
	for (i = 0; i < 7; i++)
		v.push_back(DailyTemp(60 + rand() % 30));
	cout << "Farenheit temperatures:\n"; 
	for (i = 0; i < v.size(); i++) 
		cout << v[i].get_temp() << " ";
	cout << endl;
	// convert from Farenheit to Centigrade 
	for(i=0; i<v.size(); i++)
		v[i] = (v[i].get_temp() - 32) * 5 / 9;
	cout << "Centigrade temperatures:\n";
	for (i = 0; i < v.size(); i++)
		cout << v[i].get_temp() << " "; 
	return 0;
}