#include<iostream>
using namespace std;

class String
{
private:
	char *s;
	int size;
public:
	String(const char *str = NULL); // constructor
	~String() { delete[] s; }// destructor
	String(const String&); // copy constructor
	void print() { cout << s << endl; } // Function to print string
	void change(const char *);  // Function to change
};

String::String(const String& old_str)
{
	size = old_str.size;
	s = new char[size];
	strcpy(s, old_str.s);
}
String::String(const char *str)
{
	size = strlen(str)+1;
	s = new char[size + 1];
	strcpy(s, str);
}

void String::change(const char *str)
{
	size = strlen(str);
	delete[] s;
	s = new char[size + 1];
	strcpy(s, str);
}


int main()
{
	String str1("Hello");
	String str2 = str1;

	str1.print(); // what is printed ?
	str2.print();

	str2.change("Goodbye");

	str1.print(); // what is printed now ?
	str2.print();
	return 0;
}