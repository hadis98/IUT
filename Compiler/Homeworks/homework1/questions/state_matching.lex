%{
/* example illustrating the use of states in lex 

   declare a state called INPUT using: %s INPUT

   enter a state using: BEGIN INPUT

   match a token only if in a certain state: <INPUT>\".*\"
*/
%}

%s INPUT

%%

[ \t\n]+                ;
inputfile       BEGIN INPUT;
<INPUT>\".*\"   { BEGIN 0; ECHO; printf(" is the input file.\n"); }
\".*\"          { ECHO; printf("\n"); }
.                ;

%%


