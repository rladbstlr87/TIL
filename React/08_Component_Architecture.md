# 컴포넌트 기반 아키텍처
- 페이지마다 별도 컴포넌트로 쪼개고 라우터에서 조립
- lazy import로 페이지를 늦게 불러 초기 로드 속도를 높임
- 공통 레이아웃이나 네비게이션을 재사용하면 유지보수가 쉬워짐

## 만드는 순서
1. function 만들고
2. return()안에 html담기
3. <함수명></함수명> 쓰기

## 프로젝트 예시: [config.tsx](../../lightbearer/web/src/router/config.tsx)
- 라우터 설정에서 컴포넌트를 느리게 불러와 연결
```tsx
const Home = lazy(() => import('../pages/home/page'))
const About = lazy(() => import('../pages/about/page'))
const Teaser = lazy(() => import('../pages/teaser/page'))

const routes: RouteObject[] = [
  { path: '/', element: <Teaser /> },
  { path: '/home', element: <Home /> },
  { path: '/about', element: <About /> },
]
```
- 필요한 페이지만 요청하도록 구성해 초기 번들 크기를 줄임
