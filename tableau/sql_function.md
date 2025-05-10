#SQL과 이름이 겹치는 함수
여기서는 기본적으로 Tableau에서의 의미에 가중치를 둔다
## IIF
조건의 결과가 TRUE, FALSE, NULL 중 어떤 것인지에 따라 반환 값을 다르게 지정할 수 있는 **삼항 조건 함수**
### 기본구조
NULL일때의 결과는 필수 파라미터 아님
```sql
IIF(조건, 참의 결과, 거짓의 결과, [NULL일때 결과])
```
### For example
#### ex.1-1
```sql
IIF([순수익] > 0, "흑자", "적자")
```
#### ex.1-2
NULL처리의 경우
```sql
IIF([순수익] > 0, "흑자", "적자", "No Data")
```
#### ex.1-3
```sql
IIF(ISNULL(월급), 0, [월급])
```
### What it can do?
#### ex.level.2(2단계 예시)
- ('이런것도할수있다' 수준에 대한 예시 부분)
```sql
IIF(Gender = 'M', 'Mr. ' + Name, 'Ms. ' + Name)
```