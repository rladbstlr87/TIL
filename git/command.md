# 명령어 정리

## `git init`
- 현위치에서 `.git` 폴더 생성하여 새로운 git 저장소를 초기화

## `git clone`
- 현위치에서 원격저장소(리모트) 폴더를 생성? 연결? 복제! 클론은 복제다

## `git status`
- 상태표시
    - un/tracked로 구분

## `git add`
- 설명

```
git add {file_name 혹은(/) dir_name}
git add . => 현재 위치를 기준으로 모든 파일과 폴더를 추가
```

## `git commit`
- 스테이징 에어리어에 있는 변경사항을 커밋하여 히스토리 사진찍음

## `git log`
- 커밋의 히스토리를 조회
- 커맨드 커서에 : 있을 때 q 누르면 eval로 나와지는 너낌
- `--oneline`
- `--graph`

## `git remote`
- 원격 저장소 추가
- 보통 name은 origin 사용
- 추가 add
```
add {name} url자리
```
- 삭제 remove
```
git remote remove {name}
```