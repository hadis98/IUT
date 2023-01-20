#include "headers.h"

void subTask1_V1() // version1 of implementation
{
    char input_name_str[13];
    
    printf("\r\nenter your name:\r\n");    
    gets(input_name_str, 14);    
    printf("\r\nyour name is: <<%s>>\n", input_name_str);
}


void subTask1_V2() // version2 of implementation
{
    char input_name_str[20];
    char output_name_str[30];

    printf("\r\nenter your name:\r\n");
    scanf("%s", input_name_str);    
    sprintf(output_name_str, "<< %s >>", input_name_str);
    printf("\r\n%s\n", output_name_str);
}