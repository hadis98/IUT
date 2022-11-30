#include <iostream>
#include <stdlib.h>
using namespace std;

class myString
{
	char* str;
	int length;
public:
	myString(int=40);
	~myString();
	void setString(const char*);
	void printString();
};
myString::~myString(){
    delete [] str;
}

myString::myString(int len)
{
	str = new char[len];
	length = len;
}

void myString::setString(const char *ch)
{
	strcpy(str, ch);
}
void myString::printString()
{
	cout << "Your string is " << str << endl;
}
void myFunction(int i)
{
	myString name;  //stack
	
	//generate some string:
	char str[20] = {'\0'};
	sprintf(str, "sample input %d", i);

	name.setString(str);
	name.printString();
	// other processing
}
int main()
{
	int i;
	for (i = 1; i < 10; i++)
		myFunction(i);

	myString* mystr;
	mystr = new myString(100);
	mystr->setString("hello world");
	delete mystr; 

	myString *strArray;
	strArray= new myString[100];
	delete[] strArray;

	return 0;
}