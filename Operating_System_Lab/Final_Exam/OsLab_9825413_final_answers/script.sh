#!/bin/bash
gcc -std=c++11  server_exam.c -o server_exam -lpthread
gcc -std=c++11 client_exam.c -o client_exam -lpthread


./server_exam $1 &
 for ((c=1; c<=$1; c++))
 do
   gnome-terminal -e "bash -c \"./client_exam; exec bash\""

 done

# gcc -std=c++11 -pthread server_exam.c -o server_exam 
# xterm -e ./server $1 &
# for (( c=1; c<=$1; c++ ))
# do
#     gcc -std=c++11 client_exam.c -o client_exam
# 	xterm -e ./client &
# done