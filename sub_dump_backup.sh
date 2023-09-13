#!/bin/bash
yyyy=$1
yyyymm=$2
date=$3
service_name=$4
service_passwd=$5

service_name_lowercase=$(echo "$service_name" | awk '{print tolower($0)}')

backupdir=/tmp/$yyyy/$yyyymm/$date/dump_backup/$service_name
logfile=$backupdir/$date.log

mkdir -p "$backupdir"

echo "program start $date" > $logfile
exp userid="$service_name/$service_passwd" file=$backupdir/$date.$service_name_lowercase.real_.dmp log=$logfile
echo "program end $date" >> $logfile