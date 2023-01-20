#include <mega16.h>
#include <delay.h>
#include <i2c.h>

void main(void)
{
char i;
unsigned char tx_data[10]={0x00,0x10,0x11,0x22,0x33,0x44,0x55,0x66,0x70,0x80};  
unsigned char rx_data[10];   
unsigned char *txp=&tx_data[0]; 
unsigned char *rxp=&rx_data[0];   
#asm("sei")
// write a fram to eeprom via new code
{
    i2c_start();
    i2c_write(0xA0);
    i2c_write(0x00); // tx_data[0]
    i2c_write(0x30); // tx_data[1]
    for(i=0;i<10;i++)
    { 
        i2c_write(tx_data[i+2]);
    }
    i2c_stop();
    delay_ms(10);
}

// read a fram to eeprom via new code
{
    i2c_start();
    i2c_write(0xA0);
    i2c_write(0x00); // tx_data[0]
    i2c_write(0x20); // tx_data[1]

    i2c_start();
    i2c_write(0xA1);
    for(i=0;i<10;i++)
    {
    if(i==9)rx_data[i]=i2c_read(0); 
    else rx_data[i]=i2c_read(1);
    }
    i2c_stop();
}
while (1)
      {
      // Place your code here

      }
}
