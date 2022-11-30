#include <iostream>
using namespace std;
template <typename T> class classA 
{
	T data;
	int length;
public:
	classA(T d, int c){ data = d, length = c; }
	void print(){ cout << data << " " << length<<endl; }
};


class classB
{
	classA<int> a;
	float something;
public:
	classB(int m, int n, float s):a(m, n){ something = s; }
	void print(){ cout << something<<endl; }
};


template <class T>
class classC
{
	classA<T> a;
	char c;
public:
	classC(T m, int n, char ch) :a(m,n){ c = ch; }
	void print(){ cout << c<<endl; }
};
int main()
{
	classA<int> a(12, 3);
	a.print();
	classB  b(12, 4, 23.1);
	b.print();
	classC<int> c(12, 3, 'i');
	c.print();
	return 0;
}




