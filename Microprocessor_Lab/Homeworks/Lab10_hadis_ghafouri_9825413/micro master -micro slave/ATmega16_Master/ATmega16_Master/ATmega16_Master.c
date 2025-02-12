/*
 * ATmega16_Master.c
 * http://www.electronicwings.com
 *
 */ 

#define F_CPU 8000000UL						/* Define CPU clock Frequency e.g. here its 8MHz */
#include <mega16.h>							/* Include AVR std. library file */
#include <delay.h>						/* Include inbuilt defined Delay header file */
#include <stdio.h>							/* Include standard I/O header file */
#include <string.h>							/* Include string header file */
#include "I2C_Master_H_file.h"				/* Include I2C header file */
#include "uartf.h"				/* Include LCD header file */
typedef  char  uint8_t;
#define Slave_Write_Address		0x20
#define Slave_Read_Address		0x21
#define	count					10

void main(void)
{
	char buffer[10];
	uint8_t i;
    
	uart_init();								/* Initialize LCD */
	I2C_Init();								/* Initialize I2C */
	
	puts( "Master Device");
	
	while (1)
	{
		puts( "\n\r Sending :       ");
		I2C_Start_Wait(Slave_Write_Address);/* Start I2C communication with SLA+W */
		delay_ms(5);
		for ( i = 0; i < count ; i++)
		{
			sprintf(buffer, "%d    ",i);
			puts(buffer);
			I2C_Write(i);					/* Send Incrementing count */
			delay_ms(500);
		}
		puts( "\n\r Receiving :       ");
		I2C_Repeated_Start(Slave_Read_Address);	/* Repeated Start I2C communication with SLA+R */
		delay_ms(5);
		for ( i = 0; i < count; i++)
		{
			if(i < count - 1)
				sprintf(buffer, "%d    ", I2C_Read_Ack());/* Read and send Acknowledge of data */
			else
				sprintf(buffer, "%d    ", I2C_Read_Nack());/* Read and Not Acknowledge to data */
			puts(buffer);
			delay_ms(500);
		}
		I2C_Stop();							/* Stop I2C */
	}
}