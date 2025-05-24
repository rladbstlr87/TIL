# UV
pip같이 가상환경과 설치되는 패키지들을 관리해주는 툴. Rust로 작성되었으며 병렬처리로 속도가 빠름

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
`python -m venv venv`를 하고 `.gitignore`를 따로 만들어주는 등의 몇몇 초기과정을 명령어 하나로 처리.
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
### 가상환경 활성화/비활성화
~~확인중~~
```
source .venv/bin/activate
deactivate
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

## `pyproject.toml`
의존성 관리의 핵심. 내부에 설치된 라이브러리 이름과 버전이 명시되어있음
