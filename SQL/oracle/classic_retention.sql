-- KBO hitters_records 데이터 활용, 클래식 리텐션(Classic Retention) 분석 (Oracle)
-- 선수 첫 경기 출전일을 코호트 기준으로 시간 경과에 따른 잔존율 계산

-- 1. 선수별 첫 활동일(코호트 기준일) 탐색
-- 2. 모든 활동일에 코호트 기준일을 붙여 경과일 계산
-- 3. 코호트별, 경과일별 고유 선수 수 집계
WITH PlayerFirstActivity AS (
    SELECT
        player_id,
        MIN(TO_DATE("date", 'YYYYMMDD')) AS cohort_date
    FROM
        hitters_records
    GROUP BY
        player_id
),
ActivitySinceFirst AS (
    SELECT
        h.player_id,
        pfa.cohort_date,
        TRUNC(TO_DATE(h."date", 'YYYYMMDD')) - pfa.cohort_date AS days_since_first
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
FETCH FIRST 20 ROWS ONLY;