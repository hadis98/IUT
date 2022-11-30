#include <iostream>
using namespace std;
template <class T> class myclass {
	T x;
public:
	myclass(T a) {
		cout << "Inside generic myclass\n";

		x = a;
	}
	T getx() { return x; }
};

// Explicit specialization for int.
template <> class myclass<int> {
	int x;
public:
	myclass(int a) {
		cout << "Inside myclass<int> specialization\n";
		x = a * a;
	}
	int getx() { return x; }
};


int main()
{
	myclass<int> i(10);
	cout << "int: " << i.getx() << "\n";

	myclass<double> d(10.1);
	cout << "double: " << d.getx() << "\n\n";
	
	myclass<float> f(5);
	cout << "float: " << f.getx() << "\n";
	return 0;
}
