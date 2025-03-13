# bisect
- 배열 이진 분할 알고리즘
- **정렬된** 리스트에서 이진탐색을 통해 값을 삽입하거나 검색하는 기능이 있다.
- 리스트의 정렬 상태를 유지하면서 효율적으로 작동시킬 수 있다.
`import bisect' 해야함.

## 주요함수
### bisect_right()
```py
import bisect

array = [149, 180, 192, 170]
height = 167	
array.sort()
array # [149, 170, 180, 192]
```
일때,
```py
bisect.bisect_right(array, height)
# 1 : height가 위치하게된 인덱스 번호

index = bisect.bisect_right(array, height)
len(array) - index
# 결과는 bisect를 기준점으로 기준점보다 큰 값들의 갯수를 셀 수 있게 된다
```
