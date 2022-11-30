#include <iostream>
#include <set>
using namespace std;
class name {
	char str[40];
public:
	name() { strcpy(str, ""); }
   	name(char *s) { strcpy(str, s); }
	char *get() { return str; }
};
bool operator<(name a, name b) {
	return strcmp(a.get(), b.get()) < 0;
}
int main()
{
	std::set<int> first;                           // empty set of ints

	int myints[] = { 10, 80, 30, 40, 50 };
	std::set<int> second(myints, myints + 5);        // range

	std::set<int> third(second);                  // a copy of second

	std::set<int> fourth(second.begin(), second.end());  // iterator ctor.


	set<name> nameSet;
	nameSet.insert(name("Ali"));
	nameSet.insert(name("Mina"));
	nameSet.insert(name("Ahmad"));
	name myNames[] = { name("Hasan"), name("Maryam"), name("Ali") };
	nameSet.insert(myNames,myNames+2);
	

	set<name>::iterator itr = nameSet.begin();
	pair<set<name>::iterator, bool>  ret;
	ret = nameSet.insert(name("Ahmad"));
	if (ret.second == false)  itr = ret.first;
	nameSet.insert(itr, name("Ahmar"));


	int myints2[] = { 12, 75, 10, 32, 20, 25 };
	std::set<int> firstSet(myints2, myints2 + 3);     // 10,12,75
	std::set<int> secondSet(myints2 + 3, myints2 + 5);  // 20,32

	firstSet.swap(secondSet);  //first: 20,32  second: 10,12,75

	//erase elements:

	nameSet.erase(name("Mina"));
	nameSet.erase(nameSet.find("Hasan"));
	nameSet.erase(nameSet.find("Ahmad"), nameSet.end());

	
	
	
	
	
	
}