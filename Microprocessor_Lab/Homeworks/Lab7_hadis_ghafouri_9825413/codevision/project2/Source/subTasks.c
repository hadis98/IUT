#include "subTasks.h"

char rx_buffer[RX_BUFFER_SIZE];
bit rx_buffer_overflow;
unsigned char rx_wr_index = 0, rx_rd_index = 0;
unsigned char rx_counter = 0;
char tx_buffer[TX_BUFFER_SIZE];
unsigned char tx_wr_index = 0, tx_rd_index = 0;
unsigned char tx_counter = 0;

// USART Receiver interrupt service routine
interrupt[USART_RXC] void usart_rx_isr(void)
{
    char status, data;
    status = UCSRA;
    data = UDR;
    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN)) == 0)
    {
        rx_buffer[rx_wr_index++] = data;
#if RX_BUFFER_SIZE == 256
        // special case for receiver buffer size=256
        if (++rx_counter == 0)
            rx_buffer_overflow = 1;
#else
        if (rx_wr_index == RX_BUFFER_SIZE)
            rx_wr_index = 0;
        if (++rx_counter == RX_BUFFER_SIZE)
        {
            rx_counter = 0;
            rx_buffer_overflow = 1;
        }
#endif
    }
}

// USART Transmitter interrupt service routine
interrupt[USART_TXC] void usart_tx_isr(void)
{
    if (tx_counter)
    {
        --tx_counter;
        UDR = tx_buffer[tx_rd_index++];
#if TX_BUFFER_SIZE != 256
        if (tx_rd_index == TX_BUFFER_SIZE)
            tx_rd_index = 0;
#endif
    }
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used +
char getchar(void)
{
    char data;
    while (rx_counter == 0)
        ;
    data = rx_buffer[rx_rd_index++];
#if RX_BUFFER_SIZE != 256
    if (rx_rd_index == RX_BUFFER_SIZE)
        rx_rd_index = 0;
#endif
#asm("cli")
    --rx_counter;
#asm("sei")
    return data;
}
#pragma used -
#endif

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used +
void putchar(char c)
{
    while (tx_counter == TX_BUFFER_SIZE)
        ;
#asm("cli")
    if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY) == 0))
    {
        tx_buffer[tx_wr_index++] = c;
#if TX_BUFFER_SIZE != 256
        if (tx_wr_index == TX_BUFFER_SIZE)
            tx_wr_index = 0;
#endif
        ++tx_counter;
    }
    else
        UDR = c;
#asm("sei")
}
#pragma used -
#endif

int subTask2(char entered_character)
{
    int integer_char;
    if (is_digit_valid(entered_character))
    {
        integer_char = (int)(entered_character)-48;
        printf("\r\nData is a integer and 10*%c = %d\r\n", entered_character, integer_char * 10);
    }
    else if (entered_character == 'D')
    {
        print_message_on_lcd("LCD Deleted!");
        print_on_terminal("LCD Deleted!");
    }
    else if (entered_character == 'H')
    {
        print_on_terminal("***********************Micro processor lab ***********************");
    }
    else if (entered_character == 'E')
    {
        print_on_terminal("Rx: END of the part");
        return -1; // end
    }
    else
    {
        printf("\r\nRx: input letter is %c\r\n", entered_character);
    }
    return 1;
}

bool is_digit_valid(char entered_char)
{
    int integer_char;
    integer_char = (int)(entered_char)-48;

    if (integer_char >= 0 && integer_char <= 9)
    {
        return true;
    }
    return false;
}

void subTask3(char *entered_frame)
{

    char number[10];
    int frame_length;
    int i = 0, j = 0;

    if (!is_parentheses_valid(entered_frame))
    {
        print_on_terminal("invalid input!");
        return;
    }

    frame_length = strlen(entered_frame);

    for (i = 1; i < frame_length - 1; i++, j++)
    {
        number[j] = entered_frame[i];
    }

    if (has_letter(number))
    {
        print_message_on_lcd("Rx:Frame must be 5 integer");
        print_on_terminal("Rx:Frame must be 5 integer");
    }
    else
    {
        if (strlen(number) != 5)
        {
            print_message_on_lcd("Rx: Incorrect frame size");
            print_on_terminal("Rx: Incorrect frame size");
        }
        else
        {
            print_message_on_lcd("Rx: The frame is correct");
            print_on_terminal("Rx: The frame is correct");
        }
    }
}

bool is_parentheses_valid(char *entered_frame)
{
    int last_index = strlen(entered_frame) - 1;
    return entered_frame[0] == '(' && entered_frame[last_index] == ')';
}

bool has_letter(char entered_number[])
{
    int i = 0;
    for (i = 0; i < strlen(entered_number); i++)
    {
        if (isalpha(entered_number[i]))
        {
            return true;
        }
    }

    return false;
}

void print_message_on_lcd(char *message)
{
    lcd_clear();
    lcd_gotoxy(0, 0);
    lcd_puts(message);
}

void print_on_terminal(char *message)
{
    printf("\r\n%s\r\n", message);
}