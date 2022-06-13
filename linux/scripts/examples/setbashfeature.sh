#!/bin/bash
#Purpose: Set assings its arguments to the positional parameters 
#START
set `date`
echo "Today is $1"
echo "Month is $2"
echo "Date is $3"
echo "Time H:M:S $4"
echo "TimeZone is $5"
echo "Year is $6"
#unset the value ...
set -x
#END
