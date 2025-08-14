# TLS 인증서 적용 — 상황·문제·해결

## 목적과 요구
- 도메인에 TLS를 적용해 외부에서 `https://totheballpark.info` 로 안전하게 접속
- 컨테이너·systemd 부재 환경에서도 인증서 발급과 갱신을 안정적으로 수행
- 인증 과정에서 사용하는 ACME 경로(`/.well-known/acme-challenge/`)를 8081과 8443 양쪽에서 파일로 서빙

---

## 초기 접근과 한계(DNS-01)
- 수동 DNS-01로 시작하여 certbot이 지시하는 TXT를 DNS에 추가
- hosting.co.kr 콘솔 특성 및 캐시로 인해 권한 네임서버(ns1~ns4)에 **예전 토큰만** 보이는 문제가 반복
- certbot을 다시 실행할 때마다 **새 토큰이 생성**되어, 전파 지연과 값 교체 타이밍이 어긋나면서 `unauthorized` 에러가 지속

### 그동안 나타난 대표 증상
- `_acme-challenge` 이름으로 TXT 여러 줄을 추가했지만 권한 NS 응답에는 특정 한 줄만 노출
- 이전 토큰 문자열이 인증 실패 메시지에 그대로 등장
- 콘솔에서 레코드를 추가했는데도 `dig @nsX.hosting.co.kr` 에서 최신 값이 보이지 않음

---

## 전환 전략(HTTP-01, webroot)
- DNS 전파 및 콘솔 동작의 불확실성을 제거하고자 **HTTP-01(webroot)** 방식으로 변경
- Nginx가 8081·8443에서 `/.well-known/acme-challenge/` 경로를 **파일로 서빙**하도록 구성
- 라우터 포트포워딩은 그대로 유지: 외부 80→8081, 외부 443→8443

---

## 실제 작업 순서
1) Nginx에 ACME 경로 추가  
   - 8081 서버블록: `location /.well-known/acme-challenge/ { root /var/www/certbot; }` 를 리다이렉트보다 위에 배치
   - 8443 서버블록에도 동일한 location 추가
2) webroot 디렉터리 준비  
   - `/var/www/certbot/.well-known/acme-challenge` 생성
3) 포워딩 상태 확인  
   - 라우터에서 80→8081, 443→8443 규칙 확인
4) certbot 발급 실행(webroot)  
   - `certbot certonly --webroot -w /var/www/certbot -d totheballpark.info -d www.totheballpark.info -m fellowlabourer@naver.com --agree-tos --no-eff-email`
5) Nginx HTTPS 블록에서 인증서 경로 연결  
   - `ssl_certificate /etc/letsencrypt/live/totheballpark.info/fullchain.pem`
   - `ssl_certificate_key /etc/letsencrypt/live/totheballpark.info/privkey.pem`
6) 리로드 및 동작 점검  
   - `nginx -t && nginx -s reload`  
   - 내부: `curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443`  
   - 외부(LTE): `https://totheballpark.info` 접속 확인

---

## Nginx 설정 스니펫(요지)
```nginx
# 8081: ACME 예외 + 나머지는 HTTPS로 리다이렉트
server {
    listen 8081 default_server;
    listen [::]:8081 default_server;
    server_name totheballpark.info www.totheballpark.info;

    location /.well-known/acme-challenge/ { root /var/www/certbot; }
    location / { return 301 https://$host$request_uri; }
}

# 8443: HTTPS 서비스
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

---

## 발급 결과와 검증
- certbot 출력에서 **발급 성공** 확인
- 인증서 경로: `/etc/letsencrypt/live/totheballpark.info/fullchain.pem` 와 `/etc/letsencrypt/live/totheballpark.info/privkey.pem`
- 만료일: `2025-11-11 09:53:02+00:00` (ECDSA)
- 내부 검증: `curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443` 로 200 또는 301/302 확인
- 외부 검증: 휴대폰 LTE 등 외부망에서 `https://totheballpark.info` 정상 응답 확인

---

## 자동 갱신 운영 방침
- `renew --dry-run` 은 스테이징 리졸버 캐시로 간헐 실패 소지가 있어, **실제 성공했던 webroot 명령을 크론에 등록**
- `0 3 * * * certbot certonly --webroot -w /var/www/certbot -d totheballpark.info -d www.totheballpark.info --keep-until-expiring --quiet && nginx -s reload`
- 컨테이너 재기동 시 `cron` 데몬을 부팅 스크립트에서 기동

---

## 트러블슈팅 노트
- 8081에서 `/.well-known/...` 가 301이면 ACME 파일이 404가 날 수 있으므로 **ACME location을 리다이렉트보다 위에 배치**
- 8443에도 동일한 ACME location을 두어 HTTPS로 접근하는 검증 경로도 확보
- `www` 에 대한 NXDOMAIN이 나오면 권한 네임서버에서 `A www → 125.243.101.110` 응답을 우선 확인
- 내부에서 도메인:443 접속이 안 되면 헤어핀 NAT 이슈일 수 있으므로 `--resolve` 를 사용해 SNI 포함 로컬 검사

---

## 결과
- DNS-01에서 반복되던 전파·캐시 문제를 제거하고 HTTP-01(webroot)로 **지속 가능**한 발급·갱신 경로를 확보
- 8081·8443 양쪽에서 ACME 경로가 파일로 서빙되어 인증·갱신 단계의 실패율을 줄임
- 운영 측면에서 라우터 포워딩과 Nginx 구성, 점검 루틴이 일관되게 정리됨