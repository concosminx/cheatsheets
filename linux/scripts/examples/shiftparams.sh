#!/bin/bash
#Purpose: Shifting positional parameters automatically 
#START
set `date`
echo "Count $#"
echo "$1 $2 $3 $4 $5"
shift
echo "$1 $2 $3 $4 $5"
shift
echo "$1 $2 $3 $4 $5"
shift 2
echo "$1 $2 $3 $4 $5"
#END
