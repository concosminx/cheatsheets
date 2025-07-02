# Concise Explanation of a Docker Container Backup Script

This bash script automates the backup process for Dockerized applications, ensuring data consistency and providing an optional offsite storage mechanism.

```bash
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
```

## Key Steps:

1.  **Date Stamping:** Generates a `YYYY-MM-DD` formatted date for unique backup filenames.
    ```bash
    backupDate=$(date +'%F')
    ```

2.  **Container Stop:** Navigates to the Docker application directory (`/home/ubuntu/docker/mealie`) and stops the `mealie` Docker containers to prevent data corruption during backup.
    ```bash
    cd /home/ubuntu/docker
    cd mealie
    docker compose stop
    ```
    *(Note: Sections for other applications like `meshcentral` are commented out.)*

3.  **Archive Creation:** Returns to the home directory (`/home/ubuntu/`) and creates a gzipped tar archive (`.tar.gz`) of the entire `/home/ubuntu/docker` directory.
    ```bash
    cd /home/ubuntu/
    tar -czvf docker-backup-$backupDate.tar.gz /home/ubuntu/docker
    ```

4.  **Container Start:** Navigates back to the `mealie` application directory and restarts its Docker containers.
    ```bash
    cd docker/mealie
    docker compose start
    ```
    *(Note: Restart sections for other applications are also commented out.)*

5.  **Optional Remote Copy & Cleanup (Commented Out):** The script includes commented-out lines for copying the backup archive to a Network Attached Storage (NAS) using `scp` and then removing the local archive.
    ```bash
    #cd /home/ubuntu
    #scp docker-backup-$backupDate.tar.gz /mnt/data/
    #rm docker-backup-$backupDate.tar.gz
    ```

## Summary:

This script efficiently backs up Docker application data by stopping containers, archiving their data, and restarting them. The commented sections provide a blueprint for expanding its functionality to include multiple applications and offsite backup storage.