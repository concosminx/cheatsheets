#!/bin/bash
#START
echo -e "Enter first value: \c"
read -r a
echo -e "Enter second value: \c"
read -r b

if [ $a -gt $b ]; then
echo "$a is greater than $b"
else 
echo "$b is greater than $a"
fi

#END
