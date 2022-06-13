#!/bin/bash
#Purpose: Example of case statement 
#START
echo -c "Enter a number: \c"
read -r a
echo -c "Enter b number: \c"
read -r b

echo "1. Sum of values"
echo "2. Subtraction"
echo "3. Multiply"
echo "4. Division"
echo "5. Modulo division"
echo -c "Enter Your Choice from above menu: \c"
read -r ch
case $ch in
1) echo "Sum of $a and $b = "`expr $a + $b`;;
2) echo "Subtraction = "`expr $a - $b`;;
3) echo "Multiplication = "`expr $a \* $b`;;
4) echo "Division = "`expr $a / $b`;;
5) echo "Modulo division = "`expr $a % $b`;;
*) echo "Invalid option provided";;
esac
#END
