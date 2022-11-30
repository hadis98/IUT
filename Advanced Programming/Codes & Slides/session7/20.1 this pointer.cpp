#include <iostream> 
using namespace std;
class pwr {
	double b;
	int e;
	double val; 
public:
		pwr(double base, int exp);
		double get_pwr() { return this->val; }
};
pwr::pwr(double base, int exp) {
	b = base;
	e = exp;
	val = 1;
	if (exp == 0)
		return;
	for (; exp > 0; exp--)
		val = val * b;
}

int main() {
	pwr x(4.0, 2), y(2.5, 1), z(5.7, 0);
	cout << x.get_pwr() << " "; 
	cout << y.get_pwr() << " "; 
	cout << z.get_pwr() << "\n";
	return 0;
}



/*
pwr::pwr(double base, int exp) {
	this->b = base;
	this->e = exp;
	this->val = 1;
	if (exp == 0) 
		return;
	for (; exp > 0; exp--)
		this->val = this->val * this->b;
}
*/