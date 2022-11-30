#include <iostream>
#include <set>
using namespace std;
int main()
{
	multiset<int> first;                          // empty multiset of ints

	int myints[] = { 10, 20, 30, 20, 20 };
	multiset<int> second(myints, myints + 5);       // pointers used as iterators

	multiset<int> third(second);                 // a copy of second

	multiset<int> fourth(second.begin(), second.end());  // iterator ctor.
	cout << "number of 20s in the second set is " << second.count(20) << endl;

	multiset<int>::iterator it;
	it = second.begin();
	it++;

	second.erase(it);
	second.erase(20); //erase all 20s

	it = second.find(30);
	second.erase(it);


}