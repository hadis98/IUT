#include <iostream>
#include <list> 
using namespace std;
int main() {
	list<int> lst1, lst2;
	int i;
	for (i = 0; i < 10; i++) 
		lst1.push_back(i); 
	for (i = 0; i < 10; i++) 
		lst2.push_front(i);
	list<int>::iterator p;
	cout << "Contents of lst1:\n"; 
	p = lst1.begin();
	while (p != lst1.end()) {
		cout << *p << " ";
		p++;
	} 
	cout << "\n\n";
	cout << "Contents of lst2:\n";
	p = lst2.begin(); 
	while (p != lst2.end()) {
		cout << *p << " ";
		p++;
	}
	return 0;
}