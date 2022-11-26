%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "mem.h"
#include "gram.tab.h"
%}

%option noyywrap

%%
[ \t]
[0-9]+(\.[0-9]+)?          					    { yylval.num = atof(yytext); return NUMBER; }
"+"                         					{ return ADD; }
"-"                         					{ return SUB; }
"*"                         					{ return MUL; }
"/"                         					{ return DIV; }
"%"												{ return MOD; }
"^"                         					{ return POW; }
"="												{ return EQUALS; }
"("												{ return L_BRACKET; }
")"												{ return R_BRACKET; }
("mod")|("MOD")									{ return MOD; }
("pow")|("POW")									{ return POW; }
("cos")|("COS")									{ return COS; }
("sin")|("SIN")									{ return SIN; }
("tan")|("TAN")									{ return TAN; }
("cot")|("COT")									{ return COT; }
("exp")|("EXP")									{ return EXP; }
("ln")|("LN")									{ return LN; }
[a-zA-Z0-9]+  									{ yylval.index = add_variable(yytext); return NAME; }
[\n]                        					{ return EOL; }
. 												{ yyerror("Undefined symbol"); exit(1); } 
%%
