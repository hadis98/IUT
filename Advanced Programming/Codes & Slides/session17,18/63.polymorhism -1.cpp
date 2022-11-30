#include <iostream>
using namespace std;

class Shape {
protected:
	int x, y;
public:
	Shape(int a = 0, int b = 0)
	{
		x = a;
		y = b;
	}
	void move(int dx, int dy)
	{
		x += dx;
		y += dy;

	}

};

class Rectangle : public Shape{
public:
	Rectangle(int a = 0, int b = 0) :Shape(a, b) { }
	int area()
	{
		cout << "Rectangle area\n";
		return (width * height);
	}
	int perimeter()
	{
		return 2 * (width + height);
	}
protected:
	int height, width;
};


class circle : public Shape{
public:
	circle(int a = 0, int b = 0) :Shape(a, b) { }
	int area()
	{
		cout << "circle area\n";
		return  3.14*radius*radius;
	}
	int perimeter()
	{
		return 2 * 3.14*radius;
	}

protected:
	int radius;
};

// Main function for the program
int main()
{
	Rectangle rect;
	circle crl;
	Shape * s1 = &rect;
	Shape * s2 = &crl;
	s1->move(6,7);
	s2->move(4,5);
	cout << rect.area() << '\n';
	cout << crl.area() << '\n';
	return 0;
}