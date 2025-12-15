# Redux로 확장하는 상태 관리
- 전역 상태가 많아질 때 Redux 같은 상태 관리 라이브러리가 도움을 줌
- store를 만들고 Provider로 앱을 감싸 컴포넌트 어디서든 상태를 읽고 수정
- action과 reducer를 명확히 나눠 예측 가능한 상태 변화를 만든다
- lightbearer/web은 현재 useState와 라우터 파라미터로 상태를 처리하고 있어 Redux가 포함돼 있지 않음

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/artist/[id]/page.tsx)
- 로컬 상태와 URL 파라미터만으로 화면을 구성하는 현재 구조
```tsx
const { id } = useParams()
const [showDropdown, setShowDropdown] = useState('')
const artist = artists.find((a) => a.id === parseInt(id || '1'))
```
- 전역으로 공유할 데이터가 늘어나면 같은 패턴을 Redux store로 옮겨가는 연습을 하면 됨
