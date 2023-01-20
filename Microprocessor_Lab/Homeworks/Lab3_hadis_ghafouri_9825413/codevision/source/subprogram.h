#ifndef _subprogram_INCLUDED_
#define _subprogram_INCLUDED_

#pragma used+
  
void init_configs();
void q1_show_name();
void q2_show_welcome_message();
char get_entered_key();
char get_entered_data(char entered_key);
void q3_polling();
//char keypad();
int part5_keyscan(int ch, int loc, int func);
void q5_display_info();
void speed();
void time();
void weight();
void temp();

#pragma used-

#endif
