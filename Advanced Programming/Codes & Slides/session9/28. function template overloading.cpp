#include <iostream>
using namespace std;

//first version of f() template
template <class X> void f(X a)
{
	cout << "Inside f(X a) : a is " << a << "\n";
}

//***************
//second version of f() template
template <class X, class Y> void f(X a, Y b)
{
	cout << "Inside f(X a, Y b) : a is " << a << ", b is " << b << "\n";
}

// Function template with specific types
template <class X> void f(X a, int b)
{
	cout << "Inside f(X a, int b) : a is " << a << ", b is " << b << "\n";
}
//************
int main()
{
	f(10);       //calls f(X)
	f(10, 20);   //calls f(X, int)
	cin.get();
}
