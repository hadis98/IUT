#include <headers.h>
char data_key[]={
'0','1','2','3',
'4','5','6','7',
'8','9','A','B',
'C','D','E','F'};

char row[] = { 0x10,0x20,0x40,0x80 };

interrupt [EXT_INT1] void ext_int1_isr(void)
{
   char key;
   PORTC=~PORTC;
   key = get_entered_key();
   lcd_gotoxy(0,0);
   lcd_putchar(get_entered_data(key));   
   lcd_gotoxy(0,1);
   lcd_puts("interrupt");  
}

void init_configs(){
DDRA=0xff;
DDRB=0xf0;
DDRC=0xff;
DDRD=0x00;
PORTA=0x00;
PORTB=0xf0;
PORTC=0x00;
PORTC=0x00;

GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
lcd_init(16);
}

void q1_show_name(){
    lcd_puts("ghafouri\n9825413");    
    delay_ms(2000);
    lcd_clear();   
}

void q2_show_welcome_message(){
    char i =0;
    char welcome_message[]="Welcome to the Microprocessor lab classes in Isfahan University of Thecnology. ";
    char display_message[16]="";
    lcd_clear();
    
    for(i=0;i<strlen(welcome_message);i++){
        strncpy(display_message,welcome_message+i,15);
        lcd_gotoxy(0,1);
        lcd_puts(display_message);
        delay_ms(200);
    }
}

char get_entered_key(){
char key =100;
char c,r;
for(r=0;r<4;r++){
PORTB = row[r];
c=20;
delay_ms(10);
if (PINB.0==1) c=0; 
if (PINB.1==1) c=1;
if (PINB.2==1) c=2;     
if (PINB.3==1) c=3; 
 
 if (c!=20){             
 key=(r*4)+c; 
   PORTB=0xf0;                     
  while (PINB.0==1) {}              
  while (PINB.1==1) {}              
  while (PINB.2==1) {}             
  while (PINB.3==1) {}
  return key;
  }      
  }
  PORTB = 0xf0;
  return key;    
}

char get_entered_data(char entered_key){
    return data_key[entered_key];
}

void q3_polling(){  

    char i,key;
   #asm("cli");
    for(i=0;i<100;i++){
     if(PINB !=0XF0){
        lcd_gotoxy(0,0);
        key = get_entered_key();
        lcd_putchar(get_entered_data(key)); 
        lcd_gotoxy(0,1);
        lcd_puts("polling");
             
     }
      delay_ms(100);   
    } 
     delay_ms(2000);
    
}


int part5_keyscan(int ch, int loc, int func)
{
    char str[40], num, str_func[20], str_func1[20],r,c,key;
    if(ch == -1)
        num = '?';
    else
        num = data_key[ch];
        

         
    DDRB = 0xF0;
    while(1){
    r=0;
    for (r=0;r<4;r++)
    {
        PORTB=row[r];
        c=20;
        delay_ms(10);
        if (PINB.0==1) c=0;
        if (PINB.1==1) c=1;
        if (PINB.2==1) c=2;
        if (PINB.3==1) c=3;
        
        if (!(c==20)){
            lcd_clear();
            key=(r*4)+c;
            PORTB=0xf0;
            while (PINB.0==1) {}
            while (PINB.1==1) {}
            while (PINB.2==1) {}
            while (PINB.3==1) {}
            if(loc == 0)
            {
                lcd_clear();
                sprintf(str, "System Init\n %s:%c%c%s", str_func1, data_key[key], num, str_func);
                lcd_puts(str);
                //delay_ms(1000);
            }
            if(loc == 1)
            {
                lcd_clear();
                sprintf(str, "System Init\n %s:%c%c%s", str_func1, num, data_key[key], str_func);
                lcd_puts(str);   
                //delay_ms(1000);
            }
            return key;
        }
        PORTB=0xf0;
    }
    }
}

