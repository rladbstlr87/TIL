# Redux
상태 관리 라이브러리
- props 문법 귀찮을 때 사용
- state(변수) 상태 변경 관리할 때 사용

### props 대체재
리액트는 component안에 component안에 component가 들어있는 구조로 작성하게 된다. 그런데 상위 component에서 정의한 state를 하위 component에서 사용하려면 props 문법으로 전송해줘야 함. 그 컴포넌트의 하위 컴포넌트에서 동일한 변수를 사용하려면 이중으로 전송해줘야 함.
리덕스 설치하면 store에 변수를 저장해두고 어느 컴포넌트에서든 꺼내쓸 수 있게 됨.
```js
// index.js에서 import
import React from "react";
import ReactDOM from "react-dom/client";
import { Provider } from "react-redux";
import { configureStore } from "@reduxjs/toolkit";
import counterReducer from "./counterSlice";
import App from "./App";

const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
});

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <Provider store={store}>
    <App />
  </Provider>
);
```
```js
// App.js에서 실제로 사용하는 문법
import React from "react";
import { useSelector, useDispatch } from "react-redux";
import { increment, decrement } from "./counterSlice";

function App() {
  const count = useSelector((state) => state.counter.value);
  const dispatch = useDispatch();

  return (
    <div>
      <h1>Count: {count}</h1>
      <button onClick={() => dispatch(increment())}>+</button>
      <button onClick={() => dispatch(decrement())}>-</button>
    </div>
  );
}

export default App;
```

### 상태 관리
state 아래에 수정방법을 다 적어놓게 되어있음. api만드는 것과 비슷함. 이후 각 컴포넌트에서는 수정 요청만 가능하고 디버그할때 스토어만 보면 관리나 상태확인이나 수정이 가능.

```js
// state 수정방법 작성 예시, 즉 리듀서 작성 예시 (counterSlice.js)
import { createSlice } from "@reduxjs/toolkit";

const counterSlice = createSlice({
  name: "counter",
  initialState: { value: 0 },
  reducers: {
    increment: (state) => {
      state.value += 1;
    },
    decrement: (state) => {
      state.value -= 1;
    },
  },
});

export const { increment, decrement } = counterSlice.actions;
export default counterSlice.reducer;

```
```js
// 컴포넌트에서 dispatch 작성 예시
import { useDispatch } from "react-redux";
import { increment } from "./counterSlice";

function ExampleButton() {
  const dispatch = useDispatch();
  return <button onClick={() => dispatch(increment())}>카운트 증가</button>;
}

export default ExampleButton;

```