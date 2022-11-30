#include <iostream>

using namespace std;

class myClass
{
	int number;
public:
	void setNumber(int num){ number = num; }
	int getNumber(){ return number; }
};

void testFun(myClass ob)
{
	ob.setNumber(200);
	cout << "The value of number in testFun() : "
		<< ob.getNumber() << endl;
}
//*******************
int main()
{
	myClass object1;
	object1.setNumber(100);
	testFun(object1);
	cout << "The value of number in main() : "
		<< object1.getNumber() << endl;
	cin.get();
}


