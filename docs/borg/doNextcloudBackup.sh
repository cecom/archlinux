#!/bin/bash

set -e

SET_ENVFILE=~/bin/setBorgEnv.sh
BACKUP_BASE_FOLDER=/var/snap/nextcloud/common/backups

removeOldSnapBackups(){
  echo -e "\nRemoving old snap backups in [$BACKUP_BASE_FOLDER]..."
  if [ -d $BACKUP_BASE_FOLDER ]; then
     rm -rf -- $BACKUP_BASE_FOLDER/*
  fi
  echo -e "\nRemoving old snap backups in [$BACKUP_BASE_FOLDER]... Done"
}

createSnapBackup(){
  echo -e "\nCreating Backup via snap..."

  nextcloud.export

  echo -e "\nCreating Backup via snap... Done"
}

createBorgBackup(){
  BACKUP_FOLDER="${BACKUP_BASE_FOLDER}/$(ls $BACKUP_BASE_FOLDER)"

  echo -e "\nBackup [$BACKUP_FOLDER] via Borg to storage machine..."

  borg create                              \
        --stats                            \
        --show-rc                          \
        ${BORG_REPO}::${BORG_ARCHIVE_NAME} \
        ${BACKUP_FOLDER}

  echo -e "\nBackup [$BACKUP_FOLDER] via Borg to storage machine... Done"
}

pruneOldBackups(){
  echo -e "\nPruning old Backups..."

  #Prune old Objects
  borg prune                              \
       --list                             \
       --prefix "${BORG_ARCHIVE_PREFIX}_" \
       --show-rc                          \
       --keep-daily    100                \
       --keep-weekly   60                 \
       --keep-monthly  120

  echo "Pruning old Backups... Done"
}

#####################################################################

if [ ! -f "$SET_ENVFILE" ]; then
   echo "[$SET_ENVFILE] not found. Aborting ..."
   exit 1
fi

source $SET_ENVFILE

removeOldSnapBackups
createSnapBackup
createBorgBackup
pruneOldBackups
