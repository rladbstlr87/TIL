-- WHERE vs HAVING

-- WHERE: 그룹화 전, 개별 행을 필터링
-- 2025년 5월 이후의 경기 기록만 선택
SELECT *
FROM hitters_records
WHERE date > 20250501;

-- HAVING: 그룹화 후, 집계된 그룹을 필터링
-- 팀별 평균 타점(RBI)이 40 이상인 팀 조회
SELECT team, AVG(RBI)
FROM all_hitter_stats
GROUP BY team
HAVING AVG(RBI) >= 40;

-- WHERE와 HAVING 함께 사용
-- 100타석(PA) 이상인 선수들 중에서, 팀별 평균 홈런(HR)이 10개 이상인 팀 조회
SELECT team, AVG(HR)
FROM all_hitter_stats
WHERE PA >= 100
GROUP BY team
HAVING AVG(HR) >= 10;

-- 선수별 기록에서 WHERE와 HAVING 사용
-- 4타수(AB) 이상인 경기만 대상으로, 총 안타(H)가 30개 이상인 선수 조회
SELECT player_id, SUM(H)
FROM hitters_records
WHERE AB >= 4
GROUP BY player_id
HAVING SUM(H) >= 30;
