
#include <iostream>
using namespace std;

class complex
{
	double real;
	double image;
public:
	complex(double i, double r)  { image = i; real = r; }
	complex operator+(const complex &);
	complex operator+(const double);
	friend complex operator+(const double d, const complex& obj);
	friend bool operator==(const double d, const complex& obj);
	bool operator==(const complex&);
	complex& operator+=(complex &);
	complex& operator++();
	complex operator++(int);
	friend ostream& operator<<(ostream&, const complex&);
	friend istream& operator>>(istream &, complex &);
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
complex complex::operator+(const double d)
{
	double i_result = image;
	double r_result = real + d;
	complex result = complex(i_result, r_result);
	return result;

}

complex operator+(const double d, const complex& obj)
{
	double i_result = obj.image;
	double r_result = obj.real + d;
	complex result = complex(i_result, r_result);
	return result;
}
bool complex::operator==(const complex& obj)
{
	if (this->real == obj.real && this->image == obj.real)
		return true;
	else
		return false;
}
bool operator==(const double r, const complex& obj)
{
	if (r == obj.real && obj.image == 0)
		return true;
	else
		return false;
}
ostream& operator<<(ostream& out, const complex &obj)
{
	out << obj.real;
	if (obj.image > 0)
		cout << "+" << obj.image << "i" << endl;
	else if (obj.image < 0)
		cout << obj.image << "i" << endl;
	return out;
}
//cin>>c1>>x>>y; //extraction
istream& operator>>(istream& in, complex& obj)
{
	cout << "enter the real and image" << endl;
	in >> obj.real;  //in.operator>>(obj.real)
	in.ignore(1);
	in >> obj.image; //3+2i
	//char ch[110];
	//cin >> skipws >> ch;
	//cin.getline(ch, 100);
	//in.getline(ch,10);
	//in>> obj.real;
	return in;
}

int main()
{
	complex c1(12, -4); //c1=12-4i
	complex c2(2, -8);  //c2= 2-8i
	complex c3 = c1.operator+(c2); //c3=14-12i
	complex c4 = c1 + 2;

	return 0;
}
