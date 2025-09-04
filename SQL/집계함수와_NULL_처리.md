## 집계 함수와 NULL 처리

| 함수 | NULL 처리 | 모두 NULL 또는 행 없음일 때 |
| --- | --- | --- |
| COUNT(*) | 모든 행 포함 | 0 |
| COUNT(col) | NULL 제외 | 0 |
| COUNT(DISTINCT col) | NULL 제외 | 0 |
| SUM(col) | NULL 제외 | NULL |
| AVG(col) | NULL 제외 | NULL |
| MIN(col) | NULL 제외 | NULL |
| MAX(col) | NULL 제외 | NULL |

### COUNT

- COUNT(*)는 행 수를 그대로 반환
- COUNT(col)은 값이 있는 행만 집계
- COUNT(DISTINCT col)은 중복과 NULL을 제외하고 고유 값 수를 반환

### SUM

- NULL은 합산에서 제외
- 모든 값이 NULL이면 결과는 NULL

### AVG

- NULL을 제외한 값들의 평균을 반환
- 항상 AVG(col) = SUM(col) / COUNT(col) 등식이 성립

### MIN MAX

- NULL을 제외한 값들 중 최소값과 최대값을 반환

## AVG와 SUM/COUNT 차이

### AVG = SUM/COUNT(col) 등식

- 분모가 COUNT(col)이므로 NULL 행은 분모에서 제외
- 값이 하나도 없으면 결과는 NULL

### SUM/COUNT(*)가 다른 값을 내는 조건

- COUNT(*)는 NULL 행까지 모두 포함
- 데이터에 NULL이 섞여 있으면 SUM(col) / COUNT(*)는 평균이 작아질 수 있음

### 정수 나눗셈 캐스팅 주의

- PostgreSQL에서 정수/정수는 정수로 계산될 수 있음
- MySQL에서 `/`는 실수 나눗셈이며 `DIV`는 정수 나눗셈

## 안전한 표현식 예시

### PostgreSQL

```sql
-- 표준 평균
SELECT AVG(total_bill) FROM sales;

-- 등식 형태
SELECT SUM(total_bill)::numeric / NULLIF(COUNT(total_bill), 0) FROM sales;

-- 정수 나눗셈 방지용 캐스팅
SELECT SUM(total_bill)::numeric / NULLIF(COUNT(total_bill), 0)::numeric FROM sales;

-- NULL을 0으로 간주한 평균 해석 주의
SELECT SUM(COALESCE(total_bill, 0))::numeric / NULLIF(COUNT(*), 0) FROM sales;

```

### MySQL

```sql
-- 표준 평균
SELECT AVG(total_bill) FROM sales;

-- 등식 형태
SELECT SUM(total_bill) / NULLIF(COUNT(total_bill), 0) FROM sales;

-- NULL을 0으로 간주한 평균 해석 주의
SELECT SUM(COALESCE(total_bill, 0)) / NULLIF(COUNT(*), 0) FROM sales;

```