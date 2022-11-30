// count_if example
#include <iostream>     // std::cout
#include <algorithm>    // std::count_if
#include <vector>       // std::vector

bool IsOdd(int i) { return ((i % 2) == 1); }

int main() {
	std::vector<int> myvector;
	for (int i = 1; i<10; i++) myvector.push_back(i); // myvector: 1 2 3 4 5 6 7 8 9

	int mycount = count_if(myvector.begin(), myvector.end(), IsOdd);
	std::cout << "myvector contains " << mycount << " odd values.\n";
	myvector.push_back(3);
	myvector.push_back(5);
	myvector.push_back(8);

	replace(myvector.begin(), myvector.end(), 8, 100);

	replace_if(myvector.begin(), myvector.end(), IsOdd, 0);

	for (std::vector<int>::iterator it = myvector.begin(); it != myvector.end(); ++it)
		std::cout << ' ' << *it;
	std::cout << '\n';


	auto it = search_n(myvector.begin(), myvector.end(), 2, 8); //searches for 8 8 in the vector (a sequence of two eights)

	return 0;
}