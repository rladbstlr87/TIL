-- KBO hitters_records 데이터 활용, 범위 리텐션(Range Retention) 분석
-- 특정 '구간(Range)' 내 선수 출전 여부 측정
-- 예: 첫 출전 후 1-7일, 8-14일 등 주간 단위 활동성 파악에 유용

-- 1. 선수별 첫 활동일(코호트) 탐색
-- 2. 모든 활동 기록에 대해 첫 활동일로부터의 경과일 계산
-- 3. 선수별 각 리텐션 구간(Bracket) 내 활동 여부 플래그(0 또는 1) 생성
-- 4. 코호트별 각 구간 리텐션 비율 집계
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
LIMIT 20;