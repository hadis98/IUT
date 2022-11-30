#include <iostream>    
using namespace std;
int main() {
	
	//error correction
	
	int x;
	char name[100];
	cin >> x >> name; 
	
	
	while (cin.good() != true)
	{
		cout << "Wrong input try again\n";
		//cin.clear();
		//cin.readsome(name, 100);
		cin >> x >> name;
	}
	return 0;
}
