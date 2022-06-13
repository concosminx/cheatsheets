#!/bin/bash
#Purpose: Forloop example 
#START
for i in `cat hostfile.dat`
do
ping -c 1 $i > /tmp/pingresults.log
valid=`echo $?`
if [ $valid -gt 1 ]; then
echo "$i Host is not reachable"
else
echo "$i Host is up"
fi
done 
#END
