#!/bin/bash
#Purpose: While loop example 
#START
echo -e "Provide one value: \c"
read -r c
i=1
while [ $i -le 10 ]
do
b=`expr $c \* $i`
echo "$c * $i = $b"
i=`expr $i + 1`
done
#END
