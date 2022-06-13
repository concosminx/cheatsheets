#!/bin/bash
#Purpose: Relational operators 
#START

#-lt less than 
#-le lesss than or equal to 
#-gt greater than
#-ge greater than or equal to 
#-eq equal to 
#-ne not equal to

echo -e "First number"
read -r h
echo -e "Second number"
read -r g

test $h -lt $g; echo "$?";
test $h -le $g; echo "$?";
test $h -gt $g; echo "$?";
test $h -ge $g; echo "$?";
test $h -eq $g; echo "$?";
test $h -ne $g; echo "$?";

#END
