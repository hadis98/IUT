%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "gram.tab.h"

extern double variable_values[100];
extern int variable_set[100];

extern int yylex(void);
extern void yyterminate();
void yyerror(const char *s);
extern FILE* yyin;
%}

%union {
	int index;
	double num;
}

%token<num> NUMBER
%token<num> L_BRACKET R_BRACKET
%token<num> DIV MUL ADD SUB EQUALS
%token<num> POW MOD
%token<num> COS SIN TAN COT EXP LN
%token<index> NAME
%token<num> EOL
%token  UMINUS UPLUS
%type<num> program_input
%type<num> line
%type<num> calculation
%type<num> expr
%type<num> function
%type<num> assignment

%left ADD SUB 
%left MUL DIV MOD
%left COS SIN TAN COT EXP LN
%right POW 
%right UMINUS UPLUS
%right L_BRACKET R_BRACKET

							
%%
program_input:
	| program_input line
	;
	
line: 
		EOL { printf("Please enter a calculation:\n"); }
		| calculation EOL  { printf("=%.2f\n",$1); }
    ;

calculation:
		  expr
		| function
		| assignment
		;
				
expr:
		expr ADD expr     { $$ = $1 + $3; }
		| expr SUB expr   	{ $$ = $1 - $3; }
		| expr MUL expr     { $$ = $1 * $3; }
		| expr DIV expr     { if ($3 == 0) { yyerror("Cannot divide by zero"); exit(1); } else $$ = $1 / $3; }		
		| expr POW expr     { $$ = pow($1, $3); }
		| expr MOD expr     { $$ = ((int)$1) % ((int)$3); }		
		| NUMBER            { $$ = $1; }
		|function	
		| NAME		{if (variable_set[$1]!=1) { yyerror("Cannot use a variable before its declaration");} else $$ = variable_values[$1]; }	
		| ADD expr %prec UPLUS    { $$ =  $2;}
		| SUB expr %prec UMINUS { $$ = 0-$2; }
		| L_BRACKET expr R_BRACKET { $$ = $2; }
    ;
		
	function:
		COS expr  			  		{ $$ = cos($2); printf("cos(%lf) ",$2);}
		| SIN expr 					{ $$ = sin($2); printf("sin(%lf) ",$2);}
		| TAN expr 					{ $$ = tan($2); printf("tan(%lf) ",$2);}
		| COT expr 					{ $$ = cos($2) /sin($2);printf("cot(%lf) ",$2); }
		| EXP expr 					{ $$ = exp($2); printf("exp(%lf) ",$2); }
		| LN expr 					{ $$ = log($2); printf("ln(%lf) ",$2); }
		;
		
assignment: 
		NAME EQUALS calculation { $$ = set_variable($1, $3); }
		;
%%

int main(int argc, char **argv)
{
        yyin = stdin;
		yyparse();
}

void yyerror(const char *s)
{
	printf("ERROR: %s\n", s);
}
