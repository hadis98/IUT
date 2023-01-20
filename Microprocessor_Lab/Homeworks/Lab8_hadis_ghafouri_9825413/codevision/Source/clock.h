#ifndef _CLOCK_INCLUDED_
#define _CLOCK_INCLUDED_

float get_radian(float degree);
void draw_clock_lines(int amount, int time_unit);
void update_clock();
int get_clock_unit_x2(int x1, int amount, char time_unit);
int get_clock_unit_y2(int y1, int amount, char time_unit);

#endif