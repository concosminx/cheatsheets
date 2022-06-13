#!/bin/bash
#Purpose: Nested ifs 
#START
echo -e "Enter Maths grade: \c"
read -r m
echo -e "Enter Physics grade: \c"
read -r p
echo -e "Enter Chemistry grade: \c"
read -r c

if [ $m -ge 35 -a $p -ge 35 -a $c -ge 35 ]; then
total=`expr $m + $p + $c`
avg=`expr $total / 3`
echo "Total grades = $total"
echo "Average grade = $avg"
      if [ $avg -ge 75 ]; then
      echo "Congrats, you got distinction"
      elif [ $avg -ge 60 -a $avg -lt 75 ]; then
      echo "Congrats, you got first class"
      elif [ $avg -ge 50 -a $avg -lt 60 ]; then
      echo "You got second class"
      elif [ $avg -ge 35 -a $avg -lt 50 ]; then
      echo "You got third class"
      fi
else 
echo "Sorry, You failed"
fi

#END
