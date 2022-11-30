#include "car.h"
int main()
{
	Date proDate(1, 3, 2014);
	Engine carEngine(proDate, 20000,100);
	Field gameField(40,55,38);
	Car car(carEngine, proDate, 430000, &gameField);
	//equal to:
	//Car c(Engine(Date(1, 3, 2014), 20000,100), Date(1, 3, 2014), 430000,Field(4,5,3));

	if (1 == car.move(10, 4))
		cout << "You Won! \n";
    car.position();

}
