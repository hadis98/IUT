  #include "atype.h"
  int main()
  {
  	const atype<int> intob; // integer array
  	atype<double> doubleob; // double array
  	int i;
  	cout << "Integer array: "; // a[i] operator[] 
  //for (i = 0; i<SIZE; i++) intob[i] = i;//intob.operator[](i)
  	for (i = 0; i<SIZE; i++) cout << intob[i] << " ";
  	cout << '\n';
  	cout << "Double array: ";
  	for (i = 0; i<SIZE; i++) doubleob[i] = (double)i / 3;
  	for (i = 0; i<SIZE; i++) cout << doubleob[i] << " ";
  	cout << '\n';
  	//intob[12] = 100; // generates runtime error
  	return 0;
  }