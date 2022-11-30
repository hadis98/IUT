#pragma once
class Field
{
	int length;
	int width;
	int end_line;
public:
	Field(int width,int height, int endLine);
	int check_place(int& x, int& y);
	~Field();
};

