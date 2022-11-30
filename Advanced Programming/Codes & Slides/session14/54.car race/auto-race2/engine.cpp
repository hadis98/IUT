#include "engine.h"


Engine::Engine(Date d, float pr,int usage) :last_service(d), pr_date(d)
{
	price = pr;
	fuel_usage = usage;
}


Engine::~Engine()
{
}

int Engine::use(int km)
{

	return fuel_usage*km;
}
