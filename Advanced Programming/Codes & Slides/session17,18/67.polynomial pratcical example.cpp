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
	virtual int area() =0;
	virtual int perimeter(){return 0;};

};

class Rectangle : public Shape{
public:
	Rectangle(int a = 0, int b = 0) :Shape(a, b) { }
	int area()
	{
		cout << "triangle area\n";
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

void calculate(shape &s)
{
	cout << "the area is:" << s.area()<<endl;
	cout << "the perimeter is:" << s.perimeter()<<endl;
}


// Main function for the program
int main()
{
	Shape *shape;
	Rectangle r(10, 7);
	circle c(10, 5);

	calculate(r);
	calculate(c);
	
	
	return 0;
}