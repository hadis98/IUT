#include <iostream>       // std::cin, std::cout
#include <queue>          // std::queue
#include <list>
using namespace std;
int main()
{
	queue<int> myqueue;
	int myint;

	cout << "Please enter some integers (enter 0 to end):\n";

	do {
		cin >> myint;
		if (myint == 0)
			break;
		myqueue.push(myint);
	} while (true);
	
	myqueue.back() -= myqueue.front();
	cout << "myqueue.back() is now " << myqueue.back() << '\n';


	cout << "myqueue contains: "<<myqueue.size()<<"elements that are:\n ";
	while (!myqueue.empty())
	{
		cout << ' ' << myqueue.front();
		myqueue.pop();
	}
	cout << '\n';

	return 0;
}