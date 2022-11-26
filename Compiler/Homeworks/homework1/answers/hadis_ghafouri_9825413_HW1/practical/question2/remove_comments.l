%{	
	int comment=0;
%}

%%
("/*"[^\n]+"*/")|("//".*\n) {comment++;fprintf(yyout," ");}
%%


int yywrap(){}
int main(int argc,char* argv[])
{
	if(argc!=3)
	{
		printf("Do type as in the command line $./a.out find.txt replace.txt\n");
		exit(0);
	}
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
	yylex();
	printf("No. of comment lines = %d\n",comment);
	return 0;
}

