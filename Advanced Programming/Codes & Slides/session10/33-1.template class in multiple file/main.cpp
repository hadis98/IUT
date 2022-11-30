  #include "atype.h"

  int main()
  {
  	atype<int> intob;   //integer array
	atype<double> doubleob;   //double array
	atype<char> chartob;   //double array
  	int i;
  	cout << "Integer array: ";
	for (i = 0; i<SIZE; i++) intob.at(i) = i;
	for (i = 0; i<SIZE; i++) chartob.at(i) = i;
  	for (i = 0; i<SIZE; i++) cout << intob.at(i) << " ";
  	cout << '\n';
  	cout << "Double array: ";
  	for (i = 0; i<SIZE; i++) doubleob.at(i) = (double)i / 3;
  	for (i = 0; i<SIZE; i++) cout << doubleob.at(i) << " ";
  	cout << '\n';
  	 intob.at(12) = 100;  // generates runtime error
  	return 0;
  }