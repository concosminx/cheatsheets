#!/bin/bash
#Purpose: Operations 
#START
echo -e "Enter first value: \c"
read -r a
echo -e "Enter the second value: \c"
read -r b

echo "a+b value is $(($a+$b))"
echo "a-b value is $(($a-$b))"
echo "axb value is $(($a*$b))"
echo "a/b value is $(($a/$b))"
echo "a%b value is $(($a%$b))"


echo "a+b value is `expr $a + $b`"
echo "a-b value is `expr $a - $b`"
echo "axb value is `expr $a \* $b`"
echo "a/b value is `expr $a / $b`"
echo "a%b value is `expr $a % $b`"

echo "Completed successfully"
#END
