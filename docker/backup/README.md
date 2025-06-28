# Schedule the back-up

```
sudo crontab -e
0 2 * * * bash /home/ubuntu/backup-docker-bb1.sh
```

# Back-up named volumes (docker compose)
```sh
docker run --rm \ 
  --volume [DOCKER_COMPOSE_PREFIX]_[VOLUME_NAME]:/[TEMPORARY_DIRECTORY_TO_STORE_VOLUME_DATA] \
  --volume $(pwd):/[TEMPORARY_DIRECTORY_TO_STORE_BACKUP_FILE] \
  ubuntu \
  tar cvf /[TEMPORARY_DIRECTORY_TO_STORE_BACKUP_FILE]/[BACKUP_FILENAME].tar /[TEMPORARY_DIRECTORY_TO_STORE_VOLUME_DATA]
```

# Restore back-ups (docker compose)
```sh
docker run --rm \ 
  --volume [DOCKER_COMPOSE_PREFIX]_[VOLUME_NAME]:/[TEMPORARY_DIRECTORY_STORING_EXTRACTED_BACKUP] \
  --volume $(pwd):/[TEMPORARY_DIRECTORY_TO_STORE_BACKUP_FILE] \
  ubuntu \
  tar xvf /[TEMPORARY_DIRECTORY_TO_STORE_BACKUP_FILE]/[BACKUP_FILENAME].tar -C /[TEMPORARY_DIRECTORY_STORING_EXTRACTED_BACKUP] --strip 1
```
