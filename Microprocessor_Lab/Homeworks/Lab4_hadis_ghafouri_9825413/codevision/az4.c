/*******************************************************
Date    : 11/3/2022
Author  : hadis ghafouri

Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/
#include "headers.h"

void main(void)
{
// Global enable interrupts
#asm("sei");
init_main_program();
while (1){}

}