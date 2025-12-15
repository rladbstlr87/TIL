# useState Hook

- 함수형 컴포넌트에서 상태(State)를 관리하기 위한 React Hook
- 컴포넌트 내에서 변하는 값을 저장하고, 이 값이 변경될 때 컴포넌트를 다시 렌더링(re-render)하도록 트리거

## 사용법

- `const [state변수, state변경함수] = useState(초기값)`
  - `state변수`: 현재 상태 값
  - `state변경함수`: `state변수`를 업데이트하는 함수
  - `초기값`: `state변수`의 초기 상태 값

## 특징

- 상태 변경 함수(`state변경함수`)가 호출되면 컴포넌트가 리렌더링됨
- 리렌더링 시 `state변수`는 최신 상태 값을 유지
- 비동기적으로 작동, 여러 번 호출해도 한 번에 처리될 수 있음

## 예시: 간단한 카운터

```jsx
import React, { useState } from 'react';

function Counter() {
  // 'count'라는 상태 변수와 'setCount'라는 상태 변경 함수 선언
  // 초기값은 0
  const [count, setCount] = useState(0);

  const increment = () => {
    setCount(count + 1); // count 값을 1 증가
  };

  const decrement = () => {
    setCount(count - 1); // count 값을 1 감소
  };

  return (
    <div>
      <p>현재 카운트: {count}</p>
      <button onClick={increment}>증가</button>
      <button onClick={decrement}>감소</button>
    </div>
  );
}

export default Counter;
```