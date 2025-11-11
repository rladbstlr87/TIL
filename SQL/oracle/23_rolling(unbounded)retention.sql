-- KBO hitters_records 데이터를 사용한 롤링 리텐션(Rolling Retention) 분석 (Oracle)
-- 특정 시점(N일차) '이후에도' 활동 기록이 있는 선수의 비율을 계산합니다.

-- 1. 선수별 첫 활동일(코호트)과 마지막 활동일을 계산합니다.
-- 2. 코호트 날짜와 마지막 활동 날짜의 차이를 계산하여, 각 선수가 며칠 동안 '잔존'했는지(retained_days) 확인합니다.
WITH PlayerActivity AS (
    SELECT
        player_id,
        MIN(TO_DATE("date", 'YYYYMMDD')) AS cohort_date,
        MAX(TO_DATE("date", 'YYYYMMDD')) AS last_activity_date
    FROM
        hitters_records
    GROUP BY
        player_id
)
SELECT
    pa.player_id,
    s.player_name,
    s.team,
    pa.cohort_date,
    pa.last_activity_date,
    pa.last_activity_date - pa.cohort_date AS retained_days
FROM
    PlayerActivity pa
JOIN
    all_hitter_stats s ON pa.player_id = s.player_id
ORDER BY
    retained_days DESC
FETCH FIRST 20 ROWS ONLY;