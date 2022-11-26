%{
    #include <iostream>
	#include <string.h>
	using namespace std;
    #include "parser.tab.h"

	extern FILE *yyin;
	extern FILE *yyout;
    int numLines = 1;
    long int  intnum;
    long int myAtoi(char* str)
    {    
        long int res = 0;
        int sign = 1;
        int i = 0;
        if (str[0] == '-') {
            sign = -1;
            i++;
        }else if(str[0] =='+'){
            sign =1;
            i++;
        }
    
        for (; str[i] != '\0'; i++)
            res = res * 10 + str[i] - '0';  
        return sign * res;
    }
 
%}

digit			                [0-9]
decimal	                        [+-]?{digit}+
hex                             [0-9a-fA-F]                          
identifier                      [_a-zA-Z][_a-zA-Z0-9]*
wrong_identifier                [0-9]+[_a-zA-Z0-9]+

%option noyywrap

%%
"//".*                                  {}   
"boolean"                               {return TOKEN_BOOLEANTYPE;}   
"break"                                 {return TOKEN_BREAKSTMT;}   
"callout"                               {return TOKEN_CALLOUT;}   
"class"                                 {return TOKEN_CLASS;}   
"continue"                              {return TOKEN_CONTINUESTMT;}   
"if"                                    {return TOKEN_IFCONDITION;}   
"else"                                  {return TOKEN_ELSECONDITION;}   
"for"                                   {return TOKEN_LOOP;}   
"int"                                   {return TOKEN_INTTYPE;}   
"return"                                {return TOKEN_RETURN;}   
"void"                                  {return TOKEN_VOIDTYPE;}   
"Program"                               {return TOKEN_PROGRAMCLASS;}   
"main"                                  {return TOKEN_MAINFUNC;}   
"false"|"true"                          {yylval.bool_val = strdup(yytext) =="true"?true:false;return TOKEN_BOOLEANCONST;}
\"([^"\n]*)\"                           {yylval.str_val = strdup(yytext);return TOKEN_STRINGCONST;}                                
\"([^"\n]*)\\\"([^"\n]*)\"              {yylval.str_val = strdup(yytext);return TOKEN_STRINGCONST;}
\"                                      {cout<<"Error in line "<<numLines<<" unterminated literal"<<yytext; return 0;}
{identifier}                            {yylval.str_val= strdup(yytext);return TOKEN_ID;}    
{decimal}                               {           
                                        if(strlen(yytext) > 11){
                                            cout<<"Error in line "<<numLines<<" number "<<yytext<<"is out of range\n";return 0; 
                                        }else{
                                            intnum=myAtoi(yytext);
                                            if(intnum > 2147483647 || intnum < -2147483648){
                                               cout<<"Error in line "<<numLines<<" number "<<yytext<<"is out of range\n";return 0; 
                                            }
                                            else{
                                                yylval.int_val= intnum;return TOKEN_DECIMALCONST;  
                                            }
                                        } 
                                        }
[0][x|X]{hex}+                          {yylval.int_val= atoi(yytext);return TOKEN_HEXADECIMALCONST;}
{wrong_identifier}                      {cout<<"Error in line "<<numLines<<" invalid identifier"<<yytext;return 0;}    
"\'\'\'"|"\'\"\'"|"\'\\\'"              {cout<<"Error in line "<<numLines<<" character is invalid (single quote,backslash,double quote)"<<yytext;return 0;}
\'[\x20-\x21\x23-\x26\x28-\x5B\x5D-\x7e]\'              {return TOKEN_CHARCONST;}
"\'\\\'\'"|"\'\\\\\'"|"\'\\\"\'"|"\'\\n\'"|"\'\\t\'"    {return TOKEN_CHARCONST;}
\'[\x20-\x26\x28-\x7e][\x20-\x26\x28-\x7e]+\'           {return 0;}          
\'                                      {return 0;}          
[(]                                     {return TOKEN_LP;}
[)]                                     {return TOKEN_RP;}
[{]                                     {return TOKEN_LCB;}
[}]                                     {return TOKEN_RCB;}
\[                                      {return TOKEN_LB;}
\]                                      {return TOKEN_RB;}
[;]                                     {return TOKEN_SEMICOLON;}
[,]                                     {return TOKEN_COMMA;}
[!]                                     {return TOKEN_LOGICOP;}
[!][=]                                  {return TOKEN_NOTEQUAL;}
[=][=]                                  {return TOKEN_EQUAL;}
[&][&]                                  {return TOKEN_AND;}
[|][|]                                  {return TOKEN_OR;}
[=]                                     {return TOKEN_ASSIGNOP;}
[-][=]                                  {return TOKEN_MINUS_EQUAL;}
[+][=]                                  {return TOKEN_PLUS_EQUAL;}
[+]                                     {return TOKEN_PLUS;}
[-]                                     {return TOKEN_MINUS;}
[*]                                     {return TOKEN_MULTIPLICATION;} 
[%]                                     {return TOKEN_MODULO;}
[/]                                     {return TOKEN_DIVISION;}
[>][=]                                  {return TOKEN_GREATER_EQUAL;}
[<][=]                                  {return TOKEN_LESS_EQUAL;}
[>]                                     {return TOKEN_GREATER;}
[<]                                     {return TOKEN_LESS;}
[\t]                                    {}    
[ ]                                     {}    
.                                       {cout<<"Error in line "<< numLines <<"invalid token " << yytext << endl;return 0;}
\n                                      {numLines++;}
%%


// int yywrap(){};
// int main(int argc,char *argv[]){
//     if(argc !=2){
//       cout<<"enter input file name\n[please note program needs only one argument in command line]\n"; 
//         return 0;
//     }
//     yyin=fopen(argv[1],"r");
//     yyout = fopen("Output.txt", "w");   
//     yylex();         
//     fclose(yyin);
//     fclose(yyout);
//     return 0;
// }



