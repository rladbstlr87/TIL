# UV
pip같이 가상환경과 설치되는 패키지들을 관리해주는 툴. Rust로 작성되었으며 병렬처리로 속도가 pip대비 최대 수십 배 빠르다고 함

## Install
```
brew install uv
```
### Upgrading `uv`
```
uv self update
```
## Usage
### run Usage
```
uv
```
### 가상환경 설치
`python -m venv venv`를 하고 `.gitignore`를 따로 만들어주는 등의 몇몇 초기과정을 명령어 하나로 처리
```
uv init
```
- 생성되는 파일 및 폴더는 아래와 같다
```shell
.venv # 이건 폴더
.gitignore
.python-version
main.py
pyproject.toml
README.md
uv.lock
```

### Package management
```
uv add 패키지명
uv add requests
```

## `.py` 파일 실행
```
uv run 파일명.py
```

### 공유받을 때
공유받는 사람 컴퓨터에 uv가 설치되어 있다면
- 실행해보고 싶은 코드의 파일을 실행하면 가상환경부터 패키지 설치까지 자동으로 진행해준다
```
uv run 파일명.py
``` 
