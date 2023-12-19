#!/bin/bash

# Get today's date for our backup filename
backupDate=$(date  +'%F')

# this just prints the formated date variable to the console if you want to see it.
#echo $backupDate

# move to the path where you will keep all of yoru docker configurations and data
cd /home/ubuntu/docker

# move into the first folder and run the stop command.
cd mealie
docker compose stop

# move back one level (../) then into the next folder and again stop the containers
#cd ../meshcentral
#docker-compose stop

# move back to your home directory and create a tar archive of your docker parent folder
cd /home/ubuntu/
tar -czvf docker-backup-$backupDate.tar.gz /home/ubuntu/docker

# move into each application folder and start the containers again
cd docker/mealie
docker compose start

# repeatedly move back one leve, then into the next application folder and start the containers
#cd ../meshcentral
#docker-compose start

# now go back to home, and copy my backup file to my NAS
#cd /home/ubuntu
#echo ""
#echo "Backup copy is running..."

# use secure copy to copy the tar archive to your final backup location (in my case a mounted NFS share)
#scp docker-backup-$backupDate.tar.gz /mnt/data/

# remove the tar file from the main home folder after it's copied
#rm docker-backup-$backupDate.tar.gz