/*
 * I2C_Slave_C_File.c
 *
 */ 

#include "I2C_Slave_H_File.h"

void I2C_Slave_Init(int slave_address)
{
	TWAR = slave_address;						/* Assign address in TWI address register */
	TWCR = (1<<TWEN) | (1<<TWEA) | (1<<TWINT);	/* Enable TWI, Enable ack generation, clear TWI interrupt */
}
int I2C_Slave_Listen()
{
	while(1)
	{
		int status;							/* Declare variable */
		while (!(TWCR & (1<<TWINT)));			/* Wait to be addressed */
		status = TWSR & 0xF8;					/* Read TWI status register with masking lower three bits */
		if (status == 0x60 || status == 0x68)	/* Check weather own SLA+W received & ack returned (TWEA = 1) */
		return 0;								/* If yes then return 0 to indicate ack returned */
		if (status == 0xA8 || status == 0xB0)	/* Check weather own SLA+R received & ack returned (TWEA = 1) */
		return 1;								/* If yes then return 1 to indicate ack returned */
		if (status == 0x70 || status == 0x78)	/* Check weather general call received & ack returned (TWEA = 1) */
		return 2;								/* If yes then return 2 to indicate ack returned */
		else
		continue;								/* Else continue */
	}
}

int I2C_Slave_Transmit(char data)
{
	int status;
	TWDR = data;								/* Write data to TWDR to be transmitted */
	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWEA);		/* Enable TWI and clear interrupt flag */
	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (Write operation) */
	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -1 */
		return -1;
	}
	if (status == 0xB8)							/* Check weather data transmitted & ack received */
		return 0;									/* If yes then return 0 */
	if (status == 0xC0)							/* Check weather data transmitted & nack received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -2 */
		return -2;
	}
	if (status == 0xC8)							/* If last data byte transmitted with ack received TWEA = 0 */
	return -3;									/* If yes then return -3 */
	else										/* else return -4 */
	return -4;
}

char I2C_Slave_Receive()
{
	int status;								/* Declare variable */
	TWCR=(1<<TWEN)|(1<<TWEA)|(1<<TWINT);		/* Enable TWI, generation of ack and clear interrupt flag */
	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (read operation) */
	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	if (status == 0x80 || status == 0x90)		/* Check weather data received & ack returned (TWEA = 1) */
	return TWDR;								/* If yes then return received data */
	if (status == 0x88 || status == 0x98)		/* Check weather data received, nack returned and switched to not addressed slave mode */
	return TWDR;								/* If yes then return received data */
	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return 0 */
		return -1;
	}
	else
	return -2;									/* Else return 1 */
}
