# Tailwind
CSS파일이 거의 필요없이 유틸리티 클래스를 엄청 많이 모아놓은 NoCSS 라이브러리. 부트스트랩보다 유틸리티 클래스가 더 많은걸로 알려져 있다.
## Utility class
자주 쓰는 클래스를 변수화 시켜서 쓰는 개념. 예시를 한 번 보고 
```
.m-1 { margin-top : 10px }
.m-2 { margin-top : 20px }
.m-3 { margin-top : 30px }
.m-4 { margin-top : 40px }

<p class="m-3">우헤헤</p>
```

## tip
[핑거](https://fingr.io/) 라고 서버 구동 필요없이 웹 브라우저에서 HTML/Tailwind가 어떻게 보이는지 확인하면서 작성할 수 있는 에디터 서비스가 있다. 매번 고치고 저장하고 새로고침할 필요 없음

## 주요 클래스
### MP/bg
```html
<div class="p-4 bg-blue-100">
  MP는 Margin padding의 약자이지 않을까
</div>
<div class="py-4 bg-orange-100">
  y축으로만 4번 패딩 적용
</div>
<div class="px-4 bg-green-100">
  x축으로만 4번 패딩 적용
</div>
```
![padding](/assets/padding.png)
```html
<div class="m-4 bg-blue-100">
  이번엔 마진
</div>
<div class="m-12 bg-orange-100">
  '-숫자'는 테일윈드만의 클래스
</div>
<div class="mx-4 bg-green-100">
  마진 x축
</div>
<div class="my-4 bg-red-100">
  마진 y축
</div>
```
![margin](/assets/margin.png)
### WH
```html
<div class="w-4 bg-blue-100">
  w는 width
</div>
<div class="w-12 bg-orange-100">
  가로로 제한하는 박스를 만드는 느낌
</div>
<div class="w-full bg-green-100">
  전체
</div>
<div class="w-screen bg-green-100">
  스크린 크기만큼. 이거 반응형에 좀 좋을지도
</div>
```
![width](/assets/width.png)

### boder/shadow/text
```html
<div class="m-4 border border-green-500 text-xl">
  보더는 테두리
</div>
<div class="m-4 border border-green-200 text-m shadow-xl text-green-500">
  쉐도우 고급짐
</div>
```
![border](/assets/border.png)

### flex
보통 양 끝으로 간격 둘 때, 쓴다고 함
```html
<div class="flex justify-between">
  <div class="m-4 border border-green-500 text-xl">
    Tailwind
  </div>
  <div class="m-4 border border-green-200 text-m shadow-xl text-green-500">
    Tailwind
  </div>
</div>
<div class="flex justify-between">
  <div class="m-4 border border-green-500 text-xl">
    Tailwind
  </div>
  <div class="m-4 border border-green-200 text-m shadow-xl text-green-500">
    Tailwind
  </div>
</div>
<div class="flex justify-between items-center h-screen">
  <div class="p-4 border text-xl text-center">
    Tailwind
  </div>
  <div class="p-4 border text-m shadow-xl text-green-500">
    Tailwind
  </div>
</div>
```
![flex](/assets/flex.png)
```html
<div class="m-4 flex justify-center ">
  <div class="p-4 border text-xl text-center">
    Tailwind
  </div>
  <div class="p-4 border rounded-xl text-m shadow-xl text-green-500">
    Tailwind
  </div>
</div>
<div class="m-4 flex gap-4 justify-center ">
  <div class="p-4 border text-xl text-center">
    Tailwind
  </div>
  <div class="p-4 border rounded-xl text-m shadow-xl text-green-500">
    Tailwind
  </div>
</div>
```
![flex](/assets/flex-rounded.png)
### grid/font
```html
<div class="grid grid-cols-3 gap-3 text-center font-black">
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="bg-green-500 text-white p-4 border rounded-full">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="bg-green-900 text-white p-4 border rounded-tr-xl">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="p-4 border">
    Tailwind
  </div>
</div>
```
![grid](/assets/grid.png)
### position
fixed는 상위요소의 relative에 영향을 받지 않는다는 점이 absolute와 차이가 있다. 나머지 역할은 같음
```html
<div class="grid grid-cols-3 gap-3 text-center font-black">
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="bg-green-500 text-white p-4 border rounded-full absolute bottom-0 right-0">
    Tailwind
  </div>
...
```
![absolute](/assets/absolute.png)

relative
```html
<div class="grid grid-cols-3 gap-3 text-center font-black relative">
  <div class="p-4 border">
    Tailwind
  </div>
  <div class="bg-green-500 text-white p-4 border rounded-full absolute bottom-0 right-0">
    Tailwind
  </div>
...
```
![relative](/assets/relative.png)

### display
inline
```html
<div class="gap-3 text-center font-black">
  <div class="p-4 border">
    Tailwind
  </div>
</div>
<div class="gap-3 text-center font-black">
  <div class="p-4 border inline">
    Tailwind
  </div>
</div>
```
![inline](/assets/inline.png)