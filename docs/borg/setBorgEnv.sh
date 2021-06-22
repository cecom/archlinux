#!/bin/sh

export BORG_REPO=ssh://u185827@u185827.your-backup.de:23/./borg/nextcloud
export BORG_RSH='ssh -i ~/.ssh/borg_nextcloud_ed25519'
export BORG_PASSPHRASE='<PW from bitwarden>'

export BORG_ARCHIVE_PREFIX="nextcloud"
export BORG_TIMESTAMP="$(date +%Y%m%d_%R)"
export BORG_ARCHIVE_NAME="${BORG_ARCHIVE_PREFIX}_${BORG_TIMESTAMP}"
