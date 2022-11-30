#include <iostream>
#include <deque>
#include <vector>
using namespace std;
int main()
{
	deque<double> values;
	values.push_front(2.2);
	values.push_front(3.5);
	values.push_back(4.9);
	// 3.5 2.2 4.9
	for (int i = 0; i < values.size(); i++)
		cout << values[i] << ' ';
	cout << endl;

	values.pop_front();
	// 2.2 4.9
	
//	values[4] = 5.4;
	try{
		values.at(4) = 5.4;
	}
	catch (out_of_range)
	{
		cout << "4 is out of range"<<endl;
	}
	for (int i = 0; i < values.size(); i++)
		cout << values[i] << ' ';
		//or cout << values.at(i) << ' ';

	deque<double>::iterator it = values.begin();
	
	//auto it=values.begin();
	
	
	it = values.insert(it, 7.7);
	values.insert(it, 2, 1.1);

	it = values.begin() + 2;
	vector<int> myVector(2, 30);
	values.insert(it, myVector.begin(), myVector.end());

	for (it = values.begin(); it != values.end(); ++it)
		std::cout << ' ' << *it;
	std::cout << '\n';


}