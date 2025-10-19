-- KBO hitters_records 데이터 활용, DAU, WAU, MAU, Stickiness 분석 (Oracle)
-- "활동" 기준: 선수가 경기에 출전(hitters_records에 기록 존재)

-- 특정일(2025년 4월 15일) DAU (Daily Active Users)
SELECT
    COUNT(DISTINCT player_id) AS dau
FROM
    hitters_records
WHERE
    "date" = 20250415;

-- 특정일(2025년 4월 15일) 기준 WAU (Weekly Active Users)
SELECT
    COUNT(DISTINCT player_id) AS wau
FROM
    hitters_records
WHERE
    "date" BETWEEN 20250409 AND 20250415;

-- 특정일(2025년 4월 15일) 기준 MAU (Monthly Active Users)
SELECT
    COUNT(DISTINCT player_id) AS mau
FROM
    hitters_records
WHERE
    "date" BETWEEN 20250317 AND 20250415;

-- Stickiness (DAU/MAU) 계산
WITH ActiveUsers AS (
    SELECT
        player_id,
        MAX(CASE WHEN "date" = 20250415 THEN 1 ELSE 0 END) AS is_dau,
        MAX(CASE WHEN "date" BETWEEN 20250317 AND 20250415 THEN 1 ELSE 0 END) AS is_mau
    FROM
        hitters_records
    WHERE
        "date" BETWEEN 20250317 AND 20250415
    GROUP BY
        player_id
)
SELECT
    SUM(is_dau) AS dau,
    SUM(is_mau) AS mau,
    (SUM(is_dau) * 100.0 / SUM(is_mau)) AS stickiness_dau_mau_percent
FROM
    ActiveUsers;