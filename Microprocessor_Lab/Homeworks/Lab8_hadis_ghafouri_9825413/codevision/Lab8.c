/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator

Project : lAB8
Version :
Date    : 12/23/2022
Author  : HADIS GHAFOURI
Company :
Comments:


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include "headers.h"
#include "initial_configs.h"
#include "subRoutines.h"

void main(void)
{
      init_main();
      
      subRoutine2();
      delay_ms(3000);
      subRoutine3();
      
      while (1)
      {
            subRoutine1();
      }
}
