-- KBO hitters_records 데이터를 사용한 롤링 리텐션(Rolling Retention) 분석
-- 특정 시점(N일차) '이후에도' 활동 기록이 있는 선수의 비율을 계산합니다.
-- 사용 주기가 길거나 비정기적인 서비스(야구 경기는 매일 출전하지 않으므로 적합)의 선수 유지율을 보기에 적합합니다.

-- 1. 선수별 첫 활동일(코호트)과 마지막 활동일을 계산합니다.
-- 2. 코호트 날짜와 마지막 활동 날짜의 차이를 계산하여, 각 선수가 며칠 동안 '잔존'했는지(retained_days) 확인합니다.
-- 3. 이 데이터를 기반으로 특정 N일차의 롤링 리텐션을 계산할 수 있습니다.
--    (예: 7일차 롤링 리텐션 = retained_days >= 7인 선수 수 / 해당 코호트의 총 선수 수)

-- 아래 쿼리는 코호트별로 각 선수가 며칠째까지 잔존했는지를 보여줍니다.
WITH PlayerActivity AS (
    SELECT
        player_id,
        MIN(STR_TO_DATE(date, '%Y%m%d')) AS cohort_date,
        MAX(STR_TO_DATE(date, '%Y%m%d')) AS last_activity_date
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
    DATEDIFF(pa.last_activity_date, pa.cohort_date) AS retained_days
FROM
    PlayerActivity pa
JOIN
    all_hitter_stats s ON pa.player_id = s.player_id
ORDER BY
    retained_days DESC
LIMIT 20;