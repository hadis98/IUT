#include <iostream> 
using namespace std;
 
double vals[] = {10.1, 12.6, 33.1, 24.1, 50.0};
 
double& setValues( int i ) {
if(i<5 && i>-1)
   return vals[i];   // return a reference to the ith element
}
 
// main function to call above defined function.
int main () {
 
   cout << "Value before change" << endl;
   for ( int i = 0; i < 5; i++ ) {
      cout << "vals[" << i << "] = ";
      cout << vals[i] << endl;
   }
   cout<<setValues(2);
   setValues(1) = 20.23; // change 2nd element
   vals[1]=20.23;

   setValues(3) = 70.8;  // change 4th element
 
   cout << "Value after change" << endl;
   for ( int i = 0; i < 5; i++ ) {
      cout << "vals[" << i << "] = ";
      cout << vals[i] << endl;
   }
	
   return 0;
}


// be careful:

int* func() {
   int q;
   return &q; // logical or run-time error
}
int& x=func(); // int & x=q; 











  static int x;
   return x;     // Safe, x lives outside this scope
} 









