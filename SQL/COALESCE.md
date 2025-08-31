# SQL 함수

## 1. COALESCE
여러 개가 하나로 합쳐지다, 융합하다, 결합하다 라는 뜻

### 기본구조
```sql
COALESCE(expr1, expr2, expr3, ...)
````

- 여러 표현식 중에서 NULL이 아닌 첫 번째 값을 반환
- 모든 표현식이 NULL이면 마지막 값을 반환
- expr1: 첫 번째 확인 값
- expr2: expr1이 NULL일 경우 반환할 값
- expr3: expr1, expr2가 모두 NULL일 경우 반환할 값

### For examples

#### ex.1-1

```sql
SELECT COALESCE(NULL, '대체값');
-- 결과: '대체값'
```

#### ex.1-2

```sql
SELECT COALESCE(NULL, 'A', 'B');
-- 결과: 'A'
```

#### ex.1-3

```sql
SELECT COALESCE(NULL, NULL, '최종값');
-- 결과: '최종값'
```

### What it can do?

#### ex.level.2

- 다수 컬럼 중 하나라도 값이 존재하면 우선적으로 반환 가능

```sql
SELECT COALESCE(nickname, username, '알수없음') AS display_name
FROM accounts;
```

#### ex.level.3

- 조인 시 NULL 발생을 방지하며 다른 테이블의 값으로 대체 가능

```sql
SELECT COALESCE(p.player_name, h.player_name) AS player_name
FROM cal_lineup l
LEFT JOIN cal_pitcher p ON l.pitcher_id = p.player_id
LEFT JOIN cal_hitter h ON l.hitter_id = h.player_id;
```