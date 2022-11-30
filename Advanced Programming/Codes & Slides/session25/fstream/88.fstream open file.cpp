
#include <iostream>
#include <fstream>
using namespace std;

int main(){
	ofstream a;
	char str[100];

	a.open("test-open.txt", ios::_Nocreate);
	if (a.is_open() == false)
	{
		cout << "The file does not exist, create a new file\n";
		a.open("test-open.txt");
		if (a.is_open() == false)
			return 1;
	}

	a << "This is a test\n";
	a.put('a');
	a.close();
	
	fstream b;
	b.open("test-open.txt", ios::in | ios::out | ios::ate);
	b << "\nthis is after append\n";
	b.seekg(0, ios::beg);
	b >> str;
	cout << str;
	b.close();
	system("pause");
}
