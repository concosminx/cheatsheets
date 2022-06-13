#!/bin/bash
#Purpose: Array example 
#START
Days=(1 2 3 4 5 6 7)
echo ${Days[2]}
echo ${Days[@]}
echo ${#Days[@]}

names=("Jimmy" "John" "Julie" "Johanna")
fruits[2]='Jack'
for name in ${names[@]}
do
  echo "Name is $name"
done
echo "Number of names is ${#names[@]}"
echo "All names ${names[@]}"
#END
