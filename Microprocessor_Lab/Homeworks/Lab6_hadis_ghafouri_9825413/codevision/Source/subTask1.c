#include "general.h"

void clear_column2_lcd()
{
    lcd_gotoxy(0, 1);
    lcd_puts("               ");
}

void adc_without_interrupts_configs()
{
    // ADC initialization
    // ADC Clock frequency: 1000.000 kHz
    // ADC Voltage Reference: AVCC pin
    // ADC Auto Trigger Source: Free Running
    ADMUX = ADC_VREF_TYPE;
    ADCSRA = (1 << ADEN) | (0 << ADSC) | (1 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
    SFIOR = (0 << ADTS2) | (0 << ADTS1) | (0 << ADTS0);
}

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
    ADMUX = adc_input | ADC_VREF_TYPE;
    // Delay needed for the stabilization of the ADC input voltage
    delay_us(10);
    // Start the AD conversion
    ADCSRA |= (1 << ADSC);
    // Wait for the AD conversion to complete
    while ((ADCSRA & (1 << ADIF)) == 0)
        ;
    ADCSRA |= (1 << ADIF);
    return ADCW;
}

// return adc[i] voltage
float get_adc_voltage(int index)
{
    // Dout or adc = (Vi/Vref) *(2^n) =>
    // Vi = (Dout * Vref)/(2^n)
    // adc : (0 - 1023) , volt: (0 - 5)
    // volt = (adc * 5)/1023
    unsigned int adc_data;
    float calculated_voltage;
    adc_data = read_adc(index); // equals to Dout or adc

    calculated_voltage = ((5 * adc_data) / (float)1023) * 1000;
    return calculated_voltage;
}

void subTask1()
{
    char lcd_output_str[16];
    int i;
    float adc_mv;

    lcd_gotoxy(0, 0);
    lcd_puts("part1");

    for (i = 0; i <= 7; i++)
    {
        adc_mv = get_adc_voltage(i); // get mili volt (mv)
        sprintf(lcd_output_str, "adc[%d]=%u mv", i, adc_mv);

        lcd_gotoxy(0, 1);
        lcd_puts(lcd_output_str);

        delay_ms(1000);
        clear_column2_lcd();
        // lcd_clear();
    }

    delay_ms(1000);
    lcd_clear();
}
