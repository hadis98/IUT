#include "car.h"

Car::Car(Engine en, Date d, double p, Field fi): field(fi), engine(en), pr_date(d)
{
	
	price = p;
	x_pos = 1;
	y_pos = 1;
	fuel = 100000;
}
int Car::move(int dx, int dy)
{
	x_pos +=dx;
	y_pos +=dy;
	
	fuel-=engine.use(dx*dy);
	if (fuel <= 0)
		fuel = 10000; 
	if (1 == field.check_place(x_pos, y_pos))
		return 1;
	return 0;
}
void Car::position()
{
	cout << "x: " << x_pos << "  y: " << y_pos << endl;
}

