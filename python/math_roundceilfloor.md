# math
- 파이썬에서 수학개념 메소드를 불러오는 라이브러리
```py
import math
math.{method}(int)
```
## 1. ceil / floor / round
- ceil: 올림
- floor: 내림
- round: 반올림. math 안불러와도 사용 가능

### 기본구조
```py
math.ceil(3.14)
# 4
```

### For example
#### ex.1-1
```py
distance = 2.675
print(round(distance, 2))
# 소수점 두 자리를 반올림하여 2.68
```

### What can it do?
#### ex.level.2
- 나눠먹을 피자의 판수 계산하는 함수 만들기
```py
import math
p = 조각수
def solution(p):
    return math.ceil(n/p)
```