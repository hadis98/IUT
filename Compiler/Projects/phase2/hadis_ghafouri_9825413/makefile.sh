#!/bin/bash

Input=${1}
FileName=${2}
PrintMode=${3}
if [ $Input == "-make" ]
then
	bison -d parser.y
	flex lexical.l
	g++ lex.yy.c parser.tab.c
	echo "a.out was created:)"
	./a.out $FileName $PrintMode
elif [ $Input == "-clean" ]
then
	rm parser.tab.c parser.tab.h lex.yy.c a.out
	echo "removing created files."
fi
