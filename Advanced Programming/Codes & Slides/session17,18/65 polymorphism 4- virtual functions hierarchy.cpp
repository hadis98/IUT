#include <iostream>
using namespace std;
class base {
public:
	virtual void vfunc() { cout << "This is base's vfunc().\n"; }
};
class derived1 : public base {
public:
	void vfunc() { cout << "This is derived1's vfunc().\n"; }
}; 
class derived2 : public derived1 { 
public:
	// vfunc() not overridden by derived2,
};
	int main() {
		base *p, b; 
		derived1 d1; 
		derived2 d2;
		// point to base
		p = &b;
		p->vfunc(); // access ? vfunc()
		// point to derived1 
		p = &d1;
		p->vfunc(); // access ? vfunc()
		// point to derived2 
		p = &d2;
		p->vfunc(); // use ? vfunc() 
		return 0;
	}