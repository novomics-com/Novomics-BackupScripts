#!/bin/bash
source /u01/app/oracle/.bashrc

backupdir=/u01/app/oracle/dump_backup/npms
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d-%H%M%S')
logfile=$backupdir/$yyyymm/$date/$date".log"

mkdir -p "$backupdir/$yyyymm/$date"
echo "program start $date" > $logfile

exp userid='NPMS'/'shdpsfm151#69' file=$backupdir/$yyyymm/$date/$date.dev_npms.dmp log=$logfile

date=$(date +'%Y%m%d-%H%M%S')
echo "program end $date" >> $logfile
