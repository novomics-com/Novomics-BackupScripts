#!/bin/bash

yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')

# 용도별 백업폴더 연도별 연월폴더 생성
backupdir="/data01/$yyyy/$yyyymm/$date/sw_source_backup"

mkdir -p "$backupdir"

# 정기백업에 사용할 스크립트 작성
cp -r /var/www $backupdir
