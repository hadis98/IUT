#ifndef _HEADERS_INCLUDED_
#define _HEADERS_INCLUDED_

#include <mega16.h>
// Alphanumeric LCD functions
#include <alcd.h>
#include <stdio.h>
#include "program_init_configs.h"
#include "subtasks.h"

// values of subTask1
#define max_hundredth_of_seconds 99
#define max_second 59
#define max_minute 59
#define max_hour 99
#define start_timer_button_port PINB.4
#define stop_timer_button_port PINB.5
// since clicking on buttons is captured by falling edge of interrupt pulse => we use 0 as a signe that button was clicked.
#define is_button_clicked 0
#define start_button 1
#define stop_button 0

// values of subTask2
#define reset 0
#define car_in_button_port PINB.7
#define car_out_button_port PINB.3
#define is_capacity_full 0
#define max_parking_capacity 1000

// values of subTask3
#define input_frequency_port PINA

// GLOBAL VARIABLES
extern char *LCD_TIMER_OUTPUT;
extern char *LCD_CAR_CAPACITY_OUTPUT;
extern char *LCD_CALCULATED_PERIOD_OUTPUT;

#endif