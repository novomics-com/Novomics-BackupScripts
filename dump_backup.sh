#!/bin/bash

yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')
dateht=$(date +'%Y%m%d-%H%M%S')

mkdir -p /data01/$yyyy/$yyyymm/$date/dump_backup

# service_name, service_passwd
create_dump(){
    local service_name=$1
    local service_passwd=$2
    local service_name_lowercase=$(echo "$service_name" | awk '{print tolower($0)}')

    if docker ps -q --filter "name=oracle11g_$service_name_lowercase" | grep -q .; then
        docker cp /data01/scripts/sub_dump_backup.sh oracle11g_$service_name_lowercase:/tmp/
        docker exec oracle11g_$service_name_lowercase sh -c "/tmp/sub_dump_backup.sh $yyyy $yyyymm $date $service_name $service_passwd" 
        docker cp oracle11g_$service_name_lowercase:/tmp/$yyyy/$yyyymm/$date/dump_backup/$service_name /data01/$yyyy/$yyyymm/$date/dump_backup
        docker exec oracle11g_$service_name_lowercase rm -rf /tmp/$yyyy
        docker exec oracle11g_$service_name_lowercase rm -rf /tmp/$yyyy /tmp/sub_dump_backup.sh
    fi
}

create_dump NPMS shdpsfm151#69
create_dump NKMS shzpfm151#69
create_dump NCMS shdlfm151#69