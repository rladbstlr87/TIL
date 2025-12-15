# JSX 문법

- JSX: JavaScript XML, JavaScript를 확장한 문법
- React에서 UI를 표현하고 생성하기 위해 사용

## 속성(Attribute) 사용: `className`

- HTML의 `class` 속성은 JSX에서 `className`으로 사용
- 이유: `class`는 JavaScript의 예약어(클래스 선언 시 사용)이기 때문
- 예시:
  - HTML: `<div class="my-component">`
  - JSX: `<div className="my-component">`
- React가 렌더링 시 `className`을 `class` 속성으로 자동 변환

## 데이터 바인딩(Data Binding): `{}`

- JSX에서 JavaScript 데이터를 HTML에 연결하는 것
- 중괄호 `{}`를 사용하여 변수나 표현식을 JSX에 바인딩함
- 중괄호 안에는 변수, 연산 등 유효한 JavaScript 표현식을 모두 사용할 수 있음
- 예시:
  ```jsx
  const name = "React";
  const element = <h1>Hello, {name}</h1>; // "Hello, React" 출력

  const a = 5;
  const b = 10;
  const sumElement = <p>5 + 10 = {a + b}</p>; // "5 + 10 = 15" 출력
  ```

## `style` 속성 사용

- JSX에서 인라인 스타일(inline style)을 적용할 때는 `style` 속성에 JavaScript 객체를 전달
- 스타일 속성 이름은 camelCase로 작성 (예: `background-color` -> `backgroundColor`, `font-size` -> `fontSize`)
- `style` 속성 값은 항상 객체이므로, 중괄호를 두 번 사용 `style={{...}}`
  - 바깥쪽 `{}`: JSX의 JavaScript 표현식 바인딩
  - 안쪽 `{}`: 스타일을 정의하는 JavaScript 객체
- 예시:
  ```jsx
  // 객체를 변수로 선언하여 전달
  const divStyle = {
    color: 'blue',
    backgroundColor: 'lightgray'
  };

  function StyledComponent() {
    return <div style={divStyle}>Styled Div</div>;
  }

  // 혹은 직접 인라인으로 작성
  function AnotherStyledComponent() {
    return <div style={{ color: 'red', marginTop: '10px' }}>Another Div</div>;
  }
  ```

## 단일 루트 요소 (Single Root Element)

- 컴포넌트의 `return` 문은 반드시 하나의 최상위 태그로 모든 요소를 감싸야 함
- 이유: `return`은 하나의 값만 반환할 수 있으며, 여러 개의 JSX 태그는 여러 값을 반환하는 것과 같기 때문
- 해결책:
  - `<div>`와 같은 부모 태그로 감싸기
  - 불필요한 `<div>` 생성을 피하고 싶을 때 `<React.Fragment>` 또는 축약형 `<>` 사용
- 예시:
  ```jsx
  // 잘못된 예시 - 태그 2개가 병렬로 반환됨
  function WrongReturn() {
    return (
      <h1>제목</h1>
      <p>내용</p>
    );
  }

  // 올바른 예시 - div로 감싸기
  function CorrectReturnDiv() {
    return (
      <div>
        <h1>제목</h1>
        <p>내용</p>
      </div>
    );
  }

  // 올바른 예시 - div 안에 div (중첩 가능)
  function CorrectReturnNestedDiv() {
    return (
      <div>
        <div>
          <h1>제목</h1>
          <p>내용</p>
        </div>
      </div>
    );
  }

  // 올바른 예시 - Fragment로 감싸기
  function CorrectReturnFragment() {
    return (
      <>
        <h1>제목</h1>
        <p>내용</p>
      </>
    );
  }
  ```