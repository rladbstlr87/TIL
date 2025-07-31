# PostgreSQL Window Functions
## 1. RANK()

### 기본구조
```sql
RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
```

- **Easy definition**: 특정 그룹 내에서 값의 순위를 매김.
- **Exact definition**: `PARTITION BY`로 지정된 그룹 내에서, `ORDER BY`로 정렬된 순서를 기준으로 각 행의 순위 계산. 동일 값은 동일 순위를 받으며, 다음 순위는 동일 순위의 행 수를 더한 값으로 건너뜀. (예: 1, 2, 2, 4)

- **PARTITION BY (Optional)**: 순위를 계산할 그룹 지정.
- **ORDER BY (Required)**: 순위를 매길 기준이 되는 열과 정렬 순서(ASC/DESC) 지정.

### For example
#### ex.1-1 (가장 기본적인 사용법)
- 전체 선수들 중 타율(`avg`)이 높은 순서대로 순위 매김.
```sql
-- 전체 선수 타율 순위
SELECT
    name,
    avg,
    RANK() OVER (ORDER BY avg DESC) as player_rank
FROM cal_hitter;
```

### What it can do?
#### ex.level.2 (그룹별 순위 계산)
- `PARTITION BY`를 사용하여 그룹별로 독립적인 순위 매김 가능. `tothe_ballpark` 프로젝트의 `cal_hitter` 테이블에서 각 팀(`team`)별로 선수들의 타율 순위를 계산하는 예시.
```sql
-- 팀(team)별 타율 순위
SELECT
    team,
    name,
    avg,
    RANK() OVER (PARTITION BY team ORDER BY avg DESC) as team_rank
FROM cal_hitter;
```

#### ex.level.3 (순위 결과에 대한 추가 필터링)
- `RANK()`를 사용한 결과를 서브쿼리나 CTE(Common Table Expression)로 감싸, 계산된 순위를 조건으로 데이터를 필터링하는 복합적인 작업 가능. `tothe_ballpark` 프로젝트에서 팀별 타율 상위 5명만 조회하는 예시.
```sql
-- 팀별 타율 상위 5명 조회
SELECT team, name, avg, team_rank
FROM (
    SELECT
        team,
        name,
        avg,
        RANK() OVER (PARTITION BY team ORDER BY avg DESC) as team_rank
    FROM cal_hitter
) AS ranked_hitters
WHERE team_rank <= 5;
```