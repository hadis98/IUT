#include "subTasks.h"


interrupt[TIM0_OVF] void timer0_ovf_isr(void)
{
    subTask3();
}

void subTask3()
{
    // OCR0 = 2.55 * duty-cycle
    // convert [0%,100%] to [n=0,n=1023]    
    // => OCR0 = 0.25 * ADC0    
    duty_cycle = read_adc(0);
    // duty_cycle = (duty_cycle * 0.087) + 5;
    duty_cycle = ((adc * 90) / 1023) + 5;
    myocr = (2.55 * duty_cycle) + 0.5;
    OCR0 = floor(myocr);
}

void Q3_init_timer0()
{
    TCCR0 = (1 << WGM00) | (1 << COM01) | (0 << COM00) | (1 << WGM01) | (0 << CS02) | (0 << CS01) | (1 << CS00);
    TCNT0 = 0x00;
    OCR0 = 0x00;

    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (0 << TOIE1) | (0 << OCIE0) | (1 << TOIE0);
}