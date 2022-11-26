// write on the lcd using 8 bit data

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

#define LCD_DPRT PORTA // LCD DATA PORT
#define LCD_DDDR DDRA  // LCD DATA DDR
#define LCD_DPIN PINA  // LCD DATA PIN
#define LCD_CPRT PORTB // LCD COMMANDS PORT
#define LCD_CDDR DDRB  // LCD COMMANDS DDR
#define LCD_CPIN PINB  // LCD COMMANDS PIN
#define LCD_RS 0       // LCD RS
#define LCD_RW 1       // LCD RW
#define LCD_EN 2       // LCD EN

int INTERRUPT_CNT = 3;
void delay_ms(unsigned int);
void lcdCommand(unsigned char);
void lcdData(unsigned char);
void lcd_init();
void lcd_print(char *);
void lcd_gotoxy(unsigned char, unsigned char);

int main()
{
	lcd_init();
	lcd_gotoxy(1, 1);
	lcd_print("init programm");
	lcd_gotoxy(1, 2);
	lcd_print("main part");

	DDRA |= 0x82; // make DDRA.1 and  DDRA.7= output     (10000010)
	TCNT0 = -160;
	TCCR0 = 0x01; // normal mode,int clk,no prescaler

	TCNT1H = (-640) >> 8; // the high byte
	TCNT1L = (-640);      // the low byte
	TCCR1A = 0x00;
	TCCR1B = 0x01;
	TIMSK = (1 << TOIE0) | (1 << TOIE1); // enable timer0 and timer1 overflow interrupt
	sei();
	while (1)
	;
	return 0;
}

ISR(TIMER0_OVF_vect) // ISR for timer0 overflow
{
	char buffer[10];
	INTERRUPT_CNT--;
	sprintf(buffer, "interrup %d", INTERRUPT_CNT);
	lcd_init();
	lcd_gotoxy(1, 1);
	lcd_print("TIMER0_OVF_vect");
	lcd_gotoxy(1, 2);
	lcd_print(buffer);
	 delay_ms(10);
	if (INTERRUPT_CNT != 0)
	{
		sei();
	}

	TCNT0 = -160;  // TCNT0 = -160(reload for next round)
	PORTA ^= 0x02; // toggle porta.1
	INTERRUPT_CNT++;
}

ISR(TIMER1_OVF_vect) // ISR for timer0 overflow
{
	char buffer[10];
	INTERRUPT_CNT--;	
	sprintf(buffer, "interrup %d", INTERRUPT_CNT);
	lcd_init();
	lcd_gotoxy(1, 1);
	lcd_print("TIMER1_OVF_vect");
	lcd_gotoxy(1, 2);
	lcd_print(buffer);
	delay_ms(10);	
	if (INTERRUPT_CNT != 0)
	{
		sei();
	}

	TCNT1H = (-640) >> 8;
	TCNT1L = (-640); // TCNT1 = -640 (reload for next round)

	PORTA ^= 0x80; // toggle porta.7
	INTERRUPT_CNT++;	
	
}

void delay_ms(unsigned int d)
{
	int i;
	for (i = 0; i < d; i++) {
		_delay_ms(1);
	}
}

void lcdCommand(unsigned char cmnd)
{
	LCD_DPRT = cmnd;            // SEND CMND TO DATA PORT
	LCD_CPRT &= ~(1 << LCD_RS); // RS =0 for command
	LCD_CPRT &= ~(1 << LCD_RW); // RW=0 for write
	LCD_CPRT |= (1 << LCD_EN);  // EN =1 FOR H-TO-L pulse
	delay_ms(1);                // wait to make enable wide
	LCD_CPRT &= ~(1 << LCD_EN); // EN =0 FOR H-TO-L pulse
	delay_ms(100);              // wait to make enable wide
}

void lcdData(unsigned char data)
{
	LCD_DPRT = data;            // send data to port
	LCD_CPRT |= (1 << LCD_RS);  // RS=1 for data
	LCD_CPRT &= ~(1 << LCD_RW); // RW=0 for write
	LCD_CPRT |= (1 << LCD_EN);  // EN=1  FOR H-TO-L pulse
	delay_ms(1);                // wait to make enable wide
	LCD_CPRT &= ~(1 << LCD_EN); // EN =1 FOR H-TO-L pulse
	delay_ms(100);              // wait to make enable wide
}

void lcd_init()
{
	LCD_DDDR = 0xFF;
	LCD_CDDR = 0XFF;

	LCD_CPRT &= ~(1 << LCD_EN); // LCD_EN =0
	delay_ms(200);             // wait for init
	lcdCommand(0x38);           // init. lcd 2 line , 5*7 matrix
	lcdCommand(0x0E);           // desplay on,cursor on
	lcdCommand(0x01);           // clear lcd
	delay_ms(200);
	lcdCommand(0x06); // shift cursor right
}

void lcd_gotoxy(unsigned char x, unsigned char y)
{
	unsigned char firstCharAdr[] = {0x80, 0xC0, 0x94, 0xD4};
	lcdCommand(firstCharAdr[y - 1] + x - 1);
	delay_ms(100);
}

void lcd_print(char *str)
{
	unsigned char i = 0;
	while (str[i] != 0)
	{
		lcdData(str[i]);
		i++;
	}
}