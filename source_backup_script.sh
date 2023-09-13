#!/bin/bash

# backupdir=/data01/sw_source_backup
yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')
backupdir = "/data01/$yyyy/$yyyymm/$date/sw_source_backup"

# 용도별 백업폴더 연도별 연월폴더 생성
# mkdir -p "$backupdir/$yyyy/$yyyymm/$date"
mkdir -p "$yyyy/$yyyymm/$date/sw_source_backup"

# 정기백업에 사용할 스크립트 작성
# cp -r /var/www $backupdir/$yyyy/$yyyymm/$date/
