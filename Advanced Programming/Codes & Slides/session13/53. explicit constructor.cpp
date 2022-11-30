
#include <iostream>
using namespace std;
#include <string>
class complex
{
	double real;
	double image;
public:
	complex(double i, double r)  { image = i; real = r; }
	complex(double r){ real = r; image = 0; }
	complex operator+(const complex &);
	//complex operator+(const double);
	//friend complex operator+(const double d, const complex& obj);
	//friend bool operator==(const double d, const complex& obj);
	bool operator==(const complex&);
	complex& operator+=(complex &);
	complex& operator++();
	complex operator++(int);

	operator string(){
		string str;
		str = to_string(real);
		str += "+";
		str.append(to_string(image) + "i");
		return str;
	}
	void print();
};
complex& complex::operator++()
{
	real++;
	return *this;
}
complex complex::operator++(int)
{
	complex temp(real, image);
	real++;
	return temp;
}

complex& complex::operator+=(complex &obj)
{
	this->image += obj.image;
	this->real += obj.real;
	return *this;
}
complex complex::operator+(const complex &obj)
{
	complex new_obj(0, 0);
	new_obj.real = this->real + obj.real;
	new_obj.image = this->image + obj.image;
	return new_obj;
}
bool complex::operator==(const complex& obj)
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
		cout << "+" << image << "i" << endl;
	else if (image < 0)
		cout << image << "i" << endl;
}

int main()
{
	complex c1(12, -4); //c1=12-4i
	complex c2(2, -8);  //c2= 2-8i
	string str = c1;
	cout << str;

	complex c3 = c1.operator+(c2); //c3=14-12i
	c3.print();
	if (c1.operator==(c2))
		cout << "c1 is equal to c2" << endl;

	complex c4 = c1 + 4; //c4=c1.operator+(4);
	c4 = c1 + c2 + c3; //c4= (c1.operator+(c2)).operator+(c3)
	complex c5 = (complex)10 + c1; //c5=10.operator+(c1);

	if (c4 == c3)
		cout << "c3 and c4 are equal" << endl;
	if (c3 == 3)
		cout << "c5 is equal to 3" << endl;
	c4.print();



	return 0;


}
