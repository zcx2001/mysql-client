#!/bin/bash

# 预处理环境变量
filepath=${dbfilepath-"/backup"}
saveFileNum=$[ ${dbSaveFileNum-7} + 1 ]

# 数据库备份，当备份失败时不产生文件
filename=$filepath"/"dbBak-$(date "+%y%m%d%H%M%S").sql

# USER="$1" MYSQL_PWD="$2"
mysqldump -h $host -P $port --single-transaction --triggers --routines --events --set-gtid-purged=OFF --source-data=2 --all-databases > $filename && echo $filename" done" || rm -rf $filename

# 删除过期历史备份
ls -t $filepath"/"dbBak-* | sed -n "$saveFileNum"',$p' | xargs -I {} rm -rf {}

# host=127.0.0.1 port=3306 dbfilepath="/backup" dbSaveFileNum="5" USER="root" MYSQL_PWD="123456" ./dbBackup.sh