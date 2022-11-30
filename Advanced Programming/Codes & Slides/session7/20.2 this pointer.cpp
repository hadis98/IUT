#include <iostream>

using namespace std;

class Box {
public:
	// Constructor definition
	Box(double l = 2.0, double b = 2.0, double h = 2.0) {
		cout << "Constructor called." << endl;
		length = l;
		width = b;
		height = h;
	}

	double Volume() {
		return length * width * height;
	}

	int compareLength(Box box) {
		return this->length > box.length;
	}

private:
	double length;     // Length of a box
	double width;    // width of a box
	double height;     // Height of a box
};


int main(void) {
	Box Box1(3.3, 1.2, 1.5);    // Declare box1
	Box Box2(8.5, 6.0, 2.0);    // Declare box2

	if (Box1.compareLength(Box2)) {
		cout << "Box2 is smaller than Box1" << endl;
	}
	else {
		cout << "Box2 is equal to or larger than Box1" << endl;
	}

	return 0;
}

/*
Output:
Constructor called.
Constructor called.
Box2 is equal to or larger than Box1

Src: https://www.tutorialspoint.com
*/