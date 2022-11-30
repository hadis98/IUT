#include <iostream>

using namespace std;

const int SIZE = 10;

template <class T> class atype {
	T a[SIZE];
public:
	atype() {
		int i;
		for (i = 0; i<SIZE; i++) a[i] = i;
	}
	
	T&  operator[](int i) ;// range checking a[10] subscript operator
	T  operator[](int i) const ;
	};
