%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

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

%%
"//".*                                  {fprintf(yyout,"TOKEN_COMMENT %s \t",yytext);}   
"boolean"                               {fprintf(yyout,"TOKEN_BOOLEANTYPE %s  \t",yytext);}   
"break"                                 {fprintf(yyout,"TOKEN_BREAKSTMT  %s  \t",yytext);}   
"callout"                               {fprintf(yyout,"TOKEN_CALLOUT  %s  \t",yytext);}   
"class"                                 {fprintf(yyout,"TOKEN_CLASS  %s  \t",yytext);}   
"continue"                              {fprintf(yyout,"TOKEN_CONTINUESTMT  %s  \t",yytext);}   
"if"                                    {fprintf(yyout,"TOKEN_IFCONDITION  %s  \t",yytext);}   
"else"                                  {fprintf(yyout,"TOKEN_ELSECONDITION  %s  \t",yytext);}   
"for"                                   {fprintf(yyout,"TOKEN_LOOP  %s  \t",yytext);}   
"int"                                   {fprintf(yyout,"TOKEN_INTTYPE  %s  \t",yytext);}   
"return"                                {fprintf(yyout,"TOKEN_RETURN  %s  \t",yytext);}   
"void"                                  {fprintf(yyout,"TOKEN_VOIDTYPE  %s  \t",yytext);}   
"Program"                               {fprintf(yyout,"TOKEN_PROGRAMCLASS  %s  \t",yytext);}   
"main"                                  {fprintf(yyout,"TOKEN_MAINFUNC  %s  \t",yytext);}   
"false"|"true"                          {fprintf(yyout,"TOKEN_BOOLEANCONST  %s  \t",yytext);}
\"([^"\n]*)\"                           {fprintf(yyout,"TOKEN_STRINGCONST  %s \t",yytext);}
\"([^"\n]*)\\\"([^"\n]*)\"              {fprintf(yyout,"TOKEN_STRINGCONST  %s \t",yytext);}
\"                                      {fprintf(yyout,"Error in line %d unterminated literal  %s \t",numLines,yytext);}
{identifier}                            {fprintf(yyout,"TOKEN_ID %s \t",yytext);}    
{decimal}                               {           
                                        if(strlen(yytext) > 11){
                                            fprintf(yyout,"\nError in line %d number %s is out of range\n",numLines,yytext);
                                        }else{
                                            intnum=myAtoi(yytext);
                                            if(intnum > 2147483647 || intnum < -2147483648)
                                                fprintf(yyout,"\nError: number %s is out of range \n",yytext);
                                            else
                                                fprintf(yyout,"TOKEN_DECIMALCONST  %s \t",yytext);
                                        } 
                                        }
[0][x|X]{hex}+                          {fprintf(yyout,"TOKEN_HEXADECIMALCONST  %s \t",yytext);}
{wrong_identifier}                      {fprintf(yyout,"\nError in line %d invalid identifier %s \t",numLines,yytext);}    
"\'\'\'"|"\'\"\'"|"\'\\\'"              {fprintf(yyout,"\nError in line %d character is invalid [not allowed character (single quote,backslash,double quote)]  %s \n",numLines,yytext);}
\'[\x20-\x21\x23-\x26\x28-\x5B\x5D-\x7e]\'              {fprintf(yyout,"TOKEN_CHARCONST  %s \t",yytext);}
"\'\\\'\'"|"\'\\\\\'"|"\'\\\"\'"|"\'\\n\'"|"\'\\t\'"    {fprintf(yyout,"TOKEN_CHARCONST  %s \t",yytext);}
\'[\x20-\x26\x28-\x7e][\x20-\x26\x28-\x7e]+\'           {fprintf(yyout,"\nError in line %d  invalid character %s [character is long]\n",numLines,yytext);}          
\'                                      {fprintf(yyout,"\nError in line %d unterminated  character   %s \n",numLines,yytext);}          
[(]                                     {fprintf(yyout,"TOKEN_LCB  %s \t",yytext);}
[)]                                     {fprintf(yyout,"TOKEN_RCB  %s \t",yytext);}
[{]                                     {fprintf(yyout,"TOKEN_LCB  %s \t",yytext);}
[}]                                     {fprintf(yyout,"TOKEN_RCB  %s \t",yytext);}
\[                                      {fprintf(yyout,"TOKEN_LB %s  \t",yytext);}
\]                                      {fprintf(yyout,"TOKEN_RB %s \t",yytext);}
[;]                                     {fprintf(yyout,"TOKEN_SEMICOLON  %s  \t",yytext);}
[,]                                     {fprintf(yyout,"TOKEN_COMMA  %s \t",yytext);}
[!]                                     {fprintf(yyout,"TOKEN_LOGICOP  %s \t",yytext);}
[!][=]|[=][=]                           {fprintf(yyout,"TOKEN_EQUALITYOP  %s \t",yytext);} 
[&][&]|[|][|]                           {fprintf(yyout,"TOKEN_CONDITIONOP  %s \t",yytext);} 
[=]|[-][=]|[+][=]                       {fprintf(yyout,"TOKEN_ASSIGNOP  %s \t",yytext);} 
[+]|[-]|[*]|[%]|[/]                   {fprintf(yyout,"TOKEN_ARITHMATICOP   %s \t",yytext);} 
(([>]|[<])[=])|[>]|[<]                   {fprintf(yyout,"TOKEN_RELATIONOP  %s \t",yytext);} 
[\t]                                    {fprintf(yyout,"TOKEN_WHITESPACE [tab]   \t");}    
[ ]                                     {fprintf(yyout,"TOKEN_WHITESPACE [space]  \t");}    
.                                       {fprintf(yyout,"Error in line %d invalid token %s\t",numLines,yytext);}
\n                                      {numLines++;fprintf(yyout,"TOKEN_WHITESPACE [newline]\t");}
%%


int yywrap(){return 1;};
int main(int argc,char *argv[]){
    if(argc !=2){
        printf("enter input file name\n[please note program needs only one argument in command line]\n");
        return 0;
    }
    yyin=fopen(argv[1],"r");
    yyout = fopen("Output.txt", "w");   
    yylex();         
    fclose(yyin);
    fclose(yyout);
    return 0;
}



