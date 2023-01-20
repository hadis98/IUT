#include "headers.h"
#include "clock.h"

int i, j;

const unsigned short Lab8_Q1_HG[] = {
    // 32 numbers =>index = [0,31]
    0x07, 0x00, 0xFF, 0x08, 0x08, 0x08, 0x08, 0xFF, 0x00, // Code for char H
    0x07, 0x00, 0x7E, 0x42, 0x42, 0x52, 0x52, 0x72, 0x00, // Code for char G
    0x07, 0x00, 0xFF, 0x08, 0x08, 0x08, 0x08, 0xFF, 0x00, // Code for char H
    0x07, 0x00, 0x7E, 0x42, 0x42, 0x52, 0x52, 0x72, 0x00, // Code for char G
};

unsigned char R_data[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};

int config_portD(int a, int b)
{
    if (b - a < 8)
        return 0;
    return 1;
}

int config_portA(int index) // PORTA works as Rows in font matrix
{    
    //(j - i) % 8 = 0 1 2 3 4 5 6 7 => row { Decimal: 1 2 4 8 16 32 64 128 # Hex: 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 }
    return R_data[index];
}

void subRoutine1()
{

    for (i = 0; i < 16; i++)
    {
        for (j = i; j < i + 16; j++)
        {
            PORTD.7 = config_portD(i, j);
            PORTA = config_portA((j - i) % 8);
            PORTB = Lab8_Q1_HG[j]; // Columns in font matrix
            delay_ms(3);
        }
        delay_ms(7);
    }
}

void subRoutine2()
{
    glcd_putimagef(0, 0, new_image, GLCD_PUTCOPY);
}

void subRoutine3()
{
    // _timer_init_();
#asm("sei");
    update_clock();
}