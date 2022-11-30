#include <iostream>       // std::cout
#include <queue> // std::priority_queue
using namespace std;
int main()
{
	priority_queue<int, deque<int>> mypq;
	int sum = 0, myint;
	cout << "Please enter some integers (enter 0 to end):\n";
	do {
		cin >> myint;
		if (myint == 0)
			break;
		mypq.push(myint);
	} while (true);

	while (!mypq.empty())
	{
		sum += mypq.top();
		cout << mypq.top() << " ";
		mypq.pop();
	}

	cout << "total: " << sum << '\n';

	return 0;
}