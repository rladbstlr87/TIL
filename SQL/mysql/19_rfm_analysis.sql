-- 선수별 최근 경기, 출전 빈도, 타점 기여도를 기반으로 RFM 점수 계산
WITH RFM_BASE AS (
    SELECT
        player_id,
        MAX(date) AS last_game_date,
        COUNT(DISTINCT game_id) AS frequency,
        SUM(RBI) AS monetary_value
    FROM hitters_records
    GROUP BY player_id
),
RECENCY_CALC AS (
    SELECT
        player_id,
        DATEDIFF((SELECT MAX(date) FROM hitters_records), last_game_date) AS recency,
        frequency,
        monetary_value
    FROM RFM_BASE
)
SELECT
    s.player_name,
    s.team,
    r.recency,
    r.frequency,
    r.monetary_value,
    NTILE(5) OVER (ORDER BY r.recency ASC) AS R_Score,
    NTILE(5) OVER (ORDER BY r.frequency DESC) AS F_Score,
    NTILE(5) OVER (ORDER BY r.monetary_value DESC) AS M_Score
FROM RECENCY_CALC r
JOIN all_hitter_stats s ON r.player_id = s.player_id
WHERE s.PA >= 144
ORDER BY R_Score DESC, F_Score DESC, M_Score DESC;
