// A generic safe array example.
#include "atype.h"

// Provide range checking for atype.
template <class T> T& atype<T>::operator[](int i) 
{
	if (i<0 || i> SIZE - 1) {
		cout << "\nIndex value of ";
		cout << i << " is out-of-bounds.\n";
		return NULL;
	}
	return a[i];
}
template <class T> T atype<T>::operator[](int i) const
{
	if (i<0 || i> SIZE - 1) {
		cout << "\nIndex value of ";
		cout << i << " is out-of-bounds.\n";
		exit(1);
	}
	return a[i];
}


template class atype<int>;
template  class atype<double>;
