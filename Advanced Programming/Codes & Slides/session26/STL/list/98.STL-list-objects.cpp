#include <iostream>
#include <list>
using namespace std;
class myclass {
	int a, b;
	int sum;
public:
	myclass() { a = b = 0; }
	myclass(int i, int j) {
		a = i;
		b = j;
		sum = a + b;
	}
	int getsum() { return sum; }
	 bool operator<( const myclass &o2);
	bool operator>( const myclass &o2);
	
};
bool myclass::operator<(const myclass &o2) {
	return sum < o2.sum;
}
 
 bool myclass::operator>( const myclass &o2) {
 	return sum > o2.sum;
}

int main() {
	int i;
	// create first list 
	list<myclass> lst1;
	for (i = 0; i < 10; i++)
		lst1.push_back(myclass(i, i));
	cout << "First list: ";
	list<myclass>::iterator p = lst1.begin();
	while (p != lst1.end()) {
		cout << p->getsum() << " ";
		p++;
	}
	cout << endl;
	// create a second list 
	list<myclass> lst2;
	for (i = 0; i < 10; i++)
		lst2.push_back(myclass(i * 2, i * 3));
	cout << "Second list: ";
	p = lst2.begin();
	while (p != lst2.end()) {
		cout << p->getsum() << " ";
		p++;
	}
	cout << endl;
	
	// now, merge lst1 and lst2 
	lst1.merge(lst2);
	// display merged list 
	cout << "Merged list: ";
	p = lst1.begin();
	while (p != lst1.end())
	{
		cout << p->getsum() << " ";
		p++;
	}
	return 0;
}