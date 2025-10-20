-- DAU, WAU, MAU: 활성 사용자 수
-- 서비스의 사용자를 측정하는 가장 기본적인 지표
-- "Active"의 기준은 서비스마다 다를 수 있음 (예: 단순 접속, 특정 기능 사용 등)

-- DAU (Daily Active User): 일간 활성 사용자
-- 특정 하루 동안 서비스를 이용한 고유 사용자 수
SELECT
    COUNT(DISTINCT user_id) AS dau
FROM
    user_activity
WHERE
    activity_date = '2025-01-28';


-- WAU (Weekly Active User): 주간 활성 사용자
-- 특정일 기준, 과거 7일 동안 서비스를 이용한 고유 사용자 수
SELECT
    COUNT(DISTINCT user_id) AS wau
FROM
    user_activity
WHERE
    activity_date BETWEEN '2025-01-22' AND '2025-01-28'; -- 28일 포함 7일


-- MAU (Monthly Active User): 월간 활성 사용자
-- 특정일 기준, 과거 30일(또는 한 달) 동안 서비스를 이용한 고유 사용자 수
SELECT
    COUNT(DISTINCT user_id) AS mau
FROM
    user_activity
WHERE
    activity_date BETWEEN '2024-12-30' AND '2025-01-28'; -- 28일 포함 30일

-- ---

-- Stickiness (사용자 고착도)
-- 월간 활성 사용자(MAU) 중 얼마나 많은 사용자가 매일(DAU) 방문하는지를 나타내는 비율
-- 사용자가 얼마나 자주, 주기적으로 서비스를 사용하는지, 즉 서비스에 '얼마나 붙어있는지'를 측정하는 핵심 지표
-- Stickiness = (DAU / MAU) * 100 또는 (DAU / WAU) * 100

-- 예시:
-- 1. 매일 다른 사용자가 방문: DAU의 합계가 WAU/MAU와 비슷해지며 Stickiness는 낮아짐
-- 2. 소수의 사용자가 매일 방문: DAU의 합계가 WAU/MAU보다 훨씬 커지며 Stickiness는 높아짐 (100%에 가까워짐)

-- Stickiness는 사용자의 재방문 빈도가 중요한 SNS, 뉴스, 커머스 등의 비즈니스에서 특히 중요하게 관리됨

-- ---

-- SQL 예제: 특정일의 Stickiness (DAU/MAU) 계산

WITH ActiveUsers AS (
    SELECT
        -- 1. DAU와 MAU를 동시에 계산하기 위한 플래그 생성
        user_id,
        MAX(CASE WHEN activity_date = '2025-01-28' THEN 1 ELSE 0 END) AS is_dau,
        MAX(CASE WHEN activity_date BETWEEN '2024-12-30' AND '2025-01-28' THEN 1 ELSE 0 END) AS is_mau
    FROM
        user_activity
    WHERE
        -- MAU 기간에 해당하는 데이터만 필터링하여 성능 최적화
        activity_date BETWEEN '2024-12-30' AND '2025-01-28'
    GROUP BY
        user_id
)
-- 2. 플래그를 합산하여 DAU, MAU를 구하고 Stickiness 계산
SELECT
    SUM(is_dau) AS dau,
    SUM(is_mau) AS mau,
    (SUM(is_dau) * 100.0 / SUM(is_mau)) AS stickiness_dau_mau_percent
FROM
    ActiveUsers;

-- 참고: DAU/WAU Stickiness 계산
/*
WITH ActiveUsersWeekly AS (
    SELECT
        user_id,
        MAX(CASE WHEN activity_date = '2025-01-28' THEN 1 ELSE 0 END) AS is_dau,
        MAX(CASE WHEN activity_date BETWEEN '2025-01-22' AND '2025-01-28' THEN 1 ELSE 0 END) AS is_wau
    FROM
        user_activity
    WHERE
        activity_date BETWEEN '2025-01-22' AND '2025-01-28'
    GROUP BY
        user_id
)
SELECT
    SUM(is_dau) AS dau,
    SUM(is_wau) AS wau,
    (SUM(is_dau) * 100.0 / SUM(is_wau)) AS stickiness_dau_wau_percent
FROM
    ActiveUsersWeekly;
*/