void print_func_details(char function_type, char first_digit,char second_digit)
{
    char display_message[40], func_valid_range[20], func_type[20];
    switch (function_type)
    {
    case 0:
        strcpy(func_valid_range, "(0-50r)");
        strcpy(func_type, "Speed");
        break;
    case 1:
        strcpy(func_valid_range, "(0-99s)");
        strcpy(func_type, "Time");
        break;
    case 2:
        strcpy(func_valid_range, "(0-99Kg)");
        strcpy(func_type, "W");
        break;

    case 3:
        strcpy(func_valid_range, "(20-80C)");
        strcpy(func_type, "Temp");
        break;
    }

    lcd_clear();
    sprintf(display_message, "System Init\n %s:%c%c%s", func_valid_range, first_digit, second_digit, func_type);
    lcd_puts(display_message);
}

void q5_display_info()
{
    speed();    
    //time();
    // weight();
    // temp();
    // lcd_clear();
    // lcd_puts("System Init Done\n\tThanks"); 
    // delay_ms(300);
    // lcd_clear();
}


void speed()
{
    char speed_first_digit, speed_second_digit, speed_total_num;
    char unrecognized_num;
    unrecognized_num = '?';
    lcd_clear();
    lcd_puts("System Init\n Speed:??(0-50r)");
    //speed1 = part5_keyscan(-1, 0, 0);
    if (PORTB != 0XF0)
    {
        lcd_clear();
        lcd_puts("WHY?");
        speed_first_digit = get_entered_key();
        lcd_gotoxy(0, 0);
        lcd_putchar(speed_first_digit);
    }

    // print_func_details(0, speed_first_digit, unrecognized_num);    
    //speed_second_digit = get_entered_key();
    //print_func_details(0, speed_first_digit, speed_second_digit);
    // speed_total_num = speed_first_digit*10 + speed_second_digit;
    // lcd_puts(speed_total_num);
    // while (speed_total_num > 50)
    // { 
    //     lcd_clear();
    //     lcd_puts("System Init\n Speed:EE(0-50r)");
    //     speed_first_digit = get_entered_key();
    //     print_func_details(0, speed_first_digit, unrecognized_num);
    //     speed_second_digit = get_entered_key();
    //     print_func_details(0, speed_first_digit, speed_second_digit);
    //     speed_total_num = speed_first_digit * 10 + speed_second_digit;
    // }
    // delay_ms(100);
}


void time()
{
    int time, time1;
    lcd_clear();
    lcd_puts("System Init\n Time:??(0-99s)");
    time1 = part5_keyscan(-1, 0, 1);
    time = time1 * 10;
    time += part5_keyscan(time1, 1, 1);
    while(time > 99)
    { 
        lcd_clear();
        lcd_puts("System Init\n Time:EE(0-99s)");
        time1 = part5_keyscan(-1, 0, 1);
        time = time1 * 10;
        time += part5_keyscan(time1, 1, 1);
    }
    delay_ms(100);
}



void weight()
{
    int w, w1;
    lcd_clear();
    lcd_puts("System Init\n W:??(0-99Kg)");
    w1 = part5_keyscan(-1, 0, 2);
    w = w1 * 10;
    w += part5_keyscan(w1, 1, 2);
    while(w > 99)
    { 
        lcd_clear();
        lcd_puts("System Init\n W:EE(0-99Kg)");
        w1 = part5_keyscan(-1, 0, 2);
        w = w1 * 10;
        w += part5_keyscan(w1, 1, 2);
    }
    delay_ms(100);
}


void temp()
{
    int temp, temp1;
    lcd_clear();
    lcd_puts("System Init\n Temp:??(20-80C)");
    temp1 = part5_keyscan(-1, 0, 3);
    temp = temp1 * 10;
    temp += part5_keyscan(temp1, 1, 3);
    while(temp > 80 || temp < 20)
    { 
        lcd_clear();
        lcd_puts("System Init\n Temp:EE(20-80C)");
        temp1 = part5_keyscan(-1, 0, 3);
        temp = temp1 * 10;
        temp += part5_keyscan(temp1, 1, 3);
    }
    delay_ms(100);
}


