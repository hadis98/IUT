#include <iostream>
#include <stack>
#include <deque>
#include <vector>
using namespace  std;
int main()
{

	deque<int> mydeque(3, 100);          // deque with 3 elements
	vector<int> myvector(2, 200);        // vector with 2 elements
	
	stack<int> first;
	stack<int> second(mydeque);
	stack<int, vector<int> > third;  // empty stack using vector
	stack<int, vector<int> > fourth(myvector);

	for (int i = 0; i < 6; i++) first.push(i);
	cout << "size of the stack is " << first.size() << endl;

	first.pop();
	first.pop();
	cout << "size of the stack after two pops is " << first.size() << endl;
	cout<<"top of stack is "<<first.top()<<endl;
	first.top() *= 3;
	cout << "top of stack after *3 is " << first.top() << endl;
	first.swap(second);
	while (!first.empty())
	{
		cout << first.top() << '\n';
		first.pop();
	}

}