-- ROLLUP: 계층적 집계를 출력
-- 팀별, 스타일별 홈런 합계와 각 팀의 소계, 그리고 전체 총계를 계산
-- (team, style) -> (team) -> () 순서로 집계
SELECT
    IF(GROUPING(team), '리그 전체', team) AS team,
    IF(GROUPING(style), '팀 합계', style) AS style,
    SUM(HR) AS total_hr
FROM all_hitter_stats
WHERE PA > 0
GROUP BY team, style WITH ROLLUP;

-- CUBE: 모든 가능한 조합의 집계를 출력
-- (team, style), (team), (style), () 모든 조합에 대한 홈런 합계를 계산
SELECT
    IF(GROUPING(team), '전체 팀', team) AS team,
    IF(GROUPING(style), '전체 스타일', style) AS style,
    SUM(HR) AS total_hr
FROM all_hitter_stats
WHERE PA > 0
GROUP BY team, style WITH CUBE;

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
