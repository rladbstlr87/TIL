# flex

## flex-col
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