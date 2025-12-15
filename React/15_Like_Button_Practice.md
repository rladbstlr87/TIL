# React 좋아요 버튼 (onClick, useState)

- `useState` Hook을 사용하여 컴포넌트의 상태(state)를 관리하고, `onClick` 이벤트를 통해 이 상태를 변경하는 예제

## 핵심 개념

1.  `useState`:
    - 함수형 컴포넌트에서 상태를 관리하게 해주는 Hook
    - `[상태값, 상태변경함수]` 형태의 배열을 반환
    - 예: `const [likes, setLikes] = useState(0);`
        - `likes`: 현재 좋아요 수 (상태값), 초기값은 `0`
        - `setLikes`: `likes` 상태를 변경하는 함수

2.  `onClick`:
    - 사용자가 요소를 클릭할 때 실행될 함수를 지정하는 이벤트 핸들러
    - `onClick={() => { /* 실행할 코드 */ }}` 형태로 사용

## 예제 코드

```jsx
import React, { useState } from 'react';

function LikeButton() {
  // useState를 사용하여 'likes'라는 상태 변수와 'setLikes'라는 업데이트 함수를 생성
  // 초기값은 0으로 설정
  const [likes, setLikes] = useState(0);

  // 버튼 클릭 시 실행될 함수
  const handleLike = () => {
    // setLikes 함수를 호출하여 likes 상태를 1 증가시킴
    setLikes(likes + 1);
  };

  return (
    <div>
      {/* onClick 이벤트에 handleLike 함수를 연결 */}
      <button onClick={handleLike}>
        👍 좋아요
      </button>
      {/* 현재 likes 상태 값을 화면에 표시 */}
      <span>{likes}</span>
    </div>
  );
}

export default LikeButton;
```

## 동작 설명

1.  초기 렌더링:
    - `LikeButton` 컴포넌트가 처음 렌더링될 때 `useState(0)`이 호출됨
    - `likes` 상태는 `0`으로 초기화되고, 화면에는 '좋아요' 버튼과 숫자 `0`이 표시됨

2.  버튼 클릭:
    - 사용자가 '좋아요' 버튼을 클릭하면 `onClick` 이벤트에 연결된 `handleLike` 함수가 실행됨
    - `handleLike` 함수는 `setLikes(likes + 1)`를 호출함

3.  상태 업데이트 및 리렌더링:
    - `setLikes` 함수가 호출되면 React는 `likes` 상태가 변경되었음을 감지
    - React는 `LikeButton` 컴포넌트를 리렌더링(re-rendering)함
    - 이때 `likes` 값은 `1`이 되고, 화면의 숫자도 `1`로 업데이트됨
    - 이후 버튼을 클릭할 때마다 이 과정이 반복됨
