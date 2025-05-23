# 기존 데이터프레임에 컬럼추가
간단하게는 덮어쓰기 한다는 개념이다

## 파생컬럼 생성
야구선수의 기존 스탯들을 조합해서 새로운 스탯을 만들어서 저장
```python
import pandas as pd

h = pd.read_csv('data/all_pitcher_stats.csv')

h['power'] = (h['HR']/h['PA'] + h['SLG'] + h['IBB']/h['PA']).round(3)

h.to_csv('data/all_pitcher_stats.csv', index=False)
```
- `h['power']`라는 컬럼이 기존엔 없더라도 새로 생성됨

## merge
데이터프레임과 데이터프레임을 병합
```
merge_keys = ['선수명', '팀명', 'G']
combined_df = pd.merge(df_basic, df_doru, on=merge_keys, how='left')
```
### 기본구조

```py

```

* 두 개의 DataFrame을 공통 열 또는 인덱스를 기준으로 병합하는 함수
* SQL의 JOIN과 유사하게 key 기준으로 행을 결합하여 새로운 DataFrame 생성

|파라미터|설명|
|---|---|
|**0번째 파라미터**|병합 기준이 되는 왼쪽 DataFrame|
|**1번째 파라미터**|붙이고 싶은 오른쪽 DataFrame|
|**how**|병합 방식 ('left', 'right', 'outer', 'inner')|
|**on**|공통 key로 사용할 열 이름 또는 열 이름 리스트|
|left\_on|왼쪽 DataFrame에서 key로 사용할 열|
|right\_on|오른쪽 DataFrame에서 key로 사용할 열|
|left\_index|왼쪽 인덱스를 key로 사용할지 여부|
|right\_index|오른쪽 인덱스를 key로 사용할지 여부|
|sort|병합 후 결과 정렬 여부|
|suffixes|중복 열 이름 구분용 접미사 튜플|
|copy|병합 시 데이터 복사 여부|
|indicator|병합 결과 원본 표시 열 추가 여부|
|validate|병합 시 key의 일대일 관계 등 유효성 검증 방식 지정|

### For example

#### ex.1-1
ID 컬럼을 기준으로 내부 병합 수행. 공통 ID만 남김
```py
import pandas as pd

df1 = pd.DataFrame({'ID': [1, 2, 3], 'Name': ['Kim', 'Lee', 'Park']})
df2 = pd.DataFrame({'ID': [2, 3, 4], 'Score': [80, 90, 70]})

result = pd.merge(df1, df2, on='ID')
```

#### ex.1-2
df1의 ID 기준으로 병합. 왼쪽 데이터 유지, 오른쪽은 없으면 NaN
```py
result = pd.merge(df1, df2, on='ID', how='left')
```

#### ex.1-3
df1과 df2의 모든 ID 포함. 값이 없으면 NaN으로 채움
```py
result = pd.merge(df1, df2, on='ID', how='outer')
```
