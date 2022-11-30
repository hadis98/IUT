#include<iostream>
using namespace std;

class Point
{
private:
	int x, y;
public:
	Point(int x1, int y1) {
		x = x1; y = y1;
	}
	~Point(){
		cout << "destructor is called for point: ("<<x<<","<<y<<")\n";
	}
	int getX()            { return x; }
	int getY()            { return y; }
};

int compx(Point p1, Point p2)
{
	if (p1.getX() > p2.getX())
		return 1;
	else if (p1.getX() == p2.getX())
		return 0;
	else
		return -1;
}
Point largerx(Point &p1, Point &p2)
{

	if (p1.getX() > p2.getX())
		return p1;
	else
		return p2;
}
int main()
{
	Point p1(10, 15); // Normal constructor is called here
	Point p2(12, 17); // Normal constructor is called here


	if (compx(p1, p2))
		cout << "The first point has larger x\n";
	Point p4 = p1;

	Point p3(0, 0);
	p3 = largerx(p1, p2);
	cout << "the larger: x=" << p3.getX() << " y=" << p3.getY();
	// Let us access values assigned by constructors
	cout << "p1.x = " << p1.getX() << ", p1.y = " << p1.getY()<<endl;
	cout << "p4.x = " << p4.getX() << ", p4.y = " << p4.getY()<<endl;

	return 0;

}