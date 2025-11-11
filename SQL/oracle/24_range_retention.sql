-- KBO hitters_records 데이터를 사용한 범위 리텐션(Range Retention) 분석 (Oracle)
-- 특정 '구간(Range)' 내에 선수가 한 번이라도 출전했는지를 측정합니다.

-- 1. 선수별 첫 활동일(코호트)을 찾습니다.
-- 2. 모든 활동 기록에 대해 첫 활동일로부터의 경과일을 계산합니다.
-- 3. 선수별로 각 리텐션 구간(Bracket) 내 활동 여부를 플래그(0 또는 1)로 생성합니다.
-- 4. 코호트별로 각 구간의 리텐션 비율을 집계합니다.
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
        TO_DATE(h."date", 'YYYYMMDD') - pfa.cohort_date AS days_since_first
    FROM
        hitters_records h
    JOIN
        PlayerFirstActivity pfa ON h.player_id = pfa.player_id
),
RetentionBrackets AS (
    SELECT
        cohort_date,
        player_id,
        MAX(CASE WHEN days_since_first BETWEEN 1 AND 7 THEN 1 ELSE 0 END) AS active_week_1,
        MAX(CASE WHEN days_since_first BETWEEN 8 AND 14 THEN 1 ELSE 0 END) AS active_week_2,
        MAX(CASE WHEN days_since_first BETWEEN 15 AND 21 THEN 1 ELSE 0 END) AS active_week_3,
        MAX(CASE WHEN days_since_first BETWEEN 22 AND 28 THEN 1 ELSE 0 END) AS active_week_4
    FROM
        ActivitySinceFirst
    GROUP BY
        cohort_date,
        player_id
)
SELECT
    cohort_date,
    COUNT(player_id) AS cohort_size,
    AVG(active_week_1) * 100 AS retention_week_1_percent,
    AVG(active_week_2) * 100 AS retention_week_2_percent,
    AVG(active_week_3) * 100 AS retention_week_3_percent,
    AVG(active_week_4) * 100 AS retention_week_4_percent
FROM
    RetentionBrackets
GROUP BY
    cohort_date
ORDER BY
    cohort_date
FETCH FIRST 20 ROWS ONLY;