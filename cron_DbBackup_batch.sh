#!/bin/bash
# 201번, 202번용
# NKMS, NCMS 용 오라클(도커)에 백업 스크립트 실행
docker exec oracle11g_nkms /u01/app/oracle/dump_backup/DbBackup_batch_nkms.sh
docker exec oracle11g_nkms /u01/app/oracle/dump_backup/DbBackup_batch_ncms.sh

# 201번, 203번용
# NPMS 용 오라클(도커)에 백업 스크립트 실행
docker exec oracle11g_npms /u01/app/oracle/dump_backup/DbBackup_batch_npms.sh
