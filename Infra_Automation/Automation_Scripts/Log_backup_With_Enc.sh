#!/bin/bash

BACKUP_DIR="/home/vipul/backup"
DATE=$(date +%F)

echo "===== Backup Started ====="

date

mkdir -p $BACKUP_DIR

echo "Current Directory:"
pwd

echo "Creating tar archive..."

tar -czf Trident_$DATE.tar.gz Trident*.log

date

echo "Files in current directory:"
ls -ltrh

echo "Encrypting backup..."

openssl enc -aes-256-cbc -salt -in Trident_$DATE.tar.gz -out banklogs_$DATE.tar.gz.enc -k StrongPassword@123

echo "Moving encrypted backup..."

mv banklogs_$DATE.tar.gz.enc $BACKUP_DIR

echo "Removing temporary tar file..."

rm -f Trident_$DATE.tar.gz

echo "===== Encrypted Backup Completed ====="


