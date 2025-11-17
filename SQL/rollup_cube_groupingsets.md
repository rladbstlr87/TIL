# ROLLUP, CUBE, GROUPING SETS

## ROLLUP

`ROLLUP`은 계층적인 집계 결과 생성. 지정된 그룹화 열의 소계와 총계를 계산하는 데 사용. 예를 들어, `GROUP BY team, style WITH ROLLUP`은 `(team, style)`별 집계, `(team)`별 소계, 그리고 전체 총계를 순서대로 반환.

### 쿼리

```sql
-- ROLLUP: 계층적 집계를 출력
-- 팀별, 스타일별 홈런 합계와 각 팀의 소계, 그리고 전체 총계를 계산

SELECT
    IF(GROUPING(team), '리그 전체', team) AS team,
    IF(GROUPING(style), '팀 합계', style) AS style,
    SUM(HR) AS total_hr
FROM all_hitter_stats
WHERE PA > 0
GROUP BY team, style WITH ROLLUP;
```

### 결과
(team, style) -> (team) -> () 순서로 집계
| team      | style   | total_hr |
| :-------- | :------ | :------- |
| Lions     | Power   | 50       |
| Lions     | Contact | 30       |
| Lions     | 팀 합계 | 80       |
| Tigers    | Power   | 45       |
| Tigers    | Contact | 35       |
| Tigers    | 팀 합계 | 80       |
| 리그 전체 | 팀 합계 | 160      |

---

## CUBE

`CUBE`는 지정된 열의 모든 가능한 조합에 대한 집계 결과 생성. `ROLLUP`이 계층적인 소계를 제공하는 반면, `CUBE`는 모든 차원의 조합에 대한 집계를 반환하여 더 포괄적인 분석 가능.

### 쿼리

```sql
-- CUBE: 모든 가능한 조합의 집계를 출력
SELECT
    IF(GROUPING(team), '전체 팀', team) AS team,
    IF(GROUPING(style), '전체 스타일', style) AS style,
    SUM(HR) AS total_hr
FROM all_hitter_stats
WHERE PA > 0
GROUP BY team, style WITH CUBE;
```

### 결과
(team, style), (team), (style), () 모든 조합에 대한 홈런 합계를 계산
| team    | style       | total_hr |
| :------ | :---------- | :------- |
| Lions   | Power       | 50       |
| Lions   | Contact     | 30       |
| Lions   | 전체 스타일 | 80       |
| Tigers  | Power       | 45       |
| Tigers  | Contact     | 35       |
| Tigers  | 전체 스타일 | 80       |
| 전체 팀 | Power       | 95       |
| 전체 팀 | Contact     | 65       |
| 전체 팀 | 전체 스타일 | 160      |

---

## GROUPING SETS

`GROUPING SETS`는 사용자가 명시적으로 지정한 그룹화 조합에 대해서만 집계 결과를 계산. `ROLLUP`이나 `CUBE`와 달리, 필요 없는 집계 조합을 제외하고 원하는 결과만 선택적으로 볼 수 있어 유연성이 높음

### 쿼리

```sql
-- GROUPING SETS: 원하는 집계 조합만 명시적으로 선택
-- 팀별 합계와 스타일별 합계만 각각 계산
SELECT
    team,
    style,
    SUM(HR) AS total_hr
FROM all_hitter_stats
WHERE PA > 0
GROUP BY GROUPING SETS(
    (team),
    (style)
);
```

### 결과

| team   | style   | total_hr |
| :----- | :------ | :------- |
| Lions  | NULL    | 80       |
| Tigers | NULL    | 80       |
| NULL   | Power   | 95       |
| NULL   | Contact | 65       |
