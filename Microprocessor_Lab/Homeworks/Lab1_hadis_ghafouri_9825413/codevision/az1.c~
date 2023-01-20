/*
 * az1.c  
 *hadis ghafouri 9825413
 *
 * Created: 10/12/2022 7:01:00 AM
 * Author: Win 10
 */

#include <io.h>
#include <delay.h>

unsigned char i;

unsigned int sevenSeg[] = {
    0b00111111, // number 0 on 7_seg
    0b00000110, // number 1 on 7_seg
    0b01011011, // number 2 on 7_seg
    0b01001111, // number 3 on 7_seg
    0b01100110, // number 4 on 7_seg
    0b01101101, // number 5 on 7_seg
    0b01111101, // number 6 on 7_seg
    0b00000111, // number 7 on 7_seg
    0b01111111, // number 8 on 7_seg
    0b01101111, // number 9 on 7_seg
};


void subRoutine1();
void subRoutine2();
void subRoutine3();
void subRoutine4();
void subRoutine5();
void subRoutine6();

void main(void)
{
    DDRA = 0x00;
    DDRB = 0xFF;
    DDRC = 0xFF;
    DDRD = 0x0F;

    subRoutine1();
    subRoutine2();
    subRoutine4();

    while (1)
    {
        subRoutine3();
        subRoutine5();
        subRoutine6();
    }
}

void subRoutine1()
{
    for (i = 0; i < 4; i++)
    {
        PORTB = 0xFF; // turn on LEDs
        delay_ms(500);
        PORTB = 0x00; // turn of LEDs
        delay_ms(500);
    }
}

void subRoutine2()
{

    unsigned int number;
    number = 1;
    DDRB = 0xFF;
    for (i = 0; i < 20; i++)
    {
        PORTB = number; // turn on all portB
        delay_ms(150);
        number = number * 2; // turn on next LED
        if (number > 128)
        {
            number = 1;
        }
    }
}

void subRoutine3()
{
    PORTB = PINA;
}

void subRoutine4()
{
    PORTD = 0x00;

    for (i = 9; i != 0xFF; i--)
    {
        PORTC = sevenSeg[i];
        delay_ms(1000);
    }
}

void subRoutine5()
{
    unsigned int h, s, d, y, number;

    number = PINA;
    number = number * 10;

    while (number >= 0)
    {
        h = number / 1000;
        s = (number % 1000) / 100;
        d = (number % 100) / 10;
        y = number % 10;

        for (i = 0; i < 20; i++)
        {
            PORTD = 0b0111;
            PORTC = sevenSeg[y];
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1011;
            PORTC = sevenSeg[d] + 0x80;
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1101;
            PORTC = sevenSeg[s];
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1110;
            PORTC = sevenSeg[h];
            delay_ms(4);
            PORTD = 0b1111;
        }

        delay_ms(200);

        number -= 2;
    }
}

void subRoutine6()
{
    unsigned int h, s, d, y, number, number1, number2, temp;

    number = PINA;
    number1 = number * 10;
    number2 = number * 10;

    while (number2 >= 0)
    {
        if (PIND.4 == 0)
        {
            number2 = number2 / 10;
            number2 = number2 * 10;
        }

        if (PIND.5 == 0)
        {
            temp = number2 % 10;
            number2 = temp + ((number2 / 100) * 100);
        }
        if (PIND.6 == 0)
        {
            temp = number2 % 100;
            number2 = temp + ((number2 / 1000) * 1000);
        }
        if (PIND.7 == 0)
        {
            number2 = number2 % 1000;
        }

        number1 = number2;

        h = number1 / 1000;
        s = (number1 % 1000) / 100;
        d = (number1 % 100) / 10;
        y = number1 % 10;

        for (i = 0; i < 20; i++)
        {
            PORTD = 0b0111;
            PORTC = sevenSeg[y];
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1011;
            PORTC = sevenSeg[d] + 0x80;
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1101;
            PORTC = sevenSeg[s];
            delay_ms(4);
            PORTD = 0b1111;

            PORTD = 0b1110;
            PORTC = sevenSeg[h];
            delay_ms(4);
            PORTD = 0b1111;
        }
        number2 -= 2;
        delay_ms(200);
    }
}
