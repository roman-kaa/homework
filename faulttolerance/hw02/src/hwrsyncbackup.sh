#!/bin/bash

mkdir -p /tmp/backup

if rsync -av --delete --checksum --exclude='.*' ~/ /tmp/backup/; then
  echo "Backup SUCCESS"
  logger -t backup_home "Backup success"
else
  echo "Backup FAILED"
  logger -t backup_home "Backup failed"
fi
