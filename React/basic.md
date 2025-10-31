# React 기본 렌더링: App.js와 index.html

## 핵심: DOM 주입 (DOM Injection)
- React는 SPA(Single Page Application) 라이브러리
- index.html의 특정 DOM 요소에 동적으로 컨텐츠를 '주입'하는 방식
- 개발자는 index.html 직접 수정 없이 컴포넌트 파일(App.js 등) 작업에 집중 가능

## 렌더링 과정

1.  public/index.html
    - React 앱의 유일한 HTML 파일이자 전체 페이지의 뼈대
    - 내부에 컨텐츠가 렌더링될 진입점(entry point)으로 <div id="root"></div> 요소를 포함

2.  src/index.js
    - React 애플리케이션의 시작점(entry point) 역할을 하는 JavaScript 파일
    - ReactDOM.createRoot()를 사용해 index.html의 <div id="root"></div>를 React 루트로 지정
    - root.render() 메소드로 <App /> 컴포넌트를 React 루트에 렌더링하도록 지시

3.  src/App.js
    - 애플리케이션의 최상위 UI 컴포넌트
    - JSX 문법을 사용해 실제 표시될 UI 구조와 내용을 작성
    - 이 컴포넌트의 내용이 index.js를 통해 index.html의 root div 내부에 최종적으로 삽입됨

## package.json
- 프로젝트 정보(이름, 버전 등)와 의존성(dependencies)을 관리하는 파일
- "dependencies": 앱 실행에 필요한 라이브러리 (예: react, react-dom)
- "devDependencies": 개발 과정에서만 필요한 라이브러리 (예: 테스팅 도구, 빌드 도구)
- "scripts": `npm start`, `npm build` 등 자주 사용하는 명령어를 정의