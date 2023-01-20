/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced

Project : LAB7- PROJECT1 - MICRO
Version :
Date    : 12/26/2022
Author  : HADIS GHAFOURI 9825413
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
#include "subTasks.h"

void main(void)
{
      init_configs();

      while (1)
      {
            subTask1_V1();
            //subTask1_V2();
      }
}
