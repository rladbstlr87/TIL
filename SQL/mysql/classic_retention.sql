-- KBO hitters_records 데이터를 사용한 클래식 리텐션(Classic Retention) 분석
-- 선수들의 첫 경기 출전일을 코호트 기준으로 하여, 시간 경과에 따른 잔존율을 계산합니다.

-- 1. 선수별 첫 활동일(코호트 기준일)을 찾고,
-- 2. 모든 활동일에 코호트 기준일을 붙여 경과일을 계산한 뒤,
-- 3. 코호트별, 경과일별로 활동한 고유 선수 수를 집계합니다.
WITH PlayerFirstActivity AS (
    SELECT
        player_id,
        MIN(STR_TO_DATE(date, '%Y%m%d')) AS cohort_date
    FROM
        hitters_records
    GROUP BY
        player_id
),
ActivitySinceFirst AS (
    SELECT
        h.player_id,
        pfa.cohort_date,
        DATEDIFF(STR_TO_DATE(h.date, '%Y%m%d'), pfa.cohort_date) AS days_since_first
    FROM
        hitters_records h
    JOIN
        PlayerFirstActivity pfa ON h.player_id = pfa.player_id
)
SELECT
    cohort_date,
    days_since_first,
    COUNT(DISTINCT player_id) AS retained_players
FROM
    ActivitySinceFirst
GROUP BY
    cohort_date,
    days_since_first
ORDER BY
    cohort_date,
    days_since_first
LIMIT 20;