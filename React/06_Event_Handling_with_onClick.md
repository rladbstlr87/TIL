# onClick으로 이벤트 처리
- JSX에서는 이벤트 이름을 camelCase로 쓰고 함수 참조를 넘긴다
- 화살표 함수를 쓰면 추가 데이터나 라우팅 처리를 곧바로 연결할 수 있다

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/teaser/page.tsx)
- 버튼 클릭으로 라우터를 통해 페이지 이동
```tsx
<button 
  onClick={() => navigate('/about')}
  className="w-16 h-16 bg-purple-600/20 rounded-full flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform duration-300 cursor-pointer"
>
  <i className="ri-user-heart-line text-purple-400 text-2xl"></i>
</button>
```
- DOM을 직접 건드리지 않아도 클릭 이벤트가 네비게이션으로 이어짐
