ANSI 표준 조인 (Standard Joins)

- SQL 표준(ANSI)에서 정의한 조인 문법
- 가독성이 높고, 조인 조건을 명확하게 표현 가능

INNER JOIN
- 두 테이블에 공통으로 존재하는 데이터만 연결
- 조인 조건에 일치하는 행만 결과에 포함
```sql
SELECT * FROM TableA INNER JOIN TableB ON TableA.id = TableB.id;
```

OUTER JOIN
- 조인 조건에 일치하지 않는 행도 결과에 포함
- LEFT OUTER JOIN: 왼쪽 테이블의 모든 행을 포함
```sql
SELECT * FROM TableA LEFT OUTER JOIN TableB ON TableA.id = TableB.id;
```
- RIGHT OUTER JOIN: 오른쪽 테이블의 모든 행을 포함
```sql
SELECT * FROM TableA RIGHT OUTER JOIN TableB ON TableA.id = TableB.id;
```
- FULL OUTER JOIN: 양쪽 테이블의 모든 행을 포함
```sql
SELECT * FROM TableA FULL OUTER JOIN TableB ON TableA.id = TableB.id;
```

CROSS JOIN
- 두 테이블의 모든 가능한 행의 조합을 생성 (카티전 곱)
- 조인 조건이 없음
```sql
SELECT * FROM TableA CROSS JOIN TableB;
```

NATURAL JOIN
- 두 테이블에서 이름과 데이터 타입이 같은 모든 컬럼을 기준으로 자동으로 조인
- 조인 조건을 명시적으로 작성하지 않음
- 예상치 못한 컬럼이 조인 조건으로 사용될 수 있어 주의가 필요
```sql
SELECT * FROM TableA NATURAL JOIN TableB;
```
