#!/bin/bash
#Purpose: If statement example
#START
echo -e "Please provide a value below ten: \c"
read -r value

if [ $value -le 10 ]
then
echo "You provided the value $value"
touch /tmp/test{1..10}.txt
echo "Script completed sucessfully"
fi

#END
