CXX = g++
LEX = lex
YACC = bison
FileName ?= "input_tests/ex1.in"

run: 
	$(LEX) lexical.l
	$(YACC) -Wnone -d parser.y
	$(CXX) lex.yy.c parser.tab.c -o compiler.out
	./compiler.out $(FileName)

clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h compiler.out


