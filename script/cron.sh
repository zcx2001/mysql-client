#!/bin/bash
echo -e "SHELL=/bin/sh\n* * * * * root /script/dbBackup.sh >/proc/1/fd/1 2>/proc/1/fd/2" > /etc/crontab 
env > /etc/environment
cron -f