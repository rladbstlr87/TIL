-- 다중 컬럼 서브쿼리 (Multi-column Subquery)
-- 서브쿼리가 여러 컬럼을 반환하여 메인 쿼리와 여러 컬럼을 동시에 비교

-- 예제 1: WHERE 절에서 다중 컬럼 비교
-- 각 팀에서 가장 많은 홈런을 친 선수 조회
-- WHERE 절에서 (team, HR) 컬럼 쌍을 서브쿼리 결과와 비교
SELECT
    team,
    player_name,
    HR
FROM
    all_hitter_stats
WHERE
    (team, HR) IN (
        -- 서브쿼리: 팀별 최대 홈런(HR) 수를 계산하여 (팀, 최대 홈런) 쌍 반환
        SELECT
            team,
            MAX(HR)
        FROM
            all_hitter_stats
        GROUP BY
            team
    )
ORDER BY
    team, player_name;

-- 예제 2: FROM 절에서 다중 컬럼 서브쿼리 사용 (WITH 절 활용)
-- 각 팀의 최고 타율 타자와 최저 평균자책점 투수를 한 줄에 조회
WITH best_hitters AS (
    -- 팀별 최고 타율 타자 정보 (규정타석 이상)
    SELECT
        team,
        player_name,
        AVG
    FROM all_hitter_stats
    WHERE (team, AVG) IN (
        SELECT team, MAX(AVG)
        FROM all_hitter_stats
        WHERE PA >= 144
        GROUP BY team
    )
),
best_pitchers AS (
    -- 팀별 최저 평균자책점 투수 정보 (규정이닝 이상)
    SELECT
        team,
        player_name,
        ERA
    FROM all_pitcher_stats
    WHERE (team, ERA) IN (
        SELECT team, MIN(ERA)
        FROM all_pitcher_stats
        WHERE IP >= 100
        GROUP BY team
    )
)
-- 두 CTE를 조인하여 최종 결과 출력
SELECT
    h.team,
    h.player_name AS best_hitter,
    h.AVG AS max_avg,
    p.player_name AS best_pitcher,
    p.ERA AS min_era
FROM best_hitters h
JOIN best_pitchers p ON h.team = p.team
ORDER BY h.team;