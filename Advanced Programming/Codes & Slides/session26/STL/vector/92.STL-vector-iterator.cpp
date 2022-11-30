#include <iostream> 
#include <vector>
#include <cctype>
using namespace std;
int main() {
	vector<char> v(10); // create a vector of length 10 
	vector<char>::iterator p; // create an iterator
	int A[10];
	int *ptr;
	ptr=A;
	int i;
	// assign elements in vector a value 
	p = v.begin();
	i = 0;
	while (p != v.end()) {
		*p = i + 'a'; //v[i]=i+'a'
		p++;
		i++;
	}
	// display contents of vector 
	cout << "Original contents:\n";
	p = v.begin();
	while (p != v.end()) {
		cout << *p << " ";
		p++;
	}
	cout << "\n\n";
	// change contents of vector 
	p = v.begin();
	while (p != v.end()) {
		*p = toupper(*p);
		p++;
	}
	// display contents of vector 
	cout << "Modified Contents:\n";
	p = v.begin();
	while (p != v.end()) {
		cout << *p << " ";
		p++;
	}
	
	cout << endl;
	return 0;
}