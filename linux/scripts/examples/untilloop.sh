#!/bin/bash
#Purpose: Unit Loop Example for Host Ping 
#START
echo -e "Please enter the IP to ping: \c"
read -r ip
until ping -c 3 $ip
do
   echo "Host $ip is Still Down"
   sleep 1
done

echo "Host $ip is Up Now"
#END
