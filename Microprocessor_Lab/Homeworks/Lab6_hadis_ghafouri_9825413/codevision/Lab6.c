/*******************************************************
Project : MICRO LAB6 AT IUT
Version :
Date    : 12/16/2022
Author  : HADIS GHAFOURI
Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/
#include "general.h"
#include "initial_configs.h"
#include "subTasks.h"

long int adc = 0;
int counter = 0;
float adc_difference = 0;
float myocr, duty_cycle = 0;
unsigned int adc_data[LAST_ADC_INPUT - FIRST_ADC_INPUT + 1];
unsigned int adc_data_copy[8] = {0};

void main(void)
{
      init_main_configs();

      adc_without_interrupts_configs();
      subTask1();

      delay_ms(1000);
      init_timers();
#asm("sei");
      adc_with_interrupts_configs();      
      Q3_init_timer0();
      subTask3();
}
