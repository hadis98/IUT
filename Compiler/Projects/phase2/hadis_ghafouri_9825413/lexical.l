%{
    #include <iostream>
	#include <string.h>
	using namespace std;
    #include "parser.tab.h"
	extern FILE *yyin;
	extern FILE *yyout;

    /**********global variables & functions *************/
    int numLines = 1;
    long int  intnum;
    long int myAtoi(char*);
%}


digit			                [0-9]
decimal	                        [+-]?{digit}+
hex                             [0-9a-fA-F]                          
identifier                      [_a-zA-Z][_a-zA-Z0-9]*
wrong_identifier                [0-9]+[_a-zA-Z0-9]+

%option noyywrap

%%
"//".*                               {}   
"boolean"                            {yylval.string=strdup(yytext);return TOKEN_BOOLEANTYPE;}   
"break"                              {yylval.string=strdup(yytext);return TOKEN_BREAKSTMT;}   
"callout"                            {yylval.string=strdup(yytext);return TOKEN_CALLOUT;}   
"class"                              {yylval.string=strdup(yytext);return TOKEN_CLASS;}   
"continue"                           {yylval.string=strdup(yytext);return TOKEN_CONTINUESTMT;}   
"if"                                 {yylval.string=strdup(yytext);return TOKEN_IFCONDITION;}   
"else"                               {yylval.string=strdup(yytext);return TOKEN_ELSECONDITION;}   
"for"                                {yylval.string=strdup(yytext);return TOKEN_LOOP;}   
"int"                                {yylval.string=strdup(yytext);return TOKEN_INTTYPE;}   
"return"                             {yylval.string=strdup(yytext);return TOKEN_RETURN;}   
"void"                               {yylval.string=strdup(yytext);return TOKEN_VOIDTYPE;}   
"Program"                            {yylval.string=strdup(yytext);return TOKEN_PROGRAMCLASS;}   
"main"                               {yylval.string=strdup(yytext);return TOKEN_MAINFUNC;}   
"false"|"true"                       {yylval.string=strdup(yytext);return TOKEN_BOOLEANCONST;}
\"([^"\n]*)\"                        {yylval.string=strdup(yytext);return TOKEN_STRINGCONST;}                                
\"([^"\n]*)\\\"([^"\n]*)\"           {yylval.string=strdup(yytext);return TOKEN_STRINGCONST;}
\"                                   {yylval.string=strdup(yytext);cout<<"\nError in line "<<numLines<<" unterminated literal"<<yytext; return 0;}
{identifier}                         {yylval.string=strdup(yytext);return TOKEN_ID;}    
{decimal}                            {           
                                    if(strlen(yytext) > 11){
                                        cout<<"\nError in line "<<numLines<<" number "<<yytext<<" is out of range\n";return 0; 
                                    }else{
                                        intnum=myAtoi(yytext);
                                        if(intnum > 2147483647 || intnum < -2147483648){
                                           cout<<"\nError in line "<<numLines<<" number "<<yytext<<" is out of range\n";return 0; 
                                        }
                                        else{
                                    yylval.string=strdup(yytext);
                                    return TOKEN_DECIMALCONST;  
                                        }
                                    } 
                                    }
[0][x|X]{hex}+                    {yylval.string=strdup(yytext);return TOKEN_HEXADECIMALCONST;}
{wrong_identifier}                {cout<<"\nError in line "<<numLines<<" invalid identifier"<<yytext;return 0;}    
"\'\'\'"|"\'\"\'"|"\'\\\'"        {cout<<"\nError in line "<<numLines<<" character is invalid (single quote,backslash,double quote)"<<yytext;return 0;}
\'[\x20-\x21\x23-\x26\x28-\x5B\x5D-\x7e]\'  {yylval.string=strdup(yytext);return TOKEN_CHARCONST;}
"\'\\\'\'"|"\'\\\\\'"|"\'\\\"\'"|"\'\\n\'"|"\'\\t\'" {yylval.string=strdup(yytext);return TOKEN_CHARCONST;}
\'[\x20-\x26\x28-\x7e][\x20-\x26\x28-\x7e]+\'           {return 0;}          
\'                                {return 0;}          
[(]                               {yylval.string=strdup(yytext);return TOKEN_LP;}
[)]                               {yylval.string=strdup(yytext);return TOKEN_RP;}
[{]                               {yylval.string=strdup(yytext);return TOKEN_LCB;}
[}]                               {yylval.string=strdup(yytext);return TOKEN_RCB;}
\[                                {yylval.string=strdup(yytext);return TOKEN_LB;}
\]                                {yylval.string=strdup(yytext);return TOKEN_RB;}
[;]                               {yylval.string=strdup(yytext);return TOKEN_SEMICOLON;}
[,]                               {yylval.string=strdup(yytext);return TOKEN_COMMA;}
[!]                               {yylval.string=strdup(yytext);return TOKEN_LOGICOP;}
[!][=]|[=][=]                     {yylval.string=strdup(yytext);return TOKEN_EQUALITYOP;}
[&][&]                            {yylval.string=strdup(yytext);return TOKEN_AND;}
[|][|]                            {yylval.string=strdup(yytext);return TOKEN_OR;}
[=]|[-][=]|[+][=]                 {yylval.string=strdup(yytext);return TOKEN_ASSIGNOP;}
[+]                               {yylval.string=strdup(yytext);return TOKEN_PLUS;}
[-]                               {yylval.string=strdup(yytext);return TOKEN_MINUS;}
[*]                               {yylval.string=strdup(yytext);return TOKEN_MULTIPLICATION;} 
[%]                               {yylval.string=strdup(yytext);return TOKEN_MODULO;}
[/]                               {yylval.string=strdup(yytext);return TOKEN_DIVISION;}
(([>]|[<])[=])|[>]|[<]            {yylval.string=strdup(yytext);return TOKEN_RELATIONOP;}
[\t]                              {}    
[ ]                               {}    
.                                 {cout<<"\nError in line "<< numLines <<" invalid token " << yytext << endl;return 0;}
\n                                {numLines++;}
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
 