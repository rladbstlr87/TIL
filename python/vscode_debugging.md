# VS Code에서 파이썬 디버깅

VS Code는 파이썬 코드 문제 해결을 위한 강력한 디버깅 기능 제공

## 1. 디버깅 시작

VS Code에서 파이썬 파일 디버깅 방법은 두 가지

- F5 키: 현재 파일 기준 즉시 디버깅 세션 시작
- 디버그 뷰 사용:
    1. 왼쪽 사이드바 벌레 모양 디버그 아이콘 클릭
    2. `Run and Debug` 버튼 클릭
    3. 디버그 환경 `Python File` 선택

## 2. `launch.json` 파일로 디버깅 환경 설정

반복적인 디버깅 설정 번거로움 해소를 위해 `launch.json` 파일 생성 및 재사용

1. 디버그 뷰에서 `create a launch.json file` 링크 클릭
2. 디버그 구성 선택 창에서 `Python File` 선택
3. `.vscode` 폴더 및 `launch.json` 파일 자동 생성

F5 키 또는 `Run and Debug` 버튼 클릭 시 `launch.json` 설정으로 디버깅 자동 시작

`launch.json` 파일 예시:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        }
    ]
}
```
- `"program": "${file}"`: 현재 활성화된 파일을 디버깅 대상으로 지정. 특정 파일 디버깅 시 `"${file}"` 대신 파일 경로 직접 입력 가능 (예: `"${workspaceFolder}/main.py"`)

## 3. 중단점(Breakpoint) 사용

코드 실행 중 특정 지점에서 잠시 멈출 때 사용하는 기능

- 코드 편집기 줄 번호 왼쪽 여백 클릭 시 빨간 점으로 중단점 설정
- 디버깅 시작 시 중단점에서 실행 멈춤
- 실행 중단 시 화면 상단 디버그 컨트롤러로 코드 실행 흐름 제어
    - Continue (F5): 다음 중단점까지 실행 계속
    - Step Over (F10): 현재 줄 실행 후 다음 줄로 이동 (함수 내부 진입 안 함)
    - Step Into (F11): 현재 줄에 함수 호출 시 함수 내부로 진입
    - Step Out (Shift+F11): 현재 함수 빠져나와 호출 지점으로 복귀
    - Restart (Ctrl+Shift+F5): 디버깅 세션 다시 시작
    - Stop (Shift+F5): 디버깅 세션 종료

## 4. 디버그 사이드바 활용

코드가 중단점에 멈추면 왼쪽 디버그 사이드바 창을 통해 프로그램 상태 상세 파악 가능

### VARIABLES (변수) 창

- 현재 실행 범위 내 선언된 변수 상태 실시간 확인
- Local: 현재 함수 내 지역 변수 및 값 표시
- Global: 프로그램 전역 범위 변수 표시
- 코드 한 줄씩 실행하며 변수 값 변화 추적, 버그 찾기에 유용

### WATCH (조사) 창

- 특정 변수나 표현식 등록하여 값 변화 지속적 관찰
- `+` 버튼 클릭으로 변수명 또는 표현식 추가 가능 (예: `my_variable * 10`)
- 복잡한 로직 속 특정 값 변화 모니터링에 유용