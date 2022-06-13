#!/bin/bash
#Purpose: Getops examples  
#START
while getopts a:b: options; do
  case $options in
   a) ap=$OPTARG;;
   b) bo=$OPTARG;;
   esac
done

echo "Option A = $ap and Option B = $bo"

#END
