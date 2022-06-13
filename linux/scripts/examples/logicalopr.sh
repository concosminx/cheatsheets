#!/bin/bash
#Purpose: Logical operators example
#START
#-a and 
#-o or 
#-n not


echo "Enter Math Grade: \c"
read -r m
echo "Enter Physics Grade: \c"
read -r p
echo "Enter Chemistry Grade: \c"
read -r c

if test $m -ge 35 -a $p -ge 35 -a $c -ge 35
then
echo "Congratulations, You have passed in all subjects"
else
echo "Sorry, You failed"
fi
#END
