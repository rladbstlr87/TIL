# Utility class
## repeat
이미지를 반복시키는 유틸리티 클래스

### 기본 구조
| 클래스명 | 설명 |
|---|---|
| `bg-repeat` | x, y축 모두 반복 (기본값) |
| `bg-no-repeat` | 반복 없음 |
| `bg-repeat-x` | x축으로만 반복 |
| `bg-repeat-y` | y축으로만 반복 |
| `bg-repeat-round` | 크기를 조절하여 반복 |
| `bg-repeat-space` | 간격을 띄워 반복 |

### For examples
#### ex.1-1
y축 방향으로 이미지 반복
```html
<div class="bg-[url('/static/cal/images/bg/peeledpaper1.png')] bg-repeat-y bg-contain w-[50px] translate-x-8 min-h-full rotate-180"></div>
```

## `img` 와 `div` 의 차이

### img
- 컨텐츠 요소 (의미 있는 이미지)
- repeat 등 배경 관련 속성은 적용 불가
- 접근성 고려가 필요한 경우에 적합

### div + background-image
- 스타일 조절 가능 (repeat, position, size 등)
- 배경 패턴, 텍스처에 유리
