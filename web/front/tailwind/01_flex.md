## flex
요소를 flex container로 설정하여 자식 요소들을 유연하게 배치할 수 있게 함

- `flex`는 `display: flex`를 적용
- `inline-flex`는 `display: inline-flex`를 적용

### 기본 구조
```html
<div class="flex">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

## 관련 유틸리티 클래스

| 클래스명                | 설명                   |
| ------------------- | -------------------- |
| `flex`              | display: flex        |
| `inline-flex`       | display: inline-flex |
| `flex-row`          | 주 축을 가로 방향으로 설정 (기본) |
| `flex-row-reverse`  | 주 축 반전 (가로)          |
| `flex-col`          | 주 축을 세로 방향으로 설정      |
| `flex-col-reverse`  | 주 축 반전 (세로)          |
| `flex-wrap`         | 자식 요소 줄 바꿈 허용        |
| `flex-nowrap`       | 줄 바꿈 금지 (기본)         |
| `flex-wrap-reverse` | 줄 바꿈 반대 방향           |

## 파라미터 설명 (자식 요소에 적용)

| 클래스명           | 설명                  |
| -------------- | ------------------- |
| `flex-1`       | 남은 공간을 모두 차지        |
| `flex-auto`    | content 크기 기준 자동 크기 |
| `flex-initial` | 기본 크기 유지            |
| `flex-none`    | 크기 고정               |

---

## 예시

### 1단계: 기본적인 사용 예시

#### ex.1-1: flex-row
```html
<div class="flex flex-row gap-2">
  <div class="bg-red-200 p-4">01</div>
  <div class="bg-red-300 p-4">02</div>
  <div class="bg-red-400 p-4">03</div>
  <div class="bg-red-500 p-4">04</div>
</div>
```
![flex-row](/assets/flex-rounded.png)

#### ex.1-2: flex-col

```html
<div class="flex flex-col gap-2">
  <div class="bg-green-200 p-4">01</div>
  <div class="bg-green-300 p-4">02</div>
  <div class="bg-green-400 p-4">03</div>
  <div class="bg-green-500 p-4">04</div>
</div>
```
![flex-col](/assets/flex-col.png)

#### ex.1-3: flex-wrap(너비 지정)

```html
<div class="flex flex-wrap gap-2">
  <div class="bg-blue-200 p-4 w-1/2">01</div>
  <div class="bg-blue-300 p-4 w-1/2">02</div>
  <div class="bg-blue-400 p-4 w-1/2">03</div>
  <div class="bg-blue-500 p-4 w-1/2">04</div>
</div>
```
![flex-wrap](/assets/flex-wrap.png)

### 2단계: 실전에서 유용한 응용 예시

#### ex.level.2: sidebar + content layout

```html
<div class="flex min-h-screen">
  <aside class="w-64 bg-gray-100">Sidebar</aside>
  <main class="flex-1 bg-white">Main Content</main>
</div>
```

### 3단계: 고급 활용 예시

#### ex.level.3: 중첩 flex 레이아웃

```html
<div class="flex flex-col h-screen">
  <header class="h-16 bg-blue-500">Header</header>
  <div class="flex flex-1">
    <aside class="w-64 bg-gray-200">Sidebar</aside>
    <main class="flex-1 bg-white">Content</main>
  </div>
</div>
```



## flex-col 주의사항
- flex items-center는 기본적으로 한 줄 텍스트 또는 단일 라인 콘텐츠를 가운데 정렬할 때 잘 작동한다.
- 그런데 <br>로 줄을 나누면 내부 콘텐츠가 다단 라인이 되어 가운데 정렬이 깨진다
```html
<span class="w-fit place-self-center flex items-center
    rounded-md bg-green-800 px-2 py-1 text-xs font-medium text-white
    ring-1 ring-gray-500/10 ring-inset">
    경기 전<br>예매하기
</span>
```
![br_broken](/assets/br_broken.png)
- 그래서 아예 내부 span을 하나 더 만들고 flex-col을 사용
```html
<span class="w-fit place-self-center flex flex-col items-center
    rounded-md bg-green-800 px-2 py-1 text-xs font-medium text-white
    ring-1 ring-gray-500/10 ring-inset">
  경기 전
  <span>예매하기</span>
</span>
```
![flex-col](/assets/flex-col.png)