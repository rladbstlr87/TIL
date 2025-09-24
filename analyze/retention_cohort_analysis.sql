-- 사용자별 첫 구매일을 기준으로 코호트 생성
-- 코호트별 시간 경과에 따른 잔존 사용자 수 집계
-- 리텐션 그래프용 시계열 데이터로 활용
WITH UserFirstOrder AS (
    -- 1. 사용자별 첫 구매일(코호트 기준일) 탐색
    SELECT
        user_id,
        MIN(DATE(order_date)) AS cohort_date
    FROM
        orders
    GROUP BY
        user_id
),
ActivitySinceFirstOrder AS (
    -- 2. 모든 주문에 코호트 기준일을 연결하고 첫 구매로부터 경과일 계산
    SELECT
        o.user_id,
        ufo.cohort_date,
        DATEDIFF(DATE(o.order_date), ufo.cohort_date) AS days_since_first
    FROM
        orders o
    JOIN
        UserFirstOrder ufo ON o.user_id = ufo.user_id
)
-- 3. 코호트별, 경과일별 고유 사용자 수를 집계하여 리텐션 데이터 생성
SELECT
    cohort_date,
    days_since_first,
    COUNT(DISTINCT user_id) AS retained_users
FROM
    ActivitySinceFirstOrder
GROUP BY
    cohort_date,
    days_since_first
ORDER BY
    cohort_date,
    days_since_first;
