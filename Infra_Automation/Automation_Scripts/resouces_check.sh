#!/bin/bash

LOG_FILE="/var/log/bank_health.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
MEM=$(free -m | awk '/Mem:/ {print $3}')
DISK=$(df -h / | awk 'NR==2 {print $5}')

echo "[$DATE] CPU=$CPU MEM=${MEM}MB DISK=$DISK"

echo "[$DATE] CPU=$CPU MEM=${MEM}MB DISK=$DISK" >> $LOG_FILE

SERVICES=("Java" "sshd" "GGADMIN")

for service in "${SERVICES[@]}"
do
    systemctl is-active --quiet $service

    if [ $? -ne 0 ]
    then
        echo "[$DATE] ALERT: $service is DOWN" >> $LOG_FILE
        systemctl restart $service
    fi
done

echo "Monitoring Completed"
