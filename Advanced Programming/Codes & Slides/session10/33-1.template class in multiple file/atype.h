#include <iostream>
#pragma  once
using namespace std;
const int SIZE = 10;
template <class T> class atype {  //int a[100] .... a[102]++
	T a[SIZE];
public:
	atype() {
		int i;
		for (i = 0; i<SIZE; i++) a[i] = i;
	}
	T&  at(int i) ;// range checking a[10]
};
