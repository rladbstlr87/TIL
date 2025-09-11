# Oracle Optimizer (CBO) 및 실행 계획(Execution Plan) 분석

Oracle은 비용 기반 옵티마이저(CBO)를 사용하여 SQL 실행 계획을 수립합니다. MySQL의 `EXPLAIN`과 유사하게, Oracle에서는 `EXPLAIN PLAN`과 `DBMS_XPLAN` 패키지를 통해 실행 계획을 분석합니다.

## 실행 계획 확인 방법

1.  **`EXPLAIN PLAN FOR`**: SQL 문의 실행 계획을 `PLAN_TABLE`에 저장합니다.
2.  **`SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY)`**: `PLAN_TABLE`에 저장된 가장 최근의 실행 계획을 보기 좋은 형태로 출력합니다.

```sql
-- 1. 실행 계획 생성
EXPLAIN PLAN FOR
SELECT * FROM employees WHERE employee_id = 100;

-- 2. 실행 계획 확인
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

## 실행 계획 주요 항목 해석

MySQL의 `EXPLAIN` 결과와 Oracle의 `DBMS_XPLAN` 출력은 다르지만, 핵심 개념은 유사합니다.

| MySQL `EXPLAIN` | Oracle `DBMS_XPLAN` | 설명 |
| :--- | :--- | :--- |
| `type` | `Operation` + `Access Predicates` | **접근 방식**. `TABLE ACCESS FULL` (MySQL의 `ALL`), `INDEX UNIQUE SCAN` (`const`), `INDEX RANGE SCAN` (`range`), `INDEX FULL SCAN` (`index`) 등 |
| `key` | `Name` (in `Operation` column) | **사용된 인덱스/오브젝트 이름**. `TABLE ACCESS (BY INDEX ROWID)`와 함께 표시되는 인덱스 스캔 작업에서 확인 가능 |
| `rows` | `Rows` (Cardinality) | **처리 예상 건수**. 옵티마이저가 통계 정보에 기반하여 예측한 행의 수. |
| `Extra` | `Predicate Information`, `Note` | **추가 정보**. `filter` (MySQL의 `Using where`), 인덱스 조건 푸시다운, 조인 방식 등의 세부 정보가 표시됨. |

### Operation (접근/조인 방식)

- **TABLE ACCESS FULL**: 테이블 전체를 스캔 (MySQL의 `ALL`). 대용량 테이블에서는 성능 저하의 주범.
- **INDEX UNIQUE SCAN**: UNIQUE 인덱스를 통해 단 하나의 행을 찾음 (MySQL의 `const`). 가장 효율적인 방식.
- **INDEX RANGE SCAN**: 인덱스의 특정 범위를 스캔 (`BETWEEN`, `>`, `<` 등). (MySQL의 `range`).
- **TABLE ACCESS BY INDEX ROWID**: 인덱스 스캔 후 `ROWID`를 이용해 테이블의 실제 행을 찾아감. 인덱스에 없는 컬럼을 조회할 때 발생.
- **HASH JOIN**, **NESTED LOOPS**, **MERGE JOIN**: 테이블 조인 방식.

### Predicate Information (필터 조건)

- **access(...)**: 인덱스를 사용하여 데이터를 찾는 데 사용된 조건.
- **filter(...)**: 인덱스 스캔 후, 메모리에서 추가로 필터링하는 데 사용된 조건 (MySQL의 `Using where`와 유사).

### 개선 포인트

- `TABLE ACCESS FULL`이 보이면 인덱스 생성을 최우선으로 고려합니다.
- `Rows` (Cardinality) 예측치가 실제와 크게 다르면 통계 정보가 오래되었을 수 있으므로, `DBMS_STATS` 패키지로 통계를 재생성하는 것을 고려합니다.
- 불필요한 `TABLE ACCESS BY INDEX ROWID`가 발생하면, 조회하는 모든 컬럼을 포함하는 커버링 인덱스(Covering Index)를 고려해볼 수 있습니다.
