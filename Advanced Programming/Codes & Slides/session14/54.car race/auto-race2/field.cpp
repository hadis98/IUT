#include "field.h"


Field::Field(int len, int wid, int endLine)
{
	length = len;
	width = wid;
	end_line = endLine;
	
}


Field::~Field()
{
}

int Field::check_place(int &x, int &y)
{
	int finish=0;
	if (x > end_line)
		finish = 1;
	if (x > length)
		x = length;	
	if (y > width)
		y = width;
	return finish;
 
}