#include <iostream>
using namespace std;
//operators: binary: + * / - < > <= >= == += -= % & | 
// member function:complex operator+(const complex& obj);  \\ c1.operator+(c2)
//non-member: complex operator+(const complex &obj1, const complex& obj2) \\ operator+(c1, c2)
// unary: ++ -- ! 
// ++ prefix ++c1 += c2      complex complex& operator++
//postfix c1++ + c2   \\ (c1.operator++()).operator+(c2)
// member function: complex operator!() \\!c1 c1.operator!()
//non-member function: complex operator!(const complex obj&)\\ !c1 operator!(c1)
class complex
{
	double real;
	double image;
public:
	//prefix ++
	complex& operator++(){
		this->real++;
		this->image++;
		return *this;
	}
	//postfix
	complex operator++(int){
		complex tmp = *this;
		this->real++;
		this->image++;
		return tmp;
	}
	complex(double i, double r)  { image = i; real = r; }
	complex operator+(const complex &) const;
	complex operator+(const double) const;
	friend complex operator+(const double d, const complex& obj);

	friend bool operator==(const double d, const complex& obj);
	bool operator==(const complex&)const;
	complex& operator+=(const complex &);  // returns reference because we want to have (c1+=c2)+=c3 also prevent generating additional copy by calling cpy cstr
	void print() ;
	complex operator!()const{
		complex tmp(0,0);
		tmp.real = this->real*-1;
		tmp.image = this->image*-1;
		return tmp;
	}
	friend ostream& operator<<(ostream & , complex & );
};




complex& complex::operator+=(const complex &obj)
{
	this->image += obj.image;
	this->real += obj.real;
	//return this;
	return *this;
}
complex complex::operator+(const complex &obj)const
{
	complex new_obj(0, 0);
	new_obj.real = this->real + obj.real;
	new_obj.image = this->image + obj.image;
	return new_obj;
}
complex complex::operator+(const double d)const
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
bool complex::operator==(const complex& obj)const
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

ostream& operator<<(ostream & out, complex & obj) 
{
	out << obj.real;
	if (obj.image > 0)
		out << "+" << obj.image << "i" << endl;
	else if (obj.image < 0)
		out << obj.image << "i" << endl;
	return out;
}

int main()
{
	const complex c1(12, -4); //c1=12-4i
	complex c2(2, -8);  //c2= 2-8i
	complex c3 = c2++  + 4; //c3=14-12i //c2.operator++(1)
	cout << c3<<endl;  // cout.operator<<
	// operator<<(cout, c3). operator<<(endl)
	//operator<<  insertion cout  ostream
	// ((cout.operator<<("the complex number is")).operator<<(c3)).operator<<(endl)
	//c3.print();
	if (c1.operator==(c2))
		cout << "c1 is equal to c2" << endl;
	c2 = !c1;
	c3+= c2;
	c3 += c2 += c1;
	complex c4 = c1 + 4; //c4=c1.operator+(4);
	c4 = c1 + c2 + c3; //c4= (c1.operator+(c2)).operator+(c3)
	complex c5 = 10 + c1; //c5=10.operator+(c1);
	complex c6 = operator+(10, c2);

	if (c4 == c3)
		cout << "c3 and c4 are equal" << endl;
	if (3 == c5)
		cout << "c5 is equal to 3" << endl;



	return 0;


}
