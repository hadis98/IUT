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


	stack s[10]={stack(12), stack(13),} 

	myclass<int> i(10);
	cout << "int: " << i.getx() << "\n";

	myclass<int> array[2] = { myclass<int>(2), myclass<int>(5) };
	cout<<array[0].getx();


	myclass<double> d(10.1);
	cout << "double: " << d.getx() << "\n\n";

	myclass<float> f(5);
	cout << "float: " << f.getx() << "\n";
	return 0;
}
