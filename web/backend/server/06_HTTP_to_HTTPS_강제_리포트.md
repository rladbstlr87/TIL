# HTTP→HTTPS 강제 — 상황·문제·해결

## 목적과 요구
- 모든 HTTP 요청을 HTTPS로 일원화하여 보안 쿠키와 정책이 안정적으로 작동하도록 함
- 인증서 발급·갱신에 필요한 `/.well-known/acme-challenge/` 경로만 HTTP에서 예외 처리
- 외부 사용자는 표준 포트로 접속하고 내부에선 고포트로 운영하는 현재 구조와 충돌이 없도록 구성

---

## 초기 상황
- 라우터는 외부 80→내부 8081, 외부 443→내부 8443으로 포워딩되어 있음
- Nginx는 8081과 8443에서 리슨, 백엔드는 127.0.0.1:8000에서 동작
- HTTP 접근을 전부 HTTPS로 강제하되 ACME 인증 파일 서빙은 HTTP에서도 가능해야 함

---

## 주요 증상
- 8081에서 모든 요청을 곧장 리다이렉트하면 ACME 파일도 301로 이동하여 인증이 404로 실패
- 서버 내부에서 `http://127.0.0.1:8081` 접속 시 `https://127.0.0.1/` 로 리다이렉트되어 443에 리스너가 없어 접속 실패
- 외부(LTE)에서는 정상인데 내부에선 도메인:443이 실패하는 **NAT hairpin 미지원** 이슈 확인

---

## 원인 정리
- ACME 경로 예외가 없으면 certbot의 HTTP-01 파일 검증이 실패
- 리다이렉트 구문 `https://$host$request_uri` 는 포트를 명시하지 않으므로 443으로 향함
- 내부에서 공인 IP로 우회 접속할 때 라우터가 자기 자신으로 돌아오는 루프백을 허용하지 않는 경우가 있어 실패

---

## 해결 조치
- 8081 서버블록에 `/.well-known/acme-challenge/` 를 **리다이렉트보다 위에** 두고 `root /var/www/certbot` 으로 파일 서빙
- 나머지 경로는 `return 301 https://$host$request_uri` 로 HTTPS 강제
- 내부 점검은 `curl --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443` 로 SNI를 강제하여 8443 리스너로 직접 확인
- 외부 동작은 LTE 등 외부망에서 `https://totheballpark.info` 로 확인

---

## 최종 Nginx 스니펫(요지)
```nginx
# 8081: ACME 예외 + 나머지는 HTTPS 리다이렉트
server {
    listen 8081 default_server;
    listen [::]:8081 default_server;
    server_name totheballpark.info www.totheballpark.info;

    location /.well-known/acme-challenge/ { root /var/www/certbot; }
    location / { return 301 https://$host$request_uri; }
}

# 8443: HTTPS 실제 서비스
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
}
```

---

## 검증 루틴
- `curl -I http://127.0.0.1:8081` 에서 301 리다이렉트 확인
- `curl -I http://127.0.0.1:8081/.well-known/acme-challenge/health.txt` 는 200 확인
- `curl -I -k --resolve totheballpark.info:8443:127.0.0.1 https://totheballpark.info:8443` 로 HTTPS 응답 확인
- 외부(LTE)에서 `https://totheballpark.info` 열림 확인

---

## NAT hairpin 대응
- 내부에서 도메인:443으로 접근이 실패하면 `--resolve` 로 8443을 직접 지정해 점검
- 또는 내부 점검 시 `https://127.0.0.1:8443` 를 사용하고 도메인 호스트 검증이 필요하면 `--resolve` 로 SNI를 지정
- 운영에는 영향이 없으며 외부 접속은 정상 동작

---

## 결과
- HTTP 요청은 모두 HTTPS로 일관되게 전환
- ACME 파일은 HTTP에서도 직접 서빙되어 인증·갱신 시 문제가 발생하지 않음
- 내부와 외부 각각의 점검 경로가 명확해져 트러블슈팅 시간이 단축됨