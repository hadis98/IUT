
#include <iostream>
using namespace std;

class complex
{
	double real;
	double image;
public:
	complex(double i , double r ){ image = i; real = r; }
	complex add(const complex &);
	bool isEqual(const complex&);
	void print();
};
complex complex::add(const complex &obj)
{
	complex new_obj;
	new_obj.real = this->real + obj.real;
	new_obj.image = this->image + obj.image;
	return new_obj;
}
bool complex::isEqual(const complex& obj)
{
	if (this->real == obj.real && this->image == obj.real)
		return true;
	else
		return false;
}
void complex::print()
{
	cout << real;
	if (image > 0)
		cout << "+" << image << "i";
	else if (image < 0)
		cout << image << "i" << endl;
}

int main()
{
	complex c1(12, -4); //c1=12-4i
	complex c2(2, -8);  //c2= 2-8i
	complex c3 = c1.add(c2); //c3=14-12i
	c3.print();
	if (c1.isEqual(c2))
		cout << "c1 is equal to c2"<<endl;
	
	
	complex c4 = c1 + c2;
	if (c4 == c3)
		cout << "c3 and c4 are equal" << endl;
	c4.print();
	
	
		
	return 0;


}
