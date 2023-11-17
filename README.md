# **월간 백업 스크립트**

## **설명**

이 저장소는 시스템 및 데이터베이스의 월간 백업을 자동화하기 위한 스크립트 모음입니다. 이 스크립트들은 데이터 백업 작업을 간소화하여 수동 개입을 최소화하면서 정기적이고 일관된 백업을 보장하는 것을 목표로 합니다.

## **설치 방법**

이 백업 스크립트를 설치하려면 다음 단계를 따르세요:

1. 저장소 복제: **`git clone https://github.com/novomics-com/montly-backup-scripts.git`**
2. 스크립트 디렉토리로 이동: **`cd montly-backup-scripts`**

## **사용 방법**

백업 스크립트를 사용하려면 다음 지침을 따르세요:

1. 시스템이나 데이터베이스 설정에 맞게 스크립트 구성을 수정하세요.
3. 각 백업 대상 서버에서 스크립트 실행: **`./{target}_backup_script.sh`**
4. (선택사항) 크론 작업 또는 유사한 스케줄러 설정을 통해 실행을 자동화하세요.

   예시)
   ```
   # -----------------------------------------------------------
   # EDIT: 2023. 09. 13 from. MOONSIK SONG
   # -----------------------------------------------------------
   # 디스크 사용량 모니터링 매월 1일/15일 08:00
    00 00 1 * * /data01/scripts/disk_monitoring.sh
    00 00 16 * * /data01/scripts/disk_monitoring.sh
    
    # oracle DB backup script 매월 1월/15일 08:00
    05 00 1 * * /data01/scripts/dump_backup.sh
    05 00 16 * * /data01/scripts/dump_backup.sh
    
    # svn dump script 매월 1월/15일 08:00
    10 00 1 * * /data01/scripts/svn_backup.sh
    10 00 16 * * /data01/scripts/svn_backup.sh
    
    # /var/www cp script 매월 1월/15일 08:00
    15 00 1 * * /data01/scripts/sw_source_backup.sh
    15 00 16 * * /data01/scripts/sw_source_backup.sh
    ```
   
6. `pulling_backup.sh`를 활용하여 백업 데이터를 가져옵니다.
