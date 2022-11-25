#!/bin/sh

g++ -std=c++11 -pthread server_struct.cpp -o server 
xterm -e ./server $1 $2 $3 &
for (( c=1; c<=$3; c++ ))
do
    g++ -std=c++11 client.cpp -o client1
	xterm -e ./client $1 $2 &
done
