#include "headers.h"

char *output_time = "  :  :  ";

int hour = 5;
int minute = 50;
int second = 40;

float get_radian(float degree)
{
    return degree * (3.14 / 180.0);
}

int get_clock_unit_x2(int x1, int amount, char time_unit)
{
    int x2;

    switch (time_unit)
    {
    case 's': //* second
        x2 = x1 + (27 * sin(get_radian(6 * amount)));
        break;

    case 'm': //* minute
        x2 = x1 + (23 * sin(get_radian(6 * amount)));
        break;

    case 'h': //* hour
        x2 = x1 + (18 * sin(get_radian(30 * amount)));
        break;

    default:
        break;
    }

    return x2;
}

int get_clock_unit_y2(int y1, int amount, char time_unit)
{
    int y2;

    switch (time_unit)
    {
    case 's': //* second
        y2 = y1 - (27 * cos(get_radian(6 * amount)));
        break;

    case 'm': //* minute
        y2 = y1 - (23 * cos(get_radian(6 * amount)));
        break;

    case 'h': //* hour
        y2 = y1 - (18 * cos(get_radian(30 * amount)));
        break;

    default:
        break;
    }

    return y2;
}

void draw_clock_lines(int amount, char time_unit)
{

    //* glcd_line(x1,y1,x2,y2);
    int x1, x2, y1, y2;
    x1 = 32;
    y1 = 31;

    switch (time_unit)
    {
    case 's': //* second
        x2 = get_clock_unit_x2(x1, amount, 's');
        y2 = get_clock_unit_y2(y1, amount, 's');
        break;

    case 'm': //* minute
        x2 = get_clock_unit_x2(x1, amount, 'm');
        y2 = get_clock_unit_y2(y1, amount, 'm');
        break;

    case 'h': //* hour
        x2 = get_clock_unit_x2(x1, amount, 'h');
        y2 = get_clock_unit_y2(y1, amount, 'h');
        break;

    default:
        break;
    }

    glcd_line(x1, y1, x2, y2);
}

void update_clock()
{
    glcd_clear();
    draw_clock_lines(second, 's');
    draw_clock_lines(minute, 'm');
    draw_clock_lines(hour, 'h');

    sprintf(output_time, "%d:%d:%d   ", hour, minute, second);
    glcd_outtextxy(70, 40, output_time);

    glcd_outtextxy(30, 50, " "); // should be here
    glcd_outtextxy(30, 50, "6");
    glcd_outtextxy(54, 30, "3");
    glcd_outtextxy(4, 31, "9");
    glcd_outtextxy(27, 3, "12");

    glcd_circle(32, 31, 30);
    //* 32 = x specifies the horizontal coordinate of the circle's center
    //* 31 = y specifies the vertical coordinate of the circle's center
    //* 30 = specifies the circle's radius
}

interrupt[TIM1_OVF] void timer1_ovf_isr(void)
{
    // Reinitialize Timer1 value
    TCNT1H = 0x85EE >> 8;
    TCNT1L = 0x85EE & 0xff;

    second++;
    if (second == 60)
    {
        second = 0;
        minute++;
        if (minute == 60)
        {
            minute = 0;
            hour++;
            if (hour == 12)
            {
                hour = 0;
            }
        }
    }
    update_clock();
}
