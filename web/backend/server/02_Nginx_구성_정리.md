# Nginx 구성 정리 — 상황·문제·해결

## 목적과 요구
- 8081: ACME 경로만 예외로 두고 나머지는 HTTPS로 리다이렉트
- 8443: 실제 HTTPS 서비스(정적/미디어 프록시 포함)
- 로컬 테스트용 SNI 확인 방법 정립 `curl --resolve ...:8443`

---

## 초기 상황
- 환경은 systemd 없음 → `systemctl reload nginx` 사용 불가
- 특권 포트 제약으로 80/443 직접 리슨 대신 8081/8443 사용
- 인증서 발급 전인데 443 서버블록에서 인증서 경로를 참조하여 `nginx -t` 실패 경험
- 8081에서 전부 HTTPS로 리다이렉트하도록 구성했으나 ACME 경로 예외가 없어 인증 갱신이 404로 실패

---

## 목표 구성 스케치
```
[Internet] -> Router
  80  -> 8081 (Nginx HTTP)
  443 -> 8443 (Nginx HTTPS)

Nginx 8081
  ├─ /.well-known/acme-challenge/ 은 파일 서빙
  └─ 그 외는 모두 301 → https://$host$request_uri

Nginx 8443
  ├─ 인증서 적용
  ├─ 정적/미디어 alias
  └─ proxy_pass → 127.0.0.1:8000

Gunicorn 127.0.0.1:8000
```
- 라우터 포트포워딩은 기존 상태 유지 `80→8081`, `443→8443`
- 내부에서 도메인:443 테스트는 헤어핀 NAT 제약이 있어 `--resolve`로 SNI를 강제해 점검

---

## 실제 적용 내용
### 1) 8081 서버블록 정리
- ACME 경로만 파일로 응답하도록 최상단에 별도 location 추가
- 그 외 요청은 HTTPS로 301 리다이렉트
```nginx
server {
    listen 8081 default_server;
    listen [::]:8081 default_server;
    server_name totheballpark.info www.totheballpark.info;

    location /.well-known/acme-challenge/ { root /var/www/certbot; }

    location / { return 301 https://$host$request_uri; }
}
```

### 2) 8443 서버블록 정리
- 인증서 경로 연결
- 정적/미디어 alias와 앱 프록시 구성
- 프록시 헤더 포함 및 보안 헤더 유지
```nginx
server {
    listen 8443 ssl http2;
    listen [::]:8443 ssl http2;
    server_name totheballpark.info www.totheballpark.info;

    ssl_certificate     /etc/letsencrypt/live/totheballpark.info/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/totheballpark.info/privkey.pem;

    location /.well-known/acme-challenge/ { root /var/www/certbot; }

    location /static/ { alias /root/tothe_ballpark/staticfiles/; access_log off; expires 7d; }
    location /media/  { alias /root/tothe_ballpark/media/;       access_log off; expires 7d; }

    location / {
        include /etc/nginx/proxy_params;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://127.0.0.1:8000;
    }

    client_max_body_size 10m;
    add_header X-Frame-Options DENY always;
    add_header X-Content-Type-Options nosniff always;
    add_header Referrer-Policy same-origin always;
    add_header Permissions-Policy "geolocation=()" always;
}
```

### 3) 재적용과 점검 루틴
- 리로드는 신호 기반 사용 `nginx -t && nginx -s reload`
- ACME 헬스파일로 경로 검증
```bash
mkdir -p /var/www/certbot/.well-known/acme-challenge
echo ok >/var/www/certbot/.well-known/acme-challenge/health.txt

# 8081은 200 이어야 함
curl -I http://127.0.0.1:8081/.well-known/acme-challenge/health.txt

# 8443은 200 또는 301/302 응답 확인
curl -I -k --resolve totheballpark.info:8443:127.0.0.1   https://totheballpark.info:8443/.well-known/acme-challenge/health.txt
```

---

## 진행 중 문제와 해결
- **`nginx -t` 실패**  
  인증서 발급 전에 8443 블록에서 인증서 파일을 참조해 실패 → 발급 전에는 SSL 참조 제거 또는 HTTP만 유지로 점검 후, 발급 완료 뒤 8443 블록 활성화
- **ACME 404**  
  8081에서 전량 리다이렉트만 두어 인증 파일이 404 → `/.well-known/acme-challenge/` location을 리다이렉트보다 위에 두고 `root /var/www/certbot`로 직접 서빙
- **내부에서 도메인:443 접속 실패**  
  라우터 헤어핀 NAT 미지원 → `curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443` 로 SNI 포함 로컬 점검
- **프록시 헤더 해시 경고**  
  기능 영향은 없으나 깔끔히 하려면 `nginx.conf` 의 `http {}` 안에 아래 두 줄 추가
  ```
  proxy_headers_hash_max_size 1024;
  proxy_headers_hash_bucket_size 128;
  ```

---

## 결과
- 8081은 ACME 파일을 200으로 응답하고 그 외는 HTTPS로 리다이렉트
- 8443은 인증서가 적용된 실제 서비스로 정적/미디어 서빙과 앱 프록시가 정상
- 로컬과 외부 모두에서 점검 방법이 확립되어 재현 가능한 운영 절차 확보

---

## 운영 체크리스트
- `nginx -t && nginx -s reload` 로 적용 여부 확인
- `curl -I http://127.0.0.1:8081/.well-known/acme-challenge/health.txt` 로 ACME 경로 확인
- `curl -I http://127.0.0.1:8081` 시 301 이면 정상
- `curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443` 로 HTTPS 응답 확인
- 문제 발생 시 `/var/log/nginx/error.log` 확인