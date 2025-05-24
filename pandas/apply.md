# DataFrame Methods
## apply
### 기본구조
```
df.apply(func)
```
- df의 각 row 혹은 column에 일괄 함수 적용. 디폴트는 column단위 적용
- 행단위 적용하고 싶으면 파라미터로 `axis=1` 추가
    - 주로 여러 컬럼을 조합해 새로운 값을 만들 때 사용
### For exanples
#### ex.1-1
`20 1/3`같은 문자열 타입으로 이루어진 컬럼을 모두 float 타입으로 변경
```
def parsing_0(value):
    try:
        if isinstance(value, str) and ' ' in value:
            whole, frac = value.split()
            num, denom = frac.split('/')
            return float(whole) + float(num) / float(denom)
        elif isinstance(value, str) and '/' in value:
            num, denom = value.split('/')
            return float(num) / float(denom)
        else:
            return float(value)
    except:
        return None

p['IP'] = p['IP'].apply(parsing_0).round(3)

# 결과 : 20.334
```
이 경우 함수를 사용한다고 `p['IP'] = parsing_0(p['IP'])`라고 Series를 그대로 넘기면 함수 내부에서 문자열 분할이 불가능하여 예외 발생 → None 반환

#### ex.1-2
컬럼 조합
```
def calc_contact(row, max_pa):
    return round(
        row['AVG'] * 0.45
        + (1 - row['SO'] / row['PA']) * 0.2
        + row['OBP'] * 0.2
        + (1 - row['GDP'] / row['PA']) * 0.1
        + row['PA'] / max_pa * 0.05,
        3
    )

max_pa = h['PA'].max()
h['contact'] = h.apply(lambda row: calc_contact(row, max_pa), axis=1)
```