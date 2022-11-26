%{
/* example illustrating the use of states in lex 

   declare a state called INPUT using: %s INPUT

   enter a state using: BEGIN INPUT

   match a token only if in a certain state: <INPUT>\".*\"
*/

%}

%s INPUT
%s OUTPUT
%%

[ \t\n]+                ;
inputfile       BEGIN INPUT;
outputfile      BEGIN OUTPUT;
<INPUT>\".*\"   { ECHO; printf(" is the input file.\n");BEGIN 0; }
<OUTPUT>\".*\"  {ECHO; printf(" is the output file.\n");BEGIN 0;}
\".*\"          { ECHO; printf("\n"); }
.                ;
%%


int yywrap(){}
int main(int argc,char **argv){
    yylex();   
    return 0;
}