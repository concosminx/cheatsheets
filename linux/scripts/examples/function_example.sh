#!/bin/bash
#Purpose: Function call example
#START

function backupFile() {
  if [ -f $1 ]; then
  BACKUP_DEST="/opt/$(basename ${1}).$(date +%F).$$" #backup destination file; use YYY-MM-DD date format
  echo "Backing up $1 to ${BACKUP_DEST}"
  cp $1 $BACKUP_DEST
  fi
}

backupFile /etc/hosts
  if [ $? -eq 0 ]; then
  echo "Backup done!"
  else "Backup error!"
  fi

#END
