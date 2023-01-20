#ifndef _GENERAL_INCLUDED_
#define _GENERAL_INCLUDED_

#include <mega16.h>
#include <delay.h>
#include <alcd.h>
#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include <stdint.h> // uint16/8_t

// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0 << REFS1) | (1 << REFS0) | (0 << ADLAR))
#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 7

extern unsigned int adc_data[LAST_ADC_INPUT - FIRST_ADC_INPUT + 1];
extern unsigned int adc_data_copy[LAST_ADC_INPUT - FIRST_ADC_INPUT + 1];
extern long int adc;
extern float adc_difference;
extern float myocr, duty_cycle;
extern int counter;

#endif
