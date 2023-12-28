INPUT_FILE ?= input.txt

all:	
	lex lexical_analyzer.l
	g++ lex.yy.c -o lexical_analyzer
	./lexical_analyzer $(INPUT_FILE)
clean:
	rm lex.yy.c
	rm ./lexical_analyzer


	