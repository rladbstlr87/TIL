# 컴포넌트 기반 아키텍처 (Component-Based Architecture)

- UI를 독립적이고 재사용 가능한 컴포넌트 조각으로 나누어 개발
- 레고 블록처럼 UI를 조립하는 방식

## 핵심
- 컴포넌트: UI를 구성하는 독립된 부품
- 종류:
  - 함수형 컴포넌트(Functional Component): 현재 권장되는 방식, `function`으로 선언
  - 클래스형 컴포넌트(Class Component): 예전 방식, `class`로 선언
- 재사용성: 한 번 만든 컴포넌트, 여러 곳에서 재사용 가능
- 유지보수성: 특정 UI 수정 시, 해당 컴포넌트만 격리하여 수정
- 캡슐화: 컴포넌트 내에 HTML, CSS, JS 로직을 함께 관리

## 스타일링
- 컴포넌트의 크기, 색상 등 외형을 결정
- 주요 방식은 인라인, CSS 파일, CSS-in-JS 라이브러리가 있음

### 1. 인라인 스타일 (Inline Styles)
- JSX 태그에 `style` 속성을 직접 사용
- JavaScript 객체 형태로 스타일 전달
- 예시: `<div style={{ width: '100px', height: '50px' }}></div>`

### 2. CSS 파일 분리
- 별도의 `.css` 파일을 생성 (예: `MyComponent.css`)
- 컴포넌트 파일에서 해당 CSS 파일을 `import` (예: `import './MyComponent.css'`)
- JSX 태그에 `className` 속성으로 클래스 이름을 지정

### 3. CSS-in-JS 라이브러리
- JavaScript 코드 내에서 CSS 문법을 사용하는 방식
- `styled-components`, `Emotion` 등이 대표적
- 컴포넌트와 스타일을 하나의 파일에서 관리 가능

## 예제: 버튼 컴포넌트 재사용

- `Button.js`: 재사용될 버튼 컴포넌트
```jsx
import React from 'react';

function Button({ text }) {
  return <button>{text}</button>;
}

export default Button;
```

- `App.js`: `Button` 컴포넌트를 여러 번 사용하는 부모
```jsx
import React from 'react';
import Button from './Button';

function App() {
  return (
    <div>
      {/* 동일한 컴포넌트를 다른 내용으로 재사용 */}
      <Button text="로그인" />
      <Button text="회원가입" />
    </div>
  );
}
```
