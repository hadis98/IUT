#include <mega16.h>
#include <delay.h>
#include <twi.h>
void main(void)
{

unsigned char tx_data[10]={0x00,0x80,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80}; 
unsigned char rx_data[10];   
unsigned char *txp=&tx_data[0]; 
unsigned char *rxp=&rx_data[0]; 
 
twi_master_init(100);

#asm("sei")

 twi_master_trans(0x50, txp ,10,rxp,0);   //  write to eeprom  
 delay_ms(5);
 tx_data[0]=0x00;
 tx_data[1]=0x40;
 twi_master_trans(0x50, txp ,2,rxp,10);   // read from eeprom 
 delay_ms(5);  
 twi_master_trans(0x60, txp ,2,rxp,10); 
 
while (1);
}
