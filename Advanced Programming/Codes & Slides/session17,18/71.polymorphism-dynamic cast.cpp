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
	virtual int area() { return 0; };
	virtual int perimeter(){ return 0; };
	virtual ~Shape()
	{
		cout << "Shape dstr called \n";
	}

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
	void specificFunction(){}
	~Rectangle()
	{
		cout << "Rectangle dstr called \n";
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
	~circle()
	{
		cout << "Circle dstr called \n";
	}
protected:
	int radius;
};

void calculate(Shape *s)
{
	cout << "the area is:" << s->area() << endl;
	cout << "the perimeter is:" << s->perimeter() << endl;
	/*if (typeid(*s) == typeid(Rectangle))
	{
		Rectangle *r = (Rectangle*)s;
		r->specificFunction();
		r->area();
	}
	*/
	Rectangle *r = dynamic_cast<Rectangle*>(s);
	if (r)
	{
		r->specificFunction();
		r->area();
	}
}
// Main function for the program
int main()
{
	Shape *shape;
	Rectangle *r=new Rectangle(10, 7);
	circle *c=new circle(10, 5);
	shape = r;
	calculate(r);
	shape = c;
	calculate(c);


	return 0;
}