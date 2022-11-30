#include <iostream>
using namespace std;
 
int main() {
   int number = 88;          // Declare an int variable called number
   int & refNumber = number; // Declare a reference (alias) to the variable number
                             // Both refNumber and number refer to the same value
 
   cout << number << endl;    // Print value of variable number (88)
   cout << refNumber << endl; // Print value of reference (88)
 
   refNumber = 99;            // Re-assign a new value to refNumber
   cout << refNumber << endl;
   cout << number << endl;    // Value of number also changes (99)
 
   number = 55;               // Re-assign a new value to number
   cout << number << endl;
   cout << refNumber << endl; // Value of refNumber also changes (55)
}
//////////////////////////////////////////


/* Pass-by-reference using pointer (TestPassByPointer.cpp) */
#include <iostream>
using namespace std;
 
void square(int *);
 
int main() {
   int number = 8;
   cout <<  "In main(): " << &number << endl;  // 0x22ff1c
   cout << number << endl;   // 8
   square(&number);          // Explicit referencing to pass an address
   cout << number << endl;   // 64
}
 
void square(int * pNumber) {  // Function takes an int pointer (non-const)
   cout <<  "In square(): " << pNumber << endl;  // 0x22ff1c
   *pNumber *= *pNumber;      // Explicit de-referencing to get the value pointed-to
}
///////////////////////////////////////////////////////////


/* Pass-by-reference using reference (TestPassByReference.cpp) */
#include <iostream>
using namespace std;
 
void square(int &);
 
int main() {
   int number = 8;
   cout <<  "In main(): " << &number << endl;  // 0x22ff1c for example
   cout << number << endl;  // 8
   square(number);          // Implicit referencing (without '&')
   cout << number << endl;  // 64
}
 
void square(int & rNumber) {  // Function takes an int reference (non-const)
   rNumber *= rNumber;        // Implicit de-referencing (without '*')
   
   
   cout <<  "In calculate(): " << &rNumber << endl;  // 0x22ff1c

   
   }


src:https://www3.ntu.edu.sg/home/ehchua/programming/cpp/cp4_PointerReference.html
