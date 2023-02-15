#include "general.h"
/*
//*The different color codes are

//*0   BLACK
//*1   BLUE
//*2   GREEN
//*3   CYAN
//*4   RED
//*5   MAGENTA
//*6   BROWN
//*7   LIGHTGRAY
//*8   DARKGRAY
//*9   LIGHTBLUE
//*10  LIGHTGREEN
//*11  LIGHTCYAN
//*12  LIGHTRED
//*13  LIGHTMAGENTA
//*14  YELLOW
//*15  WHITE
*/

void setcolor(int colorcode)
{
    HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(console, colorcode % 255);
}

void Cyan()
{
    printf("\033[0;36m");
}

void Boldcyan()
{
    printf("\033[1;36m");
}

void boldred()
{
    printf("\033[1;31m");
}

bool is_strings_equal(char str1[], const char str2[])
{
    return strcmp(str1, str2) == 0;
}

bool is_session_timeout(char user_time[])
{
    char formated_current_time[100];
    time_t current_time;
    struct tm *ts;

    current_time = time(NULL);
    ts = localtime(&current_time);
    struct user temp_user;
    setcolor(10);
    strftime(formated_current_time, sizeof(formated_current_time), "%Y/%m/%d %H:%M:%S", ts); // time now

    if (strcmp(user_time, formated_current_time) <= 0)
    {
        return true;
    }
    return false;
}