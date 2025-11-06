# Props와 단방향 데이터 흐름

- `Props`: 부모 컴포넌트에서 자식 컴포넌트로 데이터를 전달하는 통로
- React의 데이터는 항상 단방향(One-Way), 즉 부모 -> 자식으로만 흐름

## 핵심
- Props 전달: 함수에 인자 전달하듯, 컴포넌트 태그에 속성으로 값 전달
- 읽기 전용 (Read-Only): 자식은 전달받은 `props`를 직접 수정할 수 없음
- 예측 가능성: 데이터 흐름이 단방향이므로 앱의 동작을 예측하고 디버깅하기 쉬움

## 예제: 사용자 프로필 전달

- `UserProfile.js` (자식): `props`를 받아 UI를 그림
```jsx
import React from '''react''';

// 부모로부터 name, age를 props로 받음
function UserProfile({ name, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>나이: {age}세</p>
    </div>
  );
}
```

- `App.js` (부모): 자식에게 `props`를 내려줌
```jsx
import React from '''react''';
import UserProfile from '''./UserProfile''';

function App() {
  return (
    <div>
      {/* UserProfile 컴포넌트에 name, age를 props로 전달 */}
      <UserProfile name="김철수" age={30} />
      <UserProfile name="이영희" age={25} />
    </div>
  );
}
```