#ifndef _SOUBROUTINES_H_INCLUDED_
#define _SOUBROUTINES_H_INCLUDED_
#include <io.h>
#include <delay.h>

int readData(char selected_port);
void writeData(int data, char selected_port);
void toggleAllLEDS(int counter, int delay_interval);
void showSwitchData();
void showSevenSegData(int data, char data_port, int enable_data);
extern unsigned int sevenSeg[10];

#endif
