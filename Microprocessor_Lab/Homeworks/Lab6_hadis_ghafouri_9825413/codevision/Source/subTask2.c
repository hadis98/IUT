#include "general.h"
#include "subTasks.h"

// int counter = 0;

void adc_with_interrupts_configs()
{
    // ADC initialization
    // ADC Clock frequency: 1000.000 kHz
    // ADC Voltage Reference: AVCC pin
    // ADC Auto Trigger Source: Free Running
    ADMUX = FIRST_ADC_INPUT | ADC_VREF_TYPE;
    ADCSRA = (1 << ADEN) | (1 << ADSC) | (1 << ADATE) | (0 << ADIF) | (1 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
    SFIOR = (0 << ADTS2) | (0 << ADTS1) | (0 << ADTS0);
}

void show_interrupt_adc_output(int adc_index, int value)
{
    char lcd_output_str[16];

    lcd_clear();

    lcd_gotoxy(0, 0);
    lcd_puts("part2");
    clear_column2_lcd();

    sprintf(lcd_output_str, "ADC[%d]=%d mv", adc_index, value);

    lcd_gotoxy(0, 1);
    lcd_puts(lcd_output_str);

    delay_ms(100);
}

bool is_5_percent_difference(long int adc, int adc_index)
{
    float increase, decrease = 0;

    adc_difference = ((adc * 5) / 100);
    increase = adc + adc_difference;
    decrease = adc - adc_difference;

    return (increase < adc_data_copy[adc_index]) || (decrease > adc_data_copy[adc_index]);
}

void update_adc(int adc_data, int adc_index)
{

    long int temp;
    int value;
    // adc = adc_data[adc_index];
    if (is_5_percent_difference(adc_data, adc_index))
    {
        adc_data_copy[adc_index] = adc_data;
        temp = (long)adc_data_copy[adc_index] * 5000;
        value = temp / 1023;
        show_interrupt_adc_output(adc_index, value);
    }
}

// ADC interrupt service routine
// with auto input scanning
interrupt[ADC_INT] void adc_isr(void)
{

    static unsigned char input_index = 0;
    lcd_clear();

    adc_data_copy[input_index] = adc_data[input_index];
    adc_data[input_index] = ADCW;
    // delay_us(10);
    //*UPDATE
    // update_adc(input_index);
    update_adc(ADCW, counter);
    counter++;
    //*UPDATE

    // Select next ADC input
    if (++input_index > (LAST_ADC_INPUT - FIRST_ADC_INPUT))
        input_index = 0;
    ADMUX = (FIRST_ADC_INPUT | ADC_VREF_TYPE) + input_index;
    // Delay needed for the stabilization of the ADC input voltage
    delay_us(10);

    if (counter > 7)
    {
        counter = 0;
    }
    // Start the AD conversion
    ADCSRA |= (1 << ADSC);
}
