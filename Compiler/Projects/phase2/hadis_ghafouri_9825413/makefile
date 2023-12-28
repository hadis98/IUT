# Makefile for parser
FileName ?= input.txt
PrintMode ?= 1

CXX = g++
LEX = lex
YACC = bison

run: 
	$(LEX) lexical.l
	$(YACC) -d parser.y
	$(CXX) lex.yy.c parser.tab.c -o syntax_analyzer
	./syntax_analyzer $(FileName) $(PrintMode)

clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h a.out

