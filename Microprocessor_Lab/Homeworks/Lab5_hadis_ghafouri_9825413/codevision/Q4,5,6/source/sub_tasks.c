#include "sub_tasks.h"

// question5 variables
int timer2OF_counter = 0;

//question6 variables
bool has_timer1_overflow = false;
int ICR1L_DATA, ICR1H_DATA;
int ICR_DATA1 = 0, ICR_DATA2 = 0;
float period;
int old_speed = 0, new_speed = 0, lcd_display_limit = 0;
char lcd_output[16];

// Timer1 overflow interrupt service routine
interrupt[TIM1_OVF] void timer1_ovf_isr(void)
{

    has_timer1_overflow = true;
}

// Timer1 input capture interrupt service routine
interrupt[TIM1_CAPT] void timer1_capt_isr(void)
{
    q6_handle_timer1_capture();
}

// Timer2 overflow interrupt service routine
interrupt[TIM2_OVF] void timer2_ovf_isr(void)
{
    TCNT2 = 0x06;
    timer2OF_counter++;

    if (timer2OF_counter == 26) // counter should go to 25 in order to have 100ms
        timer2OF_counter = 0;
}

void q3_custom_pwm_wave(int custom_duty)
{
    OCR0 = (custom_duty * 2.55) + 0.5;
}

void q4_subTask()
{
    // OCR0 = 2.55 * duty-cycle (approximately)
    // duty-cycle = (100/255) * port_data
    // => OCR0 = port_data
    OCR0 = PINA;
}

void q5_subTask()
{
    // step = 10 => pulse per cycle = 360/10 = 36
    // Speed(rpm) = S
    // T or Time between sending pulse = 100ms=0.1s => 0.1 = 60 / (S * 36) => S=16
    lcd_gotoxy(0, 0);
    lcd_puts("S(SP): 16rpm");
    two_phase_step();
    PORTB = 0x00;
    delay_ms(500);
    two_phase_step_reverse();
    delay_ms(500);
    PORTB = 0x00;
    lcd_clear();
}

void two_phase_step()
{
    PORTB = 0x30;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0x60;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0xc0;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0x90;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
}

void two_phase_step_reverse()
{
    PORTB = 0xc0;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0x60;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0x30;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
    PORTB = 0x90;
    timer2OF_counter = 0;
    while (timer2OF_counter < 25)
        ;
}

void q6_handle_timer1_capture()
{
    if (has_timer1_overflow == true)
    {
        has_timer1_overflow = false;
        return;
    }

    ICR1L_DATA = ICR1L;
    ICR1H_DATA = ICR1H;

    ICR_DATA2 = (ICR1H_DATA << 8) | ICR1L_DATA;
    period = ICR_DATA2 - ICR_DATA1;
    ICR_DATA1 = ICR_DATA2; // to keep last ICR data

    // dc motor : 50 pulse per revolution
    // period = duration of one pulse(in us)
    // rpm = revolution per minute(60 seconds)
    // => speed(rpm) = 60 / ((period/1000000) * 50)
    new_speed = (60 * 1000000) / (period * 50);

    if (has_speeds_difference(old_speed, new_speed))
    {
        if (lcd_display_limit == 5)
        {

            old_speed = new_speed;
            print_dc_motor_speed(new_speed);
            lcd_display_limit = 0;
        }
        else
        {
            lcd_display_limit++;
        }
    }
}

void print_dc_motor_speed(int speed)
{
    sprintf(lcd_output, "S(DC)=%d rpm", speed);
    lcd_gotoxy(0, 1);
    lcd_puts(lcd_output);
}

bool has_speeds_difference(int old_speed, int new_speed)
{
    return (old_speed - new_speed >= 5) || (old_speed - new_speed <= -5);
}