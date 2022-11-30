#include <iostream>
using namespace std;

class createAndDestroy
{
public:
	createAndDestroy(int id);
	~createAndDestroy();
private:
	int which;
};

createAndDestroy::createAndDestroy(int id)
{
	cout << "Initializing " << id << endl;
	which = id;
}

createAndDestroy::~createAndDestroy()
{
	cout << "Destroying  " << which << endl;
	cin.get();
}
//**************************************************************
void createObject()
{
	static createAndDestroy staticObject(5);
	createAndDestroy automaticObject(6);
}
createAndDestroy globalObject1(1), globalObject2(2);  //global objects 

int main()
{
	createAndDestroy  localObject1(3);
	cout << "This line will not be the first line " << endl;
	createAndDestroy  localObject2(4);
	createObject();   //call for object creation
}
//*********************


