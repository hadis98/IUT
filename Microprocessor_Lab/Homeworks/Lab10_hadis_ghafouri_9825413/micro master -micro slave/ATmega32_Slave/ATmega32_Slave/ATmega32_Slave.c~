/*
 * ATmega32_Slave.c
 * http://www.electronicwings.com
 *
 */ 


#define F_CPU 8000000UL							/* Define CPU clock Frequency e.g. here its 8MHz */
#include <mega16.h>								/* Include AVR std. library file */
#include <delay.h>							/* Include inbuilt defined Delay header file */
#include <stdio.h>								/* Include standard I/O header file */
#include <string.h>								/* Include string header file */
//#include "LCD_16x2_H_file.h"					/* Include LCD header file */
#include "I2C_Slave_H_File.h"					/* Include I2C slave header file */
//#include <cstdint.h>
#include "uartf.h"
#define Slave_Address			0x20

void main(void)
{
	char buffer[10];
	char count = 0,count3;
	char Ack_status;
    
	uart_init();
	I2C_Slave_Init(Slave_Address);
	
	puts("\r\n Slave Device");
	
	while (1)
	{
		switch(I2C_Slave_Listen())				/* Check for any SLA+W or SLA+R */
		{
			case 0:
			{
				puts("\r\n Receiving :       ");
				do
				{
					count = I2C_Slave_Receive();
                    sprintf(buffer, "%d    ", count);
					puts(buffer);
					/* Receive data byte*/
				} while (count != 255);			/* Receive until STOP/REPEATED START received */
				count = 0;
				break;
			}
			case 1:
			{
				//count3=10;
                count = 20;
				puts("\r\n Sending :       ");
				do
				{
					//Ack_status = I2C_Slave_Transmit(count3);	/* Send data byte */
                    Ack_status = I2C_Slave_Transmit(count);	/* Send data byte */
					//sprintf(buffer, "%d    ",count3);
                    sprintf(buffer, "%d    ",count);
					puts(buffer);
					//count3++;
                    count++;
				} while (Ack_status == 0);		/* Send until Acknowledgment is received */
				break;
			}
			default:
				break;
		}
	}
}

