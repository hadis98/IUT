#!/bin/bash

if [ $1  ==  "-r" ];
	then

		while read line; do
		echo $line
		done < $2
	
fi

if [ $1 == "-m" ] ;
	then
		# if [ ! -d $2 ] then
		# 	mkdir $2
		# fi

	for(( i=$5; i<=$6; i++ ))
		do
			touch $2/$3_$i.$4
		done
fi

