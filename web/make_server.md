# 공기계 서버구동
## 공기계
1. 루팅
2. Termux 설치
3. Pkg 여러가지 설치
4. 포트포워딩
5. 프로젝트 설치(Dango)
### Nginx
1. Nginx.conf 실행
```
nano ~/nginx.conf
```
2. conf 수정
```
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       nginx가 열어둔 내부포트;
        server_name  localhost;

        location / {
            proxy_pass http://127.0.0.1:넘길 제3의 포트;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```
3. Nginx 실행
```
nginx -c ~/nginx.conf
```

재시작
```
pkill nginx
nginx -c ~/nginx.conf
```
### ngrok
역터널링으로 외부에서 접속 가능한 https주소 생성
1. 설치
```
pkg update && pkg install wget unzip -y
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip
unzip ngrok-stable-linux-arm64.zip
mv ngrok $PREFIX/bin
chmod +x $PREFIX/bin/ngrok
```
2. 토큰 등록
```
ngrok config add-authtoken <여기에_당신의_토큰>
```
3. 포트 관리
이미 nginx가 8080 포트에서 Django로 프록시하고 있고, 외부 접속도 nginx를 통해 보안 관리하고 싶다면
```
ngrok http 엔진엑스리슨포트
```
### Django
1. `settings.py`에 ALLOWED_HOSTS 설정
- ALLOWED_HOSTS 설정에 ngrok URL을 추가
```
ALLOWED_HOSTS = ['127.0.0.1', 'localhost', ‘공인IP’, ‘도메인? 아이디? 아직 미확인.ngrok.io']
```

2. 서버실행
```
python manage.py runserver 127.0.0.1:8140
```
