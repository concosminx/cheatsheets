#!/bin/bash
#Purpose: If / elif statement example
#START
echo -e "Please enter 4 values folowed by space: \c"
read -r a
read -r b
read -r c
read -r d

if [ $a -gt $b -a $a -gt $c -a $a -gt $d ]; then
echo "$a a is boss"
elif [ $b -gt $c -a $b -gt $d ]; then
echo "$b b is boss"
elif [ $c -gt $d ]; then
echo "$c c is boss"
else 
echo "$d d is boss"
fi
#END
