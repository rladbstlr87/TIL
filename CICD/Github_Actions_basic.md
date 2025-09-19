# GitHub Actions 기본 문법

- GitHub Actions 워크플로우(.yml 파일)의 문법
  - `yaml`이랑 `yml`이랑 완전히 똑같음

## 1. 최상위 기본 구조

```yml
# 워크플로우 이름 (생략 가능)
name: My First Workflow

# 워크플로우 실행 이벤트(조건)
on: [push]

# 실행할 작업(Job)들의 묶음
jobs:
  # 첫 번째 Job의 ID
  my-first-job:
    # Job 실행 가상 머신 환경
    runs-on: ubuntu-latest
    # Job이 수행할 단계(Step)들의 묶음
    steps:
      - name: Print a greeting
        run: echo "Hello World!"
```

---

## 2. 주요 키워드 설명

### `name`
- 워크플로우 이름 지정
- GitHub 'Actions' 탭에 해당 이름으로 표시

### `on`
- 워크플로우 실행 시점(이벤트) 정의
- 주요 이벤트 예시
    - `push`: 특정 브랜치에 코드 푸시 시
    - `pull_request`: 특정 브랜치로 풀 리퀘스트 생성 시
    - `schedule`: 지정된 시간(Cron)에 주기적 실행
    - `workflow_dispatch`: GitHub UI에서 수동 실행

```yml
# master 브랜치에 push 될 때 실행
on:
  push:
    branches:
      - master

# main 브랜치로 pull_request가 열릴 때 실행
on:
  pull_request:
    branches:
      - main
```

### `jobs`
- 워크플로우는 하나 이상의 job으로 구성
- 여러 job은 기본적으로 병렬 실행

### `runs-on`
- job 실행 가상 환경(Runner) 지정
- `ubuntu-latest`, `windows-latest`, `macos-latest` 등 사용

### `steps`
- job 내에서 순차적으로 실행되는 최소 작업 단위
- 각 step은 셸 명령어 실행 또는 액션(Action) 사용

#### `run`
- 러너 셸을 통해 직접 명령어 실행
- `|` 사용 시 여러 줄 명령어 작성 가능
- `echo`, `$VAR` 등은 셸 환경의 문법

```yml
- name: 셸 명령어 실행
  run: |
    echo "첫 번째 라인"
    echo "두 번째 라인"
```

#### `uses`
- 재사용 코드 묶음인 '액션(Action)' 사용
- 복잡한 작업 간소화 (예: 코드 체크아웃, 언어 환경 설정)

```yml
# 코드를 체크아웃하는 공식 액션
- name: 저장소 체크아웃
  uses: actions/checkout@v4
```

### 표현식 `${{ <expression> }}`
- 워크플로우 실행 중 컨텍스트, 비밀 값 접근을 위한 특별 문법
- 셸 문법(`$VAR`)과 다른 GitHub Actions 고유 문법
- 주요 사용 예
    - `secrets`: 레포지토리 비밀 값 접근 (예: `${{ secrets.MY_API_KEY }}`)
    - `github`: 이벤트 관련 정보 접근 (예: `${{ github.SHA }}`)

```yml
- name: 비밀 값 사용하기
  run: echo ${{ secrets.DB_PASSWORD }}
```