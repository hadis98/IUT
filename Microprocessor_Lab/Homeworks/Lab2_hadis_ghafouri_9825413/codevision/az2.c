/*
 * az2.c  
 hadis ghafouri 9825413
 *
 * Created: 10/14/2022 7:47:28 AM
 * Author: Win 10
 */


#include <headers.h>

void main(void)
{
toggleAllLEDS(3,200);
while (1)
    {
     //showSwitchData();
     showSevenSegData(4256,portC,portD);
    }
}


