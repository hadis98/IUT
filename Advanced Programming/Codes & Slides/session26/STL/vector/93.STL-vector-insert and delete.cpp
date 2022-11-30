#include <iostream> 
#include <vector> 
using namespace std;


int main() {
	vector<char> v(10);
	vector<char> v2;
	char str[] = "<Vector>";
	int i;
	// initialize v
	for (i = 0; i < 10; i++)
		v[i] = i + 'a';
	// copy characters in str into v2 
	for (i = 0; str[i]; i++)
		v2.push_back(str[i]);
	// display original contents of vector 
	cout << "Original contents of v:\n";
	for (i = 0; i < v.size(); i++)
		cout << v[i] << " ";
	cout << "\n\n";
	
	vector<char>::iterator p = v.begin();
	p += 2; // point to 3rd element
	// insert 10 X's into v
	
	v.insert(p, 10, 'X');
	// display contents after insertion
	cout << "Size after inserting X's = " << v.size() << endl;
	cout << "Contents after insert:\n";
	for (i = 0; i < v.size(); i++)
		cout << v[i] << " ";
	cout << "\n\n";
	// remove those elements
	p = v.begin();
	p += 2; // point to 3rd element 
	v.erase(p, p + 10); // remove next 10 elements
	// display contents after deletion
	cout << "Size after erase = " << v.size() << endl;
	cout << "Contents after erase:\n";
	for (i = 0; i < v.size(); i++)
		cout << v[i] << " ";
	cout << "\n\n";
	// Insert v2 into v

	v.insert(v.begin()+2, v2.begin(), v2.end());
	cout << "Size after v2's insertion = ";
	cout << v.size() << endl;
	cout << "Contents after insert:\n";
	for (i = 0; i < v.size(); i++)
		cout << v[i] << " ";
	cout << endl;
	return 0;
}