# 가상 DOM과 리스트 렌더링
- React는 메모리 가상 DOM을 만든 뒤 실제 DOM과 diff해 필요한 부분만 패치
- 상태를 선언형으로 바꾸면 React가 최소 DOM 조작으로 화면을 맞춤
- 리스트 렌더링 시 key가 있어야 어떤 항목이 바뀌었는지 빠르게 비교 가능
- Reconciliation 단계: 상태 변경 -> 가상 DOM 생성 -> Diff -> 실제 DOM 패치
- 예시 흐름: state.value가 A에서 B로 바뀌면 h1의 텍스트 노드만 교체해 비용 절약

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/teaser/page.tsx)
- artists 배열을 map으로 돌며 카드 컴포넌트를 렌더링하고 key로 식별
```tsx
{artists.map((artist, index) => (
  <div 
    key={artist.id}
    onClick={() => navigate(`/artist/${artist.id}`)}
    className="group relative bg-gray-900/20 rounded-3xl overflow-hidden border border-gray-800/50 hover:border-purple-600/50 transition-all duration-500 cursor-pointer backdrop-blur-sm hover:scale-105 hover:shadow-2xl hover:shadow-purple-500/20"
    style={{ animationDelay: `${index * 0.2}s` }}
  >
    <div className="absolute top-4 left-4 z-20">
      <div className="text-white px-6 py-3 rounded-full text-2xl font-bold border border-white/20">
        Rank {artist.rank}
      </div>
    </div>
  </div>
))}
```
- key 덕분에 가상 DOM이 변경된 카드만 정확히 찾아 다시 그림  
- 파일 바로가기: [page.tsx](../../lightbearer/web/src/pages/teaser/page.tsx)

## 개념 요약
- 가상 DOM: 실제 DOM을 모방한 가벼운 JS 객체 트리
- Diffing: 이전 가상 DOM과 새 가상 DOM을 비교해 달라진 노드만 찾음
- 일괄 패치: 필요한 부분만 한 번에 실제 DOM에 적용해 렌더 비용 절감
