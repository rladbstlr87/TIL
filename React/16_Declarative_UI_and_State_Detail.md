# 선언형 UI와 상태 (Declarative UI & State)

- UI가 어떻게 보일지(What)를 '선언'하는 방식
- 어떻게(How) 그릴지 일일이 명령하는 '명령형'과 대조됨

## 핵심
- 상태(State): UI를 결정하는 동적인 데이터
- `useState`: 상태를 생성하고 관리하는 React Hook
- 자동 업데이트: 상태(State)가 변경되면, React가 UI를 자동으로 다시 렌더링
- 개발자는 상태 관리만 집중, DOM 조작 불필요

## 예제: 카운터

- `Counter.js`: 버튼 클릭 시 숫자 증가
```jsx
import React, { useState } from 'react';

function Counter() {
  // count: 상태 변수, setCount: 상태 변경 함수
  const [count, setCount] = useState(0);

  // UI는 'count' 상태에 따라 선언됨
  return (
    <div>
      <h1>카운터: {count}</h1>
      {/* 버튼 클릭 시 setCount를 호출하여 상태만 변경 */}
      <button onClick={() => setCount(count + 1)}>+1 증가</button>
    </div>
  );
}
```
- 동작: `setCount` 호출 -> `count` 상태 변경 -> React가 변경 감지 -> 컴포넌트 리렌더링 -> UI 업데이트
