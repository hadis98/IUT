#pragma once
#include "date.h"
class Engine
{
	long int fuel_usage;
	float price;
	Date last_service;
	const Date pr_date;

public:
	Engine(Date pr_d, float price,int fuel_usage);
	int use(int);
	~Engine();
};

