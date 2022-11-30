#include <iostream>     // std::cout
#include <fstream>      // std::ifstream
#include <string>
using namespace std;
int main() {
	std::ifstream ifs;

	ifs.open("input.txt", ios::in);
	string str;
	int count;
	ifs >>hex>>count;
	cout << count << endl;
	while (ifs.good())
	{
		ifs >> str;
		cout << str;
	}

	
	ifs.close();

	return 0;
}