#!/bin/bash

# 사용자로부터 연도와 월을 입력받습니다.
read -p "Enter year (YYYY): " YEAR
read -p "Enter month (MM): " MONTH

# 원격 서버의 로그인 정보와 기본 경로들 (예시)
declare -A REMOTE_SERVERS=(
    ["novomics@218.154.48.138"]="/data01/${YEAR}/${YEAR}${MONTH}"
    ["novomics@192.168.30.201"]="/data01/${YEAR}/${YEAR}${MONTH}"
    ["novomics@192.168.30.202"]="/data01/${YEAR}/${YEAR}${MONTH}"
    ["novomics@192.168.30.203"]="/data01/${YEAR}/${YEAR}${MONTH}"
    ["novomics@192.168.30.206"]="/data01/${YEAR}/${YEAR}${MONTH}"
    # ... 추가 서버 정보를 이곳에 입력 ...
)
declare -a BACKUP_TARGETS=("disk_monitoring" "dump_backup" "svn_backup" "sw_source_backup")
SSH_PORT=30422

LOCAL_BASE_PATH="./temp/${YEAR}.${MONTH}"

for REMOTE_INFO in "${!REMOTE_SERVERS[@]}"; do
    # 원격 서버의 사용자와 호스트 정보 분리
    REMOTE_USER=$(echo "${REMOTE_INFO}" | cut -d '@' -f 1)
    REMOTE_HOST=$(echo "${REMOTE_INFO}" | cut -d '@' -f 2)
    REMOTE_BASE_PATH="${REMOTE_SERVERS[$REMOTE_INFO]}"

    # 원격 서버에서 가장 최신 날짜의 디렉토리 이름을 가져옵니다.
    LATEST_DIR=$(ssh -p ${SSH_PORT} "${REMOTE_INFO}" "ls -d ${REMOTE_BASE_PATH}/* | sort | tail -n 1")

    if [ -z "$LATEST_DIR" ]; then
        echo "${REMOTE_HOST} : Not found latest directory."
        continue
    fi

    # 최신 디렉토리의 절대 경로를 얻습니다.
    LATEST_DIR_PATH=$(ssh -p ${SSH_PORT} "${REMOTE_INFO}" "readlink -f ${LATEST_DIR}")

    # 각 백업 타겟에 대해 rsync를 사용하여 백업을 진행합니다.
    for TARGET in "${BACKUP_TARGETS[@]}"; do

        # 원격 서버의 대상 경로
        REMOTE_TARGET_PATH="${LATEST_DIR_PATH}/${TARGET}"

         # 원격 서버에서 대상 경로의 존재 여부 확인
        if ssh -p ${SSH_PORT} "${REMOTE_INFO}" "test -e ${REMOTE_TARGET_PATH}"; then
            # 로컬 저장 경로 생성 (연도와 월 포함)
            LOCAL_TARGET_PATH="${LOCAL_BASE_PATH}/${TARGET}/${REMOTE_HOST}"
            mkdir -p "${LOCAL_TARGET_PATH}"

            # rsync를 이용하여 원격 디렉토리에서 로컬로 백업 실행
            rsync -avz --delete -e "ssh -p ${SSH_PORT}" "${REMOTE_INFO}:${REMOTE_TARGET_PATH}/" "${LOCAL_TARGET_PATH}/"

            # rsync 실행 결과를 확인
            if [ $? -eq 0 ]; then
                echo "백업 성공: ${REMOTE_TARGET_PATH} -> ${LOCAL_TARGET_PATH}"
            else
                echo "백업 실패: ${REMOTE_TARGET_PATH}"
                # 실패한 경우 계속 진행할지 중단할지 결정할 수 있습니다.
                # 여기서는 계속 진행합니다.
            fi
        else
            echo "원격 경로 ${REMOTE_TARGET_PATH}는 존재하지 않습니다." | tee -a "${BACKUP_LOG}"
            # 존재하지 않으면 이 경로에 대한 백업 작업은 스킵합니다.
        fi
    done

done

# 윈도우 홈페이지 서버
CSV_FILE="config.csv"

# TARGET_HOST에 해당하는 라인을 찾아 비밀번호와 경로를 읽어옵니다.
TARGET_HOST="192.168.30.10"
while IFS=, read -r host port id password path
do
    LOCAL_TARGET_PATH="${LOCAL_BASE_PATH}/sw_source_backup/${host}"
    
    if [[ $host == $TARGET_HOST ]]; then
        # sshpass와 scp를 이용해 파일 전송을 실행합니다.
        # 현재 위치(디렉토리)에서 지정된 호스트의 경로로 파일을 복사합니다.
        mkdir -p "${LOCAL_TARGET_PATH}"
        echo "$id@$host":"$path"
        sshpass -p $password scp -r -P $port "$id@$host":"$path" ./$LOCAL_TARGET_PATH/
    fi
done < "$CSV_FILE"
