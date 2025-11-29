# 02 진입점과 DOM 주입
- index.html의 root div가 React가 붙는 자리
- src/main.tsx가 createRoot로 root에 App을 렌더링
- StrictMode로 의도치 않은 부작용을 조기에 찾음
- Vite가 /src/main.tsx를 엔트리로 번들

## 프로젝트 예시: [index.html](../../lightbearer/web/index.html)
```html
<div id="root"></div>
<script type="module" src="/src/main.tsx"></script>
```

## 프로젝트 예시: [main.tsx](../../lightbearer/web/src/main.tsx)
```tsx
import { StrictMode } from 'react'
import './i18n'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
```
- DOM 주입 흐름: root div -> createRoot -> App 컴포넌트 트리
