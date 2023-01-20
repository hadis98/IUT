#ifndef _SUBTASKS_INCLUDED_
#define _SUBTASKS_INCLUDED_
#include "general.h"

// general
void clear_column2_lcd();

// subTask1 functions
unsigned int read_adc(unsigned char adc_input);
void adc_without_interrupts_configs();
void subTask1();
float get_adc_voltage(int index);

// subTask2 functions
void adc_with_interrupts_configs();
void show_interrupt_adc_output(int adc_index, int value);
void update_adc(int adc_data, int adc_index);
bool is_5_percent_difference(long int adc, int adc_index);

// subTask3 functions
void subTask3();
void Q3_init_timer0();

#endif
