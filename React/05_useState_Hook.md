# useState Hook
- 컴포넌트 안에서 상태 값과 세터 함수를 한 쌍으로 만든다
- 초기값을 전달하고 세터를 호출할 때마다 컴포넌트가 다시 렌더링된다
- 문자열, 숫자, 객체, Set 등 어떤 값도 담을 수 있다

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/about/page.tsx)
- 드롭다운 메뉴 이름을 상태로 두고 열고 닫기를 토글
```tsx
const [showDropdown, setShowDropdown] = useState('')

const handleDropdown = (menu) => {
  setShowDropdown(showDropdown === menu ? '' : menu)
}
```
- 상태만 바꿔도 열림/닫힘 UI가 자동으로 갱신됨
