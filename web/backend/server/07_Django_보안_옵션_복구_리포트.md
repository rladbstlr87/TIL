# Django 보안 옵션 복구 — 상황·문제·해결

## 목적과 요구
- HTTPS 환경에서 쿠키를 안전하게 전송하도록 `CSRF_COOKIE_SECURE` 와 `SESSION_COOKIE_SECURE` 를 활성화
- `CSRF_TRUSTED_ORIGINS` 를 실제 서비스 도메인의 **https 스킴**으로만 정리
- 프록시(Nginx) 뒤에서 올바른 원본 스킴을 Django가 인지하도록 `SECURE_PROXY_SSL_HEADER` 와 리버스 프록시 헤더 설정 정합성 확보

---

## 초기 상황
- 인증서 적용 전 테스트를 위해 `CSRF_COOKIE_SECURE=False`, `SESSION_COOKIE_SECURE=False` 로 임시 완화한 상태
- `CSRF_TRUSTED_ORIGINS` 에 내부 IP나 http 스킴 항목이 섞여 있었음
- Nginx가 8081→8443 리다이렉트를 수행하고, 앱은 127.0.0.1:8000 에서 동작하는 프록시 환경

---

## 문제 증상
- HTTPS 적용 후에도 보안 쿠키 옵션이 꺼져 있으면 브라우저 혼합 환경에서 세션·CSRF 쿠키가 평문 전송 가능
- 프록시 뒤 환경에서 `SECURE_PROXY_SSL_HEADER` 가 없거나 프록시가 `X-Forwarded-Proto` 를 전달하지 않으면 Django가 요청을 HTTP 로 오인할 수 있음
- `CSRF_TRUSTED_ORIGINS` 의 스킴 또는 도메인이 실제 접근 방식과 불일치하면 CSRF 검증 실패를 유발

---

## 원인 분석
- 인증 절차 중 임시 완화값을 복구하지 않으면 운영 보안 기준 미달
- Django 4.0+ 버전에서는 `CSRF_TRUSTED_ORIGINS` 에 **스킴 포함 형태**가 요구됨 → `https://도메인` 형식이 맞아야 함
- 프록시 환경에서는 Django가 `request.is_secure()` 를 신뢰하려면 `SECURE_PROXY_SSL_HEADER` 와 프록시 측 `X-Forwarded-Proto` 전달이 일치해야 함

---

## 해결 조치
### 1) settings.py 보안 옵션 정리
```python
# cookies
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True

# Django 4.0+ 는 스킴 포함
CSRF_TRUSTED_ORIGINS = [
    'https://totheballpark.info',
    'https://www.totheballpark.info',
]

# 프록시 신뢰 헤더
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# 선택 사항: 추가 강화
# SECURE_HSTS_SECONDS = 31536000
# SECURE_HSTS_INCLUDE_SUBDOMAINS = True
# SECURE_HSTS_PRELOAD = True
```

### 2) Nginx 프록시 헤더 정합성 확인
```nginx
location / {
    include /etc/nginx/proxy_params;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://127.0.0.1:8000;
}
```

### 3) 임시 항목 정리
- `CSRF_TRUSTED_ORIGINS` 에 있던 http 스킴, 내부 IP, 포트 지정 항목 제거
- `ALLOWED_HOSTS` 는 실도메인과 필요한 로컬 호스트만 유지

### 4) 적용
```bash
# 앱 재시작
pkill -f 'gunicorn.*127.0.0.1:8000' || pkill -f gunicorn
nohup /root/tothe_ballpark/venv-py310/bin/gunicorn   --chdir /root/tothe_ballpark   --workers 3 --bind 127.0.0.1:8000   baseball.wsgi:application > /var/log/gunicorn.log 2>&1 &
```

---

## 검증 루틴
- Django 배포 체크
```bash
/root/tothe_ballpark/venv-py310/bin/python manage.py check --deploy
```
- HTTPS 응답과 보안 헤더 확인
```bash
curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443
# X-Frame-Options, X-Content-Type-Options, Referrer-Policy 존재 확인
```
- 세션·CSRF 쿠키가 Secure 플래그로 전달되는지 실제 브라우저 개발자도구에서 확인
- 프록시 인식 확인을 위해 애플리케이션 로그 또는 미들웨어에서 `request.is_secure()` 가 True 인지 점검

---

## 결과
- HTTPS 하에서 세션·CSRF 쿠키가 Secure 로 전송되어 중간자 공격 표면이 축소됨
- 프록시 환경에서 Django 가 HTTPS 를 정확히 인지해 리다이렉트 루프나 보안 기준 오판을 방지
- CSRF 신뢰 출처가 실제 서비스 도메인으로만 정리되어 예측 가능한 운영 상태 확보

---

## 운영 체크리스트
- `settings.py` 보안 옵션 True 상태 유지
- `CSRF_TRUSTED_ORIGINS` 는 `https://totheballpark.info`, `https://www.totheballpark.info` 만 유지
- Nginx 프록시에서 `X-Forwarded-Proto` 전달 유지
- 배포 전 `manage.py check --deploy` 로 기본 보안 점검