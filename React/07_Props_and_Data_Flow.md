# Props와 데이터 흐름
- 데이터는 부모에서 자식으로 단방향으로 내려보내는 것이 기본
- 라우터가 전달하는 URL 파라미터도 컴포넌트가 받아와서 화면에 쓴다
- 받은 데이터로 화면을 그리되 원본을 직접 mutate하지 않는다

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/artist/[id]/page.tsx)
- URL의 id를 읽어 알맞은 아티스트 데이터를 찾은 뒤 렌더링
```tsx
const { id } = useParams()
...
const artist = artists.find((a) => a.id === parseInt(id || '1'))

if (!artist) {
  return (
    <div className="min-h-screen bg-black text-white flex items-center justify-center">
      ...
    </div>
  )
}
...
<h1 className="text-4xl font-bold mb-4">{artist.name}</h1>
```
- 데이터가 위에서 아래로 흐르기 때문에 다른 화면과 충돌 없이 안전하게 표시된다
