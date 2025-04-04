# deploy
배포에 필요한 절차 간단하게 정리
### django pjt
0. settings.py
`ALLOWED_HOSTS`에 서버 주소 등록
```
# settings.py
ALLOWED_HOSTS = [
    '.compute.amazonaws.com',
    '*',
]
```
1. git push
원격저장소에 업로드
### AWS
0. 인스턴스 생성(ubuntu 등)
 - 서버 인스턴스 생성
 - 키 페어 > 새 키페어 생성
 - .pem파일 읽기권한만 설정
    - mac : `chmod 600 key/path/key.pem`
    ```bash
    # ssh -i <your/key/path/key.pem> ubuntu@public_IPv4_address
    ssh -i ~/Desktop/key/my_key.pem ubuntu@123.123.123.123
    ```

1. 인바운드 설정
모든 인바운드 허용(경우에 따라 다를 수 있음)
 - 0.0.0.0/0 (IPv4)
 - ::/0 (IPv6)

### python (with pyenv)
0. install
```bash
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```
1. add path
2. Install Python build dependencies
3. install python
 - 작업했던 파이썬 버전 확인하여 같은버전 설치
```bash
pyenv install 3.13.2
pyenv global 3.13.2
python -V
```
### clone project
클로닝 한 후 프로젝트 폴더로 이동하여 의존성에 따라 필요 프로그램 설치/마이그레이션

### nginx
vim으로 location 수정/추가
```bash
sudo vi /etc/nginx/sites-enabled/default
```

### uWSGI
0. 폴더 생성
```
mkdir tmp
mkdir -p log/uwsgi
mkdir -p .config/uwsgi/
```
1. 파일 생성 및 수정
```bash
touch .config/uwsgi/{프로젝트이름}.ini
```

### daemon
0. 파일 생성 및 수정
```bash
touch .config/uwsgi/uwsgi.service
```
1. 심볼릭링크 생성
2. 등록
```
# daemon reload
sudo systemctl daemon-reload

# uswgi daemon enable and restart
sudo systemctl enable uwsgi
sudo systemctl restart uwsgi.service

# check daemon
sudo systemctl | grep nginx
sudo systemctl | grep uwsgi

# restart
sudo systemctl restart nginx
sudo systemctl restart uwsgi
```

### 주소 진입
인스턴스 ID로 진입하여 IPv4 DNS 주소로 진입