# 명령어 정리

## `git init`
- 현위치에서 `.git` 폴더 생성하여 새로운 git 저장소를 초기화

## `git clone`
- 현위치에서 원격저장소(리모트) 폴더를 생성? 연결? 복제! 클론은 복제다
```
git clone {url}
```
- 단, 클로닝 하는 폴더 내에 같은 파일 이름있으면 안됨
    - `git push {origin} {master}`
    - `git pull {origin} {master}`
    - push로 동기화 업로드
    - pull로 동기화 다운로드

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
## `git pull/push`
- 원격 저장소에 커밋을 pull(download), push(upload)
```
git push {remote_name (ex)origin} {branch_name (ex)master}
```

**주의사항**
- 꼭 루트 경로에서 pull/push 하자
- `git pull`은 꼭 master 브랜치에서 하는게 좋은 것 같다. 별도의 브랜치에 위치한 상태에서 pull 하면 커밋 입력하라는 vim이 실행된다(귀찮)

---
## `git branch`
- `git branch` : branch 목록 확인
- `git branch {branch_name}` : branch 생성
- `git branch -d {branch_name}` : branch 삭제

## `git switch`
- `git checkout {branch_name}` : branch_name으로 이동. 브랜치의 특정 커밋으로 이동 가능
- `git switch {branch_name}` : branch_nanm으로 이동(최신 명령어). 브랜치의 최신 커밋으로 이동
- `git switch -c {branch_name}` : branch_name **생성과 동시에** branch_name으로 이동

## `git merge`
- `git merge {target_branch_name}` : **현재 branch**로 target_branch_name을 가져와서 병합. github에서 바뀐 코드 부분을 확인하고 merge 하는 방식이 현재 수준에서는 간편
```
git push origin feature/calendar
git switch master
git merge feature/calendar
```

## `git remote update`
- 다른 컴터에서 작업하고 있던 브랜치를 또 다른 컴퓨터에서 끌어오려면 우선 remote update로 어떤 브랜치들이 있는지 인식시켜줘야 함
- 그 후에 switch 하면 브랜치 갈아타짐

# 최종정리
- git init or git clone > 작업 > 저장 > git add/commit/push origin branch > git switch master > pull master > git merge > 작업 > 저장 > add/commit/push > 상태보고싶을 때 git status > ...무한반복
