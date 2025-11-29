# 01 React 한눈에 보기
- 목적: React를 처음 접할 때 큰 그림 잡기
- SPA 특징: 첫 로딩 이후 페이지 이동을 클라이언트 라우터가 처리
- 컴포넌트 특징: UI를 작은 조각으로 나눠 재사용
- 상태 관리: Hook으로 상태와 사이드 이펙트를 다룸
- 다국어 지원: i18next가 언어 리소스를 초기화함 ([index.ts](../../lightbearer/web/src/i18n/index.ts))

## 프로젝트 예시: [App.tsx](../../lightbearer/web/src/App.tsx)
- BrowserRouter로 모든 페이지를 감싸 SPA 라우팅을 활성화
```tsx
import { BrowserRouter } from 'react-router-dom'
import { AppRoutes } from './router'

function App() {
  return (
    <BrowserRouter basename={__BASE_PATH__}>
      <AppRoutes />
    </BrowserRouter>
  )
}

export default App
```
- basename 설정 덕분에 배포 경로가 달라도 내부 라우팅이 깨지지 않음
