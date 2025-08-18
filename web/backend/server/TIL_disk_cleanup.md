# TIL (2025-08-15)

## 오늘 한 일 요약
서버 디스크 용량 부족 문제를 해결하기 위해 `/var/log` 정리 작업과 로그 용량 관리 스크립트 설정을 진행했습니다.

## 진행한 작업 상세

### 1. /var/log 하위 용량 분석
- `du -xhd1 /var/log | sort -hr` 명령어로 하위 디렉토리별 용량 확인
- `find /var/log -type f -size +100M` 명령어로 대형 로그 파일 식별

### 2. 불필요한 로그 파일/캐시 삭제
- `.gz`, `.1` 로테이션 로그 파일 제거
  ```bash
  rm -rf /var/log/*.gz /var/log/*.1
  ```
- 일부 서비스 로그는 `:>` 로 내용을 비워 서비스 중단 없이 용량 확보
  ```bash
  :> /var/log/nginx/access.log
  :> /var/log/nginx/error.log
  :> /var/log/gunicorn.log
  :> /var/log/bootup.log
  ```

### 3. (deleted) 상태 로그 점유 프로세스 처리
- `lsof +L1` 로 삭제되었지만 프로세스가 붙잡고 있는 로그 파일 확인
- 관련 프로세스(nginx, gunicorn) 재시작

### 4. 부팅 시 거대 로그 자동 정리 설정
- `/root/boot-up.sh`에 로그 용량 체크 및 초과 시 자동 비우기 기능 추가
- `MAX_LOG_SIZE_MB` 기준(512MB) 초과 시 자동으로 0바이트 처리
- 대상 로그:
  - `/var/log/gunicorn.log`
  - `/var/log/bootup.log`
  - `/var/log/nginx/access.log`
  - `/var/log/nginx/error.log`

## 결과
- `/var/log` 용량 98GB → 대폭 감소
- `df -h`로 확인 시 `/` 파티션 여유 공간 확보 완료
