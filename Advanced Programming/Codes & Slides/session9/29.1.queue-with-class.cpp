#define MAX 100
class queue
{
private:
	int intArray[MAX];
	int front;
	int rear;
	int itemCount;
public:
	queue()
	{

		front = 0;
		rear = -1;
		itemCount = 0;

	}
	void insert(int data) {

		if (!isFull()) {

			if (rear == MAX - 1) {
				rear = -1;
			}

			intArray[++rear] = data;
			itemCount++;
		}
	}

	int removeData() {
		int data = intArray[front++];

		if (front == MAX) {
			front = 0;
		}

		itemCount--;
		return data;
	}
	bool isEmpty() {
		return itemCount == 0;
	}

	bool isFull() {
		return itemCount == MAX;
	}

	int size() {
		return itemCount;
	}

private:
	int peek() {
		return intArray[front];
	}

	


};

#include <iostream>
using namespace std;
int main()
{
	queue q1;
	q1.insert(1);
	q1.insert(2);
	q1.insert(3);
	q1.insert(4);
	while (!q1.isEmpty())
	{
		cout << q1.removeData()<<endl;
	}
}