#pragma once
#include "engine.h"
#include "date.h"
#include "field.h"
#include <iostream>
using namespace std;
class Car
{
	Engine engine;
	const Date pr_date;
	double price;
	int x_pos;
	int y_pos;
	Field field;
	int fuel;
public:
    Car(Engine, Date, double, Field);
	int move(int dx, int dy);
	void position();
	
};
