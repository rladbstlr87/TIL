# Gunicorn 정상화 — 상황·문제·해결

## 목적과 요구
- Django 애플리케이션을 **Gunicorn WSGI 서버**로 안정적으로 기동
- **컨테이너·systemd 없음** 환경에서 **백그라운드 실행**과 로그 경로 표준화
- Nginx 업스트림 `127.0.0.1:8000` 에 **항상 응답 가능**하도록 유지

---

## 초기 상황
- `systemd` 부재로 `systemctl` 기반 서비스 관리 불가
- Nginx 프록시 설정은 준비됐지만 **업스트림 8000이 비어있어** 502 발생
- 가상환경 이름이 `venv` 가 아니라 `venv-py310` 이고, WSGI 모듈 경로 확인 필요

---

## 증상
- `curl -I http://127.0.0.1:8081` → `502 Bad Gateway`
- `ps -ef | grep nginx` 에 nginx는 있으나 **gunicorn 프로세스 없음**
- `nginx/error.log` 에 `upstream prematurely closed connection` 류 메시지 가능

---

## 원인 분석
- 업스트림 서버가 **미기동** 또는 **잘못된 경로로 실행 시도**
- 가상환경 바이너리 경로가 실제와 달라 **Exit 127** 같은 즉시 종료 발생 가능
- WSGI 모듈명 불일치 시 **ImportError** 로 즉시 종료

---

## 해결 조치

### 1) 가상환경·의존성 점검
```bash
cd /root/tothe_ballpark
echo "$VIRTUAL_ENV"                     # 활성 venv 확인
ls -d venv* 2>/dev/null                 # 실제 venv 디렉터리 확인
./venv-py310/bin/pip show gunicorn || ./venv-py310/bin/pip install -U gunicorn
```

### 2) WSGI 모듈 경로 확인
```bash
# settings에서 WSGI_APPLICATION 확인
grep -R "WSGI_APPLICATION" -n .
# 예: WSGI_APPLICATION = 'baseball.wsgi.application' → gunicorn 대상은 baseball.wsgi:application
```

### 3) 애플리케이션 자체 점검
```bash
./venv-py310/bin/python manage.py check
# 임시 개발서버로 동작 확인
./venv-py310/bin/python manage.py runserver 127.0.0.1:8000
# 다른 터미널에서
curl -I http://127.0.0.1:8000
curl -I http://127.0.0.1:8081
# 확인 후 Ctrl+C로 종료
```

### 4) Gunicorn 백그라운드 실행
```bash
nohup /root/tothe_ballpark/venv-py310/bin/gunicorn   --chdir /root/tothe_ballpark   --workers 3 --bind 127.0.0.1:8000   baseball.wsgi:application > /var/log/gunicorn.log 2>&1 &
```

### 5) 동작 확인
```bash
lsof -i :8000 -P -n 2>/dev/null
curl -I http://127.0.0.1:8000         # 200/301/302 예상
curl -I http://127.0.0.1:8081         # 200/301/302 예상
```

### 6) 실패 시 로그 확인
```bash
tail -n 100 /var/log/gunicorn.log
# ModuleNotFoundError → WSGI 모듈명 재확인
# ImportError/Traceback → 파이썬 패키지 설치 또는 설정 수정
```

### 7) 재시작 루틴
```bash
pkill -f 'gunicorn.*127.0.0.1:8000' || pkill -f gunicorn
nohup /root/tothe_ballpark/venv-py310/bin/gunicorn   --chdir /root/tothe_ballpark   --workers 3 --bind 127.0.0.1:8000   baseball.wsgi:application > /var/log/gunicorn.log 2>&1 &
```

---

## 연계 조치
- 내부 테스트에서 `400 Bad Request` 가 보이면 `ALLOWED_HOSTS` 에 `127.0.0.1`, `localhost`, 실도메인을 포함
- Nginx는 업스트림 헬스만 통과하면 자동으로 정상 응답하므로 **백엔드 우선 확인**이 효율적

예시
```python
ALLOWED_HOSTS = [
  'totheballpark.info', 'www.totheballpark.info',
  '125.243.101.110', '127.0.0.1', 'localhost'
]
```

---

## 결과
- `gunicorn` 이 `127.0.0.1:8000` 에 상시 기동되어 502가 제거됨
- Nginx 프록시(8081/8443) 경유 응답이 200/301/302 로 정상
- 운영 중 재시작·로그 확인·헬스체크 루틴이 정립됨

---

## 운영 체크리스트
- `ps -ef | grep gunicorn` 으로 프로세스 존재 확인
- `curl -I http://127.0.0.1:8000` 이 200/301/302 응답인지 확인
- `/var/log/gunicorn.log` 에 에러 트레이스 없는지 확인
- 설정 변경 시 `pkill ...` 후 **동일 명령**으로 재기동
- 장기적으로는 `supervisor` 나 `process manager` 도입을 검토해 자동 재기동 확보