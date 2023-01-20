#include <headers.h>
extern unsigned int sevenSeg[10] = {
    0b00111111, // number 0 on 7_seg
    0b00000110, // number 1 on 7_seg
    0b01011011, // number 2 on 7_seg
    0b01001111, // number 3 on 7_seg
    0b01100110, // number 4 on 7_seg
    0b01101101, // number 5 on 7_seg
    0b01111101, // number 6 on 7_seg
    0b00000111, // number 7 on 7_seg
    0b01111111, // number 8 on 7_seg
    0b01101111, // number 9 on 7_seg
};

int readData(char selected_port){
int data = 0;

  switch(selected_port){
    case portA:
    DDRA=0x00;
    data =PINA;
    break;      
    
    case portB:
    DDRB=0x00;
    data =PINB;
    break;
    
    case portC:
    DDRC=0x00;
    data =PINC;
    break;
    
    case portD:
    DDRD=0x00;
    data =PIND;
    break;
  }    
  
  return data;
}


void writeData(int data, char selected_port){

  switch(selected_port){
    case portA:
    DDRA=0xFF;
    PORTA =data;
    break;      
    
    case portB:
    DDRB=0xFF;
     PORTB =data;
    break;
    
    case portC:
    DDRC=0xFF;
     PORTC =data;
    break;
    
    case portD:
    DDRD=0xFF;
     PORTD =data;
    break;
  }    
  

}

void toggleAllLEDS(int counter,int delay_interval){
int i;

    for(i=0;i<counter;i++){
        writeData(0b00000000,portB);
        delay_ms(delay_interval);
        writeData(0b11111111,portB);
        delay_ms(delay_interval);
    }    
}

void showSwitchData(){
int data;
        data = readData(portA);
        delay_ms(20);
        writeData(data,portB);
        delay_ms(20);
}

void showSevenSegData(int data,char data_port,int enable_data){
int h,s,d,y,i;

        h = data / 1000;
        s = (data % 1000) / 100;
        d = (data % 100) / 10;
        y = data % 10;
  for(i=0;i<20;i++){  
    writeData(0b1000,enable_data);
    writeData(sevenSeg[y],data_port);  
    delay_ms(5);
    writeData(0b0000,enable_data);
    
    writeData(0b0100,enable_data);
    writeData(sevenSeg[d],data_port);  
    delay_ms(5);
    writeData(0b0000,enable_data);
    
    writeData(0b0010,enable_data);
    writeData(sevenSeg[s],data_port);  
    delay_ms(5);
    writeData(0b0000,enable_data);
    
    writeData(0b0001,enable_data);
    writeData(sevenSeg[h],data_port);  
    delay_ms(5);
    writeData(0b0000,enable_data);
    //delay_ms(5);  
 }
}