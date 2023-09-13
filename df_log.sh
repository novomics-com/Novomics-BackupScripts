#!/bin/bash

backupdir=/data01/disk_monitoring
yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')

mkdir -p "$backupdir/$yyyy/$yyyymm/$date"
df -h            > $backupdir/$yyyy/$yyyymm/$date/$date"_disk_log.prn"
du -s /var/www/* > $backupdir/$yyyy/$yyyymm/$date/$date"_www_log.prn"
docker exec oracle11g_nkms du -a /u01/app/oracle/oradata/XE/ > $backupdir/$yyyy/$yyyymm/$date/$date"_201_nkms_dbf_log.prn"

docker exec oracle11g_npms du -a /u01/app/oracle/oradata/XE/ > $backupdir/$yyyy/$yyyymm/$date/$date"_201_npms_dbf_log.prn"
