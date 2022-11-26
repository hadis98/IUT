all:	calc

calc: lex.l gram.y
	bison -d gram.y
	flex lex.l
	gcc gram.tab.c lex.yy.c -lm -o calculator

clean:
	rm -rf calc *.o *.c  y.tab.*