#!/bin/bash
yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')
dateht=$(date +'%Y%m%d-%H%M%S')

backupdir=/data01//$yyyy/$yyyymm/$date/disk_monitoring

mkdir -p "$backupdir"
df -h            > $backupdir/$dateht"_disk_log.prn"
du -s /var/www/* > $backupdir/$dateht"_www_log.prn"

docker exec oracle11g_nkms du -a /u01/app/oracle/oradata/XE/ > $backupdir/$dateht"_201_nkms_dbf_log.prn"
docker exec oracle11g_npms du -a /u01/app/oracle/oradata/XE/ > $backupdir/$dateht"_201_npms_dbf_log.prn"
