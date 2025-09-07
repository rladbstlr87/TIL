MySQL `EXPLAIN` 기준(key → rows → type → Extra)

## key

- 옵티마이저가 실제 사용하기로 선택한 인덱스 이름
- `NULL`이면 인덱스 미사용(대개 `type=ALL`/전표 스캔)
- 후보는 `possible_keys`에 보이며, 실제 채택은 `key`에 표시

## rows

- 옵티마이저가 검사해야 한다고 추정하는 행 수(카디널리티·통계 기반 추정치)
- 작을수록 유리, 조인일 때는 선행 테이블 추정치가 후행 테이블로 곱으로 전파됨

## type (접근/조인 방식: 성능 핵심)

(성능 좋음)`const` ≈ `system` > `eq_ref` > `ref` > `range` > `index` > `ALL`(나쁨)

- const

  - 의미: 인덱스(주로 PK/UNIQUE)로 단 한 행이 확정되는 경우
  - 예: `WHERE pk = ?` (PK 혹은 UNIQUE NOT NULL)
  - 특징: 테이블을 상수처럼 취급, 가장 빠른 축에 속함

- ref

  - 의미: 인덱스 동등 조건이지만 다수 행 가능(비고유 인덱스)
  - 예: `WHERE idx_col = ?` (NON-UNIQUE INDEX)
  - 특징: 선택도에 따라 성능 차이 큼(카디널리티가 높을수록 유리)

- range

  - 의미: 범위 조건으로 인덱스 구간 스캔
  - 예: `BETWEEN`, `>`, `<`, `>=`, `<=`, `IN (...)`(값 집합이 클 때)
  - 특징: 필요한 구간만 읽어 효율적이지만 범위가 넓으면 I/O 증가

- index

  - 의미: 인덱스 전체를 스캔(커버링이면 테이블 접근 없음)
  - 예: 조건이 없어 인덱스 순서대로 읽기, 또는 조건이 인덱스에 못 얹힘
  - 특징: 테이블 풀스캔보다는 나을 수 있으나(인덱스 페이지가 더 작음) 여전히 광범위

- ALL

  - 의미: 테이블 전체 스캔(인덱스 미사용)
  - 예: 조건이 인덱스를 못 타거나 인덱스가 아예 없음
  - 특징: 가장 느림. 대량 테이블에서 병목

### 개선 포인트

- `ALL`/`index` → 적절한 단일/복합 인덱스로 `range`/`ref`/`const`로 끌어올리기
- `ref` 선택도가 낮으면(매칭 행이 너무 많으면) 복합 인덱스 선두 열 재설계

## Extra
추가 실행 힌트

- Using index: 커버링 인덱스(테이블 접근 없이 인덱스만으로 컬럼 해결) → 좋음
- Using where: 인덱스로 1차 후보를 좁힌 뒤 필터 추가 적용 → 보통
- Using index condition: ICP(Index Condition Pushdown) 적용 → 좋음
- Using temporary: 임시 테이블 필요(대개 `GROUP BY`, 복잡한 `DISTINCT`) → 비용↑
- Using filesort: 인덱스로 정렬 불가, 별도 정렬 단계 수행 → 비용↑
- Range checked for each record: 고정 계획 실패, 행마다 인덱스 평가 → 비용↑
- Using join buffer(Block Nested Loop): 조인에 버퍼 사용 → 인덱스 조인 최적화 여지 있는 상태