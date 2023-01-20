/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Project : LAB7-PROJECT2-MICRO_LAB
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
   char entered_char;
   char subTask3_entered_str[10];

#asm("sei")

   init_configs();

   print_message_on_lcd("part2 is running!");
   print_on_terminal("part2 is running!\r\nEnter a character:");

   while (1)
   {

      entered_char = getchar();

      if (subTask2(entered_char) == -1)
      {
         print_message_on_lcd("Part2 is ending!");
         print_on_terminal("Part2 is ending!");
         delay_ms(2000);
         break;
      }
   }

   print_message_on_lcd("part3 is running!");
   print_on_terminal("Part3 is running!");

   while (1)
   {
      print_on_terminal("Enter a 5 digits number with this format: (number)");
      scanf("%s", subTask3_entered_str);
      subTask3(subTask3_entered_str);
   }
}
