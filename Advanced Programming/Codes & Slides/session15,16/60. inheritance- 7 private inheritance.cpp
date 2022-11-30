#include <iostream> 
using namespace std;
class base {
protected: 
	int i, j;
public:
	void set(int a, int b) { i = a; j = b; }
	void show() { cout << i << " " << j << "\n"; }
};
// Now, all elements of base are private in derived1.
class derived1 : private base
{ 
	int k;
public:
// this is legal because i and j are private to derived1
	void setk() { k = i*j; } // OK 
	void showk() { cout << k << "\n"; }
};
// Access to i, j, set(), and show() is not inherited. 
class derived2 : public derived1 { 
	int m;
public:
// illegal because i and j are private to derived1 
	void setm() { m = i-j; } // Error 
	void showm() { cout << m << "\n"; }
};
int main() {
	derived1 ob1; 
	derived2 ob2;
	ob1.set(1, 2); // error, can't use set()
	ob1.show(); // error, can't use show()
	ob2.set(3, 4); // error, can't use set()
	ob2.show(); // error, can't use show() 
	return 0;
}