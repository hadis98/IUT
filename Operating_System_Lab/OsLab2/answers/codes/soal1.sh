#!/bin/bash

mkdir $1
for (( c=$3; c<=$4; c++ ))
do
	touch $1/$c.$2
done
