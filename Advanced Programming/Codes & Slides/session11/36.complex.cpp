
#include <iostream>
using namespace std;

class complex
{
	double real;
	double image;
public:
	complex(double r, double i){ image = i; real = r; }
	complex add(const complex &);
	bool isequal(const complex&);
	void print();
};
complex complex::add(const complex &obj)
{
	complex new_obj(0, 0);
	new_obj.real = this->real + obj.real;
	new_obj.image = this->image + obj.image;
	return new_obj;
}
bool complex::isequal(const complex& obj)
{
	if (this->real == obj.real && this->image == obj.image)
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
	if (c1.isequal(c2))
		cout << "c1 is equal to c2";
	return 0;
}








