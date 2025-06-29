## CSS - overflow
- 요소의 콘텐츠가 박스 크기를 초과할 경우, 초과된 부분을 어떻게 처리할지를 결정하는 속성
- `overflow: hidden`은 콘텐츠가 보이지 않지만 존재함 → 마우스 접근/스크립트 접근 가능
- `overflow`는 block-level 요소에 적용할 때 의미 있음
- 자식 요소에 `position: absolute`가 있고, 부모에 `overflow: hidden`이 있으면 잘려서 안 보일 수 있음

### 기본 구조
`|`는 `or`이라고 보면 된다
#### in css
```css
overflow: visible | hidden | scroll | auto;
```
#### in tailwind
| 값 | 설명 |
| --- | --- |
| `overflow-visible` | (기본값) 넘친 콘텐츠를 그대로 표시함 요소 바깥까지 표시됨 |
| `overflow-hidden` | 넘친 콘텐츠를 잘라내며, 스크롤 없음 |
| `overflow-scroll` | 콘텐츠가 넘치든 말든 항상 스크롤바 표시 |
| `overflow-auto` | 콘텐츠가 넘칠 때만 스크롤바 표시, 넘치지 않으면 없음 |

### For examples
#### ex.1-1
```html
<div style="width: 100px; height: 50px; overflow: visible;">
  qwer 눈물참기 신곡 좋더라ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ
</div>
```

#### ex.1-2
x축과 y축 분리 설정
```css
.container {
  width: 200px;
  height: 100px;
  overflow-x: scroll;
  overflow-y: hidden;
}
```
#### ex.1-3 

### What it can do?

#### ex.2
스크롤 있는 카드 UI
```html
<div style="width: 300px; height: 200px; overflow: auto; border: 1px solid #ccc;">
  <p>qwer 눈물참기 신곡 좋더라ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ</p>
</div>
```