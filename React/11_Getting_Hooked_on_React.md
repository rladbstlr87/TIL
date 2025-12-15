# React
- html, css, javascript를 편리하게 사용하도록 돕는 라이브러리
- Vue, Svelte 등 유사 프레임워크 대비 압도적인 사용량 보유

## 장점
1. Single Page Application 제작 가능

    ### SPA (Single Page Application)란?
    - 단일 페이지 어플리케이션
    - 최초 1회만 전체 페이지를 로드, 이후 데이터만 비동기적으로 받아와 필요한 부분만 동적 업데이트
    - 페이지 이동 시마다 전체를 새로 렌더링하는 Multi Page Application과 대조됨
    - 데스크탑 앱과 유사한 빠르고 부드러운 사용자 경험 제공

2. Component로 html 재사용 편리

    ### Component란?
    - UI를 구성하는 독립적이고 재사용 가능한 조각
    - 레고 블록처럼 작은 UI 단위(컴포넌트)를 만들어 조합함으로써 더 큰 UI를 구성
    - 컴포넌트 재사용 및 쉬운 유지보수가 가장 큰 장점 (해당 컴포넌트 파일만 수정하면 전체에 반영)

3. 데이터가 html에 자동 반영됨

    ### 데이터 바인딩 (선언형 UI)
    - `state`라는 특별한 데이터 저장 변수를 사용
    - `state` 변경 시, 해당 데이터를 사용하는 HTML 부분이 자동으로 재렌더링됨
    - 개발자는 데이터(`state`)만 관리하면 되므로 코드 복잡도 감소 및 버그 발생 가능성 저하
    - 이러한 방식을 '선언형 UI'라고 칭함

4. React Native
    - 리액트 문법으로 모바일 앱개발 가능

## 핵심 개념

### JSX (JavaScript XML)
- JavaScript 내에서 HTML과 유사한 마크업을 사용하는 구문 확장
- UI의 모습을 코드로 직관적으로 표현
- 예시: `const element = <h1>Hello, world!</h1>;`
- Babel에 의해 `React.createElement()` 같은 순수 JavaScript 코드로 변환됨

### Props (Properties)
- 부모 컴포넌트에서 자식 컴포넌트로 데이터를 전달하는 객체
- 함수에 인자를 전달하듯 컴포넌트에 속성을 부여하여 데이터 전달
- Props는 자식 컴포넌트 내에서 변경할 수 없는 읽기 전용(immutable) 데이터
- 예시: `<Profile name="김철수" age={25} />`
  - `Profile` 컴포넌트에 `name`과 `age`라는 두 가지 props를 전달하는 모습

### Hooks
- 함수형 컴포넌트가 state 관리, 생명주기 연동 등 클래스형 컴포넌트의 기능을 사용하게 해주는 함수
- `use`로 시작하는 네이밍 규칙을 가짐

#### useState
  - 컴포넌트의 상태(state)를 생성하고 관리
  - `[상태값, 상태변경함수]` 형태의 배열을 반환
  - 예시: `const [count, setCount] = useState(0);`
    - `count`: 현재 카운트 값 (초기값 0)
    - `setCount`: `count` 값을 변경하는 함수

#### useEffect
  - 컴포넌트가 렌더링될 때마다 특정 작업(Side Effect)을 수행하도록 설정
  - 예시: API 요청으로 데이터 가져오기, DOM 수동 변경, 타이머 설정 등
  - 예시 코드: `useEffect(() => { document.title = '''You clicked ${count} times'''; });`
    - `count` 상태가 변경되어 리렌더링될 때마다 문서의 제목을 업데이트

### 컴포넌트 생명주기 (Lifecycle)
- 컴포넌트가 생성되고, 사용되고, 소멸되기까지의 과정
- **마운팅 (Mounting)**: 컴포넌트가 생성되어 DOM에 삽입될 때
- **업데이트 (Updating)**: props나 state가 변경되어 리렌더링될 때
- **언마운팅 (Unmounting)**: 컴포넌트가 DOM에서 제거될 때
- `useEffect` Hook으로 각 생명주기 시점에 원하는 로직을 실행
  - 예시: `useEffect(() => { /* 마운팅 시 실행 */ return () => { /* 언마운팅 시 실행 */ }; }, []);`

### 가상돔 (Virtual DOM)
- 실제 DOM의 구조를 모방한 가벼운 JavaScript 객체 복사본
- React가 UI 변경사항을 효율적으로 찾아내고 적용하는 방식
- **동작 순서**
  1. 데이터(state) 변경 시, 전체 UI를 가상 DOM에 다시 렌더링
  2. 이전 가상 DOM과 새로운 가상 DOM을 비교 (이 과정을 'Diffing')
  3. 변경이 필요한 최소한의 부분만 찾아내 실제 DOM에 한 번에 적용(Batch Update)
- 실제 DOM을 직접, 자주 조작하는 것보다 훨씬 빠르므로 성능 향상
