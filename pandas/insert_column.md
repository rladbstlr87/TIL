# 기존 데이터프레임에 컬럼추가
간단하게는 덮어쓰기 한다는 개념이다

### 기본형식
야구선수의 기존 스탯들을 조합해서 새로운 스탯을 만들어서 저장
```python
import pandas as pd

h = pd.read_csv('data/all_pitcher_stats.csv')

h['power'] = (h['HR']/h['PA'] + h['SLG'] + h['IBB']/h['PA']).round(3)

h.to_csv('data/all_pitcher_stats.csv', index=False)
```
