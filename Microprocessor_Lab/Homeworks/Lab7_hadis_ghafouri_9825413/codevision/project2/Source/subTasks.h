#ifndef _SUBTASKS_INCLUDED_
#define _SUBTASKS_INCLUDED_

#include "headers.h"

#define DATA_REGISTER_EMPTY (1 << UDRE)
#define RX_COMPLETE (1 << RXC)
#define FRAMING_ERROR (1 << FE)
#define PARITY_ERROR (1 << UPE)
#define DATA_OVERRUN (1 << DOR)

//* USART Receiver buffer
#define RX_BUFFER_SIZE 8

extern char rx_buffer[RX_BUFFER_SIZE];
// This flag is set on USART Receiver buffer overflow
extern bit rx_buffer_overflow;

#if RX_BUFFER_SIZE <= 256
extern unsigned char rx_wr_index, rx_rd_index;
#else
extern unsigned int rx_wr_index, rx_rd_index;
#endif

#if RX_BUFFER_SIZE < 256
extern unsigned char rx_counter;
#else
extern unsigned int rx_counter;
#endif

//* USART Transmitter buffer
#define TX_BUFFER_SIZE 8
extern char tx_buffer[TX_BUFFER_SIZE];

#if TX_BUFFER_SIZE <= 256
extern unsigned char tx_wr_index, tx_rd_index;
#else
extern unsigned int tx_wr_index, tx_rd_index;
#endif

#if TX_BUFFER_SIZE < 256
extern unsigned char tx_counter;
#else
extern unsigned int tx_counter;
#endif

char getchar(void);
void putchar(char c);
int subTask2(char entered_character);
bool is_digit_valid(char entered_char);
void print_message_on_lcd(char *message);
bool is_parentheses_valid(char *entered_frame);
bool has_letter(char entered_number[]);
void print_on_terminal(char *message);
void subTask3(char *entered_frame);

#endif
