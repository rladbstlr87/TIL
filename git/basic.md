# Git 기본 개념

## Git의 분산버전 관리 시스템
- 클라이언트(내컴)와 서버(깃헙 등) 모두가 같은 데이터를 유지하여 버전을 관리하는 시스템

## 파일의 세가지 상태
![세가지 상태_https](https://git-scm.com/book/ko/v2/images/areas.png)

- 영역
    - working dir : 작성하고 있는 코드, 파일
    - staging area : add 명령어로 올라간 파일들
    - .git dir : 서버의 히스토리

## 파일이 돌아가는 사이클
![cycle_local](../assets/lifecycle.png)

- 나눠서 안정적으로 개발할 수 있게하는 구조
![브랜치 전략](https://devocean.sk.com/editorImg/2023/12/15/6c564810665399f6549ed2bffc7e763c7e39f5fab128a3442ddeb44ee6593c04)
- 유저는 마스터 사용하고 있고, 개발자는 브랜치 새로 만든 곳에서 개발해서 동작시켜보고 안돌아가면 고치고 동작되면 마스터에 머지하면 패치되고 유저는 패치된거 업데이트해서 사용하고...