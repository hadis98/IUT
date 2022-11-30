#include <iostream> 
#include <map> 
using namespace std;
int main() {
	map <char, int> m;
	int i;
	// put pairs into map 
	for (i = 0; i < 20; i++) {
		m.insert(pair<char, int>('A' + i, 65 + i));
	}
	//{<A,65>, <B,66>, <C,67>.....}
	
	

	char ch;
	cout << "Enter key: ";
	cin >> ch;
	// find value given key 
    map<char, int>::iterator p;
    
	p = m.find(ch);
	if (p != m.end())
		cout << "Its ASCII value is " << p->second;
	else
		cout << "Key not in map.\n";

	p = m.find('E');
	m.erase(p, m.end());

	m.erase('B'); //erase by key
	cout << "the size of my map is now " << m.size() << endl;
	for (p = m.begin(); p != m.end(); ++p)
		std::cout << p->first << " => " << p->second << '\n';
	m['A'] = m['B'];
	m['C'] = m['Z'];

	pair<map<char, int>::iterator, bool> ret;
	ret = m.insert(pair<char, int>('Z', 500));
	if (ret.second == false) {
		std::cout << "element 'Z' already existed";
		std::cout << " with a value of " << ret.first->second << '\n';
	}

	return 0;
}