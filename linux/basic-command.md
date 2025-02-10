# 리눅스의 기본 명령어

## 0. 명령어의 기본 형식
```
command [-options] [arguments]
```
- command : 실행할 명령어 or 프로그램
- options : 명령어의 옵션(보통 -이 붙는다)
- arguments : 명령어에 전달할 인자(값)
- . : 현재 폴더
- .. : 상위폴더(현대 편집중이거나 위치해있는 파일위치보다)

## 1. 파일 및 디렉토리 관리

### ls (list)
- 디렉토리 내용의 목록을 나타냄
- options:
    - `-l` : 파일의 상세 정보 표시
    - `-a` : 숨김 파일도 표시 (all)

### cd (change directory)
- 현재 작업 디렉토리를 변경
- `cd {target-directory}`
    - 폴더명 입력 시 첫글자부터 일부 입력하고 Tap키 누르면 폴더명 자동입력 해줌

### pwd (print working directory)
- 현재 경로 출력

### mkdir (make directory)
- 폴더 생성(새로운 디렉토리 생성)
- `mkdir {폴더명}

### touch
- 새 파일 생성
- `touch {파일명}`

### rm (remove)
- 파일 삭제
- `rm {파일명}`
- options
    - `rm -r {폴더명}` : 디렉토리와 그 내용을 재귀적으로 삭제(r이 recursion-재귀를 뜻함. 자기 자신을 참조하는 것)

### cat (concatenate) 사슬처럼 연결하는 너낌
- 파일의 내용을 터미널에 출력
