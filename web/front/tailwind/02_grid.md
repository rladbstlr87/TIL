## grid
전체 화면을 총 n개로 나누고 요소들을 나눈 칸대로 배치하는 개념
### For examples
#### ex.1-1
```html
grid grid-cols-3
```
![grid-cols](/assets/grid-cols.png)

#### ex.1-2
하나의 요소가 여러 그리드를 차지하도록 지정
```html
grid grid-cols-7
grid-span-1
grid-span-1
grid-span-3
grid-span-2
```
```html
<section class="grid grid-cols-1 bg-green-700 pb-8 px-8 pt-2 mx-2 rounded-md border-4 border-black gap-4">
  <button class="w-fit px-2 py-1 -mb-2 place-self-center flex flex-col justify-center rounded-md bg-green-800 text-xs font-medium text-white ring-1 ring-gray-500/10 ring-inset">
      경기 전<br>예매하기
  </button>
  <div class="grid grid-cols-3 gap-4">
    <div class="h-12 w-fit place-self-center flex flex-col justify-center text-white text-center">
      <span>현대</span>
      <span>유니콘스</span>
    </div>
    <div class="w-fit place-self-center">
      <a href="/game/1234" class="font-black-han text-white font-bold">
        숭의구장
      </a>
      <div class="w-fit place-self-center text-white">
        날씨
      </div>
    </div>
    <div class="h-fit w-fit place-self-center flex justify-center text-white">
      상대팀
    </div>
  </div>
</section>
```
![grid-col](/assets/grid_col.png)
