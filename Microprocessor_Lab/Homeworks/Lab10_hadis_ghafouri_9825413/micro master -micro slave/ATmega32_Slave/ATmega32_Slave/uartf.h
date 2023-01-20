#ifndef _uartf_INCLUDED_
#define _uartf_INCLUDED_

void uart_init(void);

void putchar(char c);
char getchar(void);

interrupt [USART_TXC] void usart_tx_isr(void);
interrupt [USART_RXC] void usart_rx_isr(void);

#endif

