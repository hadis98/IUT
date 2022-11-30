#include <iostream>
using namespace std;
namespace NS1 {
	int i;
	namespace NS2 { // a nested namespace
		int j;
	}
}
int main() {
	NS1::i = 19;
	// NS2::j = 10; //Error, NS2 is not in view
	NS1::NS2::j = 10; // this is right
	cout << NS1::i << " " << NS1::NS2::j << "\n"; 
	
	using namespace NS1::NS2;
	/* Now that NS1 is in view, NS2 can be used to refer to j. */
	cout << NS1::i * NS2::j;
	return 0;
}