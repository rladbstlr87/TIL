# 04 선언형 UI와 상태
- UI를 직접 조작하기보다 상태를 선언하면 React가 렌더링을 알아서 맞춤
- 상태가 바뀌면 관련된 부분만 다시 그려져서 코드가 단순해짐
- IntersectionObserver처럼 사이드 이펙트는 useEffect 안에서 처리

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/home/page.tsx)
- 화면에 보이는 요소 집합을 상태로 관리해 애니메이션 클래스를 토글
```tsx
const [visibleElements, setVisibleElements] = useState(() => new Set())

useEffect(() => {
  if (typeof IntersectionObserver === 'undefined') {
    console.warn('IntersectionObserver is not supported in this environment.')
    return
  }

  let observer
  try {
    observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        const id = entry.target.id
        if (!id) return
        if (entry.isIntersecting) {
          setVisibleElements((prev) => {
            const next = new Set(prev)
            next.add(id)
            return next
          })
        } else {
          setVisibleElements((prev) => {
            const next = new Set(prev)
            next.delete(id)
            return next
          })
        }
      })
    }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' })
  } catch (err) {
    console.error('Failed to create IntersectionObserver:', err)
    return
  }

  const elements = document.querySelectorAll('[data-animate]')
  elements.forEach((el) => observer.observe(el))
  return () => observer.disconnect()
}, [])
```
- visibleElements 상태만 바꾸면 JSX의 className이 자동으로 갱신돼 스크롤 애니메이션이 동작함
