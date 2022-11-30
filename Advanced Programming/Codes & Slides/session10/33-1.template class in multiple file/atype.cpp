// A generic safe array example.
#include "atype.h"
#pragma once
// Provide range checking for atype.
template <typename T> T& atype<T>::at (int i) 
{
	if (i<0 || i> SIZE - 1) {
		cout << "\nIndex value of ";
		cout << i << " is out-of-bounds.\n";
		exit(1);
	}
	return a[i];
}







