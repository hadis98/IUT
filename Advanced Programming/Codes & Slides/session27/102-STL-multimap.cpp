#include <iostream>
#include <map>
using namespace std;
int main()
{
	multimap<char, int> firstMap;
	firstMap.insert(pair<char, int>('a', 97));
	firstMap.insert(pair<char, int>('b', 98));
	firstMap.insert(pair<char, int>('c', 99));

	multimap<char, int> secondMap(++firstMap.begin(), firstMap.end());
	secondMap.insert(pair<char, int>('c', 100));
	secondMap.insert(pair<char, int>('c', 99));


	cout << "number of elements with key 'c' is " << secondMap.count('c')<<endl;


	multimap<char, int> thirdMap(secondMap.begin(), secondMap.find('d')); 
	multimap<char, int>::iterator it;
	for (it = secondMap.begin(); it != secondMap.end(); ++it)
		cout << it->first << " => " << it->second << '\n';

	multimap<char, int>::iterator ptr = secondMap.find('c');
	secondMap.erase(ptr);
	secondMap.erase('c');
	secondMap.erase(secondMap.find('b'), secondMap.end());
	if (secondMap.empty())
		cout << "Second map is empty\n";


	thirdMap.clear();
	thirdMap.insert(make_pair('a', 10));
	thirdMap.insert(make_pair('b', 121));
	thirdMap.insert(make_pair('c', 1001));
	thirdMap.insert(make_pair('c', 2002));
	thirdMap.insert(make_pair('d', 11011));
	thirdMap.insert(make_pair('e', 44));

	multimap<char, int>::iterator itlow, itup;
	itlow = thirdMap.lower_bound('b');  // itlow points to b
	itup = thirdMap.upper_bound('d');   // itup points to e (not d)

	// print range [itlow,itup):
	for (it = itlow; it != itup; ++it)
		std::cout << it->first << " => " << it->second << '\n';

	//if you want to print all elements of the some keys
	pair <multimap<char, int>::iterator, multimap<char, int>::iterator> ret;
	for (char c = 'a'; c < 'f'; c++) 
	{
		ret = thirdMap.equal_range(c);
		cout << c<< " =>";
		for (it = ret.first; it != ret.second; it++) // [ ) Pay attention to the loop limit!!!
			cout << ' ' << it->second;
		cout << '\n';

	}

}