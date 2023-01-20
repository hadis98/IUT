#include "headers.h"

// subTask1
int hour = 0;
int minute = 0;
int second = 0;
int hundredth_of_second = 0;
char clicked_timer_button = stop_button;
char timer0_accuracy = 0;

// subTask2
int parking_empty_capacity = max_parking_capacity;

// subTask3
int calculated_period = 0;
long int fr = 0;
long int ocr = 0;
int T = 0;
int is_interrupt2_triggered = 0;

extern char *LCD_TIMER_OUTPUT = "00:00:00:00";
extern char *LCD_CAR_CAPACITY_OUTPUT = "CE:0000";
extern char *LCD_CALCULATED_PERIOD_OUTPUT = "0000000";

// External Interrupt 0 service routine
interrupt[EXT_INT0] void ext_int0_isr(void)
{
    parking_capacity_handler();
}

// External Interrupt 1 service routine
interrupt[EXT_INT1] void ext_int1_isr(void)
{
    timer_button_handler();
}

// Timer 0 overflow interrupt service routine
interrupt[TIM0_OVF] void timer0_ovf_isr(void)
{
    // Reinitialize Timer 0 value
    TCNT0 = 0x83;
    timer_display_digits();
}

// External Interrupt 2 service routine
interrupt[EXT_INT2] void ext_int2_isr(void)
{

    calculate_timer_period('A');
    calculate_timer_period('B');
    output_timer_period_lcd();
    TCNT1H = 0x00;
    TCNT1L = 0x00;
}

//Timer1 output compare A interrupt service routine
interrupt[TIM1_COMPA] void timer1_compa_isr(void)
{

    calculate_timer_period('A');
    output_timer_period_lcd();
}

//Timer1 output compare B interrupt service routine
interrupt[TIM1_COMPB] void timer1_compb_isr(void)
{

    calculate_timer_period('B');
    output_timer_period_lcd();
}

void parking_capacity_handler()
{
    if (car_in_button_port == is_button_clicked && parking_empty_capacity > 0)
    {
        parking_empty_capacity--;
    }
    else if (car_out_button_port == is_button_clicked && parking_empty_capacity < max_parking_capacity)
    {
        parking_empty_capacity++;
    }

    if (parking_empty_capacity == 0)
    {
        sprintf(LCD_CAR_CAPACITY_OUTPUT, "CE:FULL**");
    }
    else
    {
        sprintf(LCD_CAR_CAPACITY_OUTPUT, "CE:%4d**", parking_empty_capacity);
    }

    lcd_gotoxy(0, 1);
    lcd_puts(LCD_CAR_CAPACITY_OUTPUT);
}

void timer_button_handler()
{
    if (clicked_timer_button == stop_button && stop_timer_button_port == is_button_clicked)
    {
        // clicked stop button twice, reset every digit in timer.
        hundredth_of_second = reset;
        second = reset;
        minute = reset;
        hour = reset;
    }

    if (start_timer_button_port == is_button_clicked)
    {
        clicked_timer_button = start_button;
    }
    else
    {
        clicked_timer_button = stop_button;
    }
}

void timer_display_digits()
{
    // timer0 has 1ms period but we need 10ms => we wait until we reach 10ms or 0.01s
    // we want to perform our calculations every 10ms
    if (timer0_accuracy != 10)
    {
        timer0_accuracy++;
    }
    else
    {
        timer0_accuracy = 0;
    }

    if (clicked_timer_button == start_button)
    {
        timer_calculate_digits_handler();
    }

    sprintf(LCD_TIMER_OUTPUT, "%2d:%2d:%2d:%2d", hour, minute, second, hundredth_of_second);
    lcd_gotoxy(0, 0);
    lcd_puts(LCD_TIMER_OUTPUT);
}

void timer_calculate_digits_handler()
{
    if (hundredth_of_second == max_hundredth_of_seconds)
    {
        hundredth_of_second = reset;

        if (second == max_second)
        {
            second = reset;

            if (minute == max_minute)
            {
                minute = reset;

                if (hour == max_hour)
                {
                    hour = reset;
                }
                else
                {
                    hour++;
                }
            }
            else
            {
                minute++;
            }
        }
        else
        {
            second++;
        }
    }
    else
    {
        hundredth_of_second++;
    }
}

void calculate_timer_period(char timer_type)
{
    // based on line equation we know y-y1 = ((y2-y1)/(x2-x1))*(x-x1)
    // here our frequency input is ranged between 0,255 => [0,255]
    // and our output period is ranged between 1us , 10ms => [1us,10000us]
    // so our output frequency is between : [100,1000000]
    // y1 =100  x1=0
    // y2=1000000 x2=255
    // m = (1000'000 - 1)/(255-0) = 999900/255
    // y = 3921.1*x+100

    // F-wave = F-micro / (2 * N * OCR0) here N(pre-scaler = 1) so
    // OCR0 =  F-micro / (F-wave * 2)
    fr = PINA;
    fr = fr * 3921.1 + 100;
    ocr = 8000000 / (fr * 2);

    if (timer_type == 'A')
    {
        OCR1AH = (ocr >> 8);
        OCR1AL = ocr;
    }
    else if (timer_type == 'B')
    {
        OCR1BH = (ocr >> 8);
        OCR1BL = ocr;
    }

    T = 1000000 / (float)fr;
}

void output_timer_period_lcd()
{
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts("Session4\n");
    // delay_ms(1000);
    // if (T % 1000 == 0)
    // {
    //     sprintf(LCD_CALCULATED_PERIOD_OUTPUT, "%4dMS", (T / 1000));
    // }
    // else
    // {
    //     sprintf(LCD_CALCULATED_PERIOD_OUTPUT, "%4dUS", T);
    // }

    // lcd_gotoxy(0, 1);
    // lcd_puts(LCD_CAR_CAPACITY_OUTPUT);
    // lcd_puts(" * ");
    // lcd_puts(LCD_CALCULATED_PERIOD_OUTPUT);
}