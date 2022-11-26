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
"//".*                                  {fprintf(yyout,"TOKEN_COMMENT %s \n",yytext);}   
"boolean"                               {fprintf(yyout,"TOKEN_BOOLEANTYPE %s  \n",yytext);}   
"break"                                 {fprintf(yyout,"TOKEN_BREAKSTMT  %s  \n",yytext);}   
"callout"                               {fprintf(yyout,"TOKEN_CALLOUT  %s  \n",yytext);}   
"class"                                 {fprintf(yyout,"TOKEN_CLASS  %s  \n",yytext);}   
"continue"                              {fprintf(yyout,"TOKEN_CONTINUESTMT  %s  \n",yytext);}   
"if"                                    {fprintf(yyout,"TOKEN_IFCONDITION  %s  \n",yytext);}   
"else"                                  {fprintf(yyout,"TOKEN_ELSECONDITION  %s  \n",yytext);}   
"for"                                   {fprintf(yyout,"TOKEN_LOOP  %s  \n",yytext);}   
"int"                                   {fprintf(yyout,"TOKEN_INTTYPE  %s  \n",yytext);}   
"return"                                {fprintf(yyout,"TOKEN_RETURN  %s  \n",yytext);}   
"void"                                  {fprintf(yyout,"TOKEN_VOIDTYPE  %s  \n",yytext);}   
"Program"                               {fprintf(yyout,"TOKEN_PROGRAMCLASS  %s  \n",yytext);}   
"main"                                  {fprintf(yyout,"TOKEN_MAINFUNC  %s  \n",yytext);}   
"false"|"true"                          {fprintf(yyout,"TOKEN_BOOLEANCONST  %s  \n",yytext);}
\"([^"\n]*)\"                           {fprintf(yyout,"TOKEN_STRINGCONST  %s \n",yytext);}
\"([^"\n]*)\\\"([^"\n]*)\"              {fprintf(yyout,"TOKEN_STRINGCONST  %s \n",yytext);}
\"                                      {fprintf(yyout,"Error in line %d unterminated literal  %s \n",numLines,yytext);}
{identifier}                            {fprintf(yyout,"TOKEN_ID %s \n",yytext);}    
{decimal}                               {           
                                        if(strlen(yytext) > 11){
                                            fprintf(yyout,"Error in line %d number %s is out of range\n",numLines,yytext);
                                        }else{
                                            intnum=myAtoi(yytext);
                                            if(intnum > 2147483647 || intnum < -2147483648)
                                                fprintf(yyout,"Error number %s is out of range \n",yytext);
                                            else
                                                fprintf(yyout,"TOKEN_DECIMALCONST  %s \n",yytext);
                                        } 
                                        }
[0][x|X]{hex}+                          {fprintf(yyout,"TOKEN_HEXADECIMALCONST  %s \n",yytext);}
{wrong_identifier}                      {fprintf(yyout,"Error in line %d invalid identifier %s \n",numLines,yytext);}    
"\'\'\'"|"\'\"\'"|"\'\\\'"              {fprintf(yyout,"Error in line %d character is invalid [not allowed character (single quote,backslash,double quote)]  %s \n",numLines,yytext);}
\'[\x20-\x21\x23-\x26\x28-\x5B\x5D-\x7e]\'              {fprintf(yyout,"TOKEN_CHARCONST  %s \n",yytext);}
"\'\\\'\'"|"\'\\\\\'"|"\'\\\"\'"|"\'\\n\'"|"\'\\t\'"    {fprintf(yyout,"TOKEN_CHARCONST  %s \n",yytext);}
\'[\x20-\x26\x28-\x7e][\x20-\x26\x28-\x7e]+\'           {fprintf(yyout,"Error in line %d  invalid character %s [character is long]\n",numLines,yytext);}          
\'                                      {fprintf(yyout,"Error in line %d unterminated  character   %s \n",numLines,yytext);}          
[(]                                     {fprintf(yyout,"TOKEN_LCB  %s \n",yytext);}
[)]                                     {fprintf(yyout,"TOKEN_RCB  %s \n",yytext);}
[{]                                     {fprintf(yyout,"TOKEN_LCB  %s \n",yytext);}
[}]                                     {fprintf(yyout,"TOKEN_RCB  %s \n",yytext);}
\[                                      {fprintf(yyout,"TOKEN_LB %s  \n",yytext);}
\]                                      {fprintf(yyout,"TOKEN_RB %s \n",yytext);}
[;]                                     {fprintf(yyout,"TOKEN_SEMICOLON  %s  \n",yytext);}
[,]                                     {fprintf(yyout,"TOKEN_COMMA  %s \n",yytext);}
[!]                                     {fprintf(yyout,"TOKEN_LOGICOP  %s \n",yytext);}
[!][=]|[=][=]                           {fprintf(yyout,"TOKEN_EQUALITYOP  %s \n",yytext);} 
[&][&]|[|][|]                           {fprintf(yyout,"TOKEN_CONDITIONOP  %s \n",yytext);} 
[=]|[-][=]|[+][=]                       {fprintf(yyout,"TOKEN_ASSIGNOP  %s \n",yytext);} 
[+]|[-]|[*]|[%]|[/]                   {fprintf(yyout,"TOKEN_ARITHMATICOP   %s \n",yytext);} 
(([>]|[<])[=])|[>]|[<]                   {fprintf(yyout,"TOKEN_RELATIONOP  %s \n",yytext);} 
[\t]                                    {fprintf(yyout,"TOKEN_WHITESPACE [tab]   \n");}    
[ ]                                     {fprintf(yyout,"TOKEN_WHITESPACE [space]  \n");}    
.                                       {fprintf(yyout,"Error in line %d invalid token %s\n",numLines,yytext);}
\n                                      {numLines++;fprintf(yyout,"TOKEN_WHITESPACE [newline]\n");}
%%


int yywrap(){};
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



