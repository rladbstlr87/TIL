-- 롤링 리텐션 (Rolling / Unbounded Retention)
-- 특정 시점(Day N) '이후에도' 한 번이라도 활동한 사용자의 비율을 측정
-- 사용 주기가 길거나 비정기적인 서비스(예: 이커머스, 숙박 예약)에 적합
-- '이탈'에 초점을 맞춘 지표로, Day N 롤링 리텐션은 'Day N 시점까지 이탈하지 않은 사용자'를 의미

-- 예시: 클래식 리텐션과 동일한 사용자 데이터
/*
| 사용자 | 12-01(Day 0) | 12-02(Day 1) | 12-03(Day 2) | 12-04(Day 3) | 12-05(Day 4) |
|---|---|---|---|---|---|
| A | 방문 | 방문 | 방문 | 방문 | 방문 |
| B | 방문 | 방문 | | 방문 | |
| C | 방문 | | 방문 | 방문 | |
| D | 방문 | | | | |
| E | 방문 | | | | |

-- Day 2 롤링 리텐션 계산:
-- Day 2 또는 그 이후(Day 3, Day 4...)에 접속한 사용자를 모두 카운트
-- 사용자 A: Day 2, 3, 4에 방문
-- 사용자 B: Day 3에 방문
-- 사용자 C: Day 2, 3에 방문
-- -> 총 3명 (A, B, C)이 Day 2 시점에 이탈하지 않고 남아있다고 판단.
-- Day 2 롤링 리텐션: 3 / 5 = 60%
-- (참고: Day 2 클래식 리텐션은 40% (A, C))
*/

-- ---

-- SQL 예제: 사용자별 첫 구매일 기준, N일차 롤링 리텐션 계산

-- 1. 사용자별 첫 구매일(코호트)과 마지막 구매일 계산
WITH UserActivity AS (
    SELECT
        user_id,
        MIN(DATE(order_date)) AS cohort_date,
        MAX(DATE(order_date)) AS last_activity_date
    FROM
        orders
    GROUP BY
        user_id
),
-- 2. 코호트별 총 사용자 수 계산
CohortSize AS (
    SELECT
        cohort_date,
        COUNT(DISTINCT user_id) AS total_users
    FROM
        UserActivity
    GROUP BY
        cohort_date
)
-- 3. 코호트 날짜와 마지막 활동 날짜의 차이를 계산하여, 각 사용자가 며칠 동안 활동했는지(retained_days) 확인
-- 이 데이터를 사용하여 N일차 롤링 리텐션을 계산할 수 있음
-- 예: 7일차 롤링 리텐션 = (retained_days >= 7인 사용자 수) / (해당 코호트의 총 사용자 수)
SELECT
    ua.cohort_date,
    DATEDIFF(ua.last_activity_date, ua.cohort_date) AS retained_days,
    cs.total_users
FROM
    UserActivity ua
JOIN
    CohortSize cs ON ua.cohort_date = cs.cohort_date
ORDER BY
    ua.cohort_date;

-- 위 쿼리는 각 사용자가 며칠째까지 잔존했는지를 보여줌.
-- 특정 N일에 대한 롤링 리텐션을 구하려면 아래와 같이 집계 쿼리를 추가로 실행할 수 있음.

-- 예: 7일차 롤링 리텐션
/*
WITH UserActivity AS (
    SELECT
        user_id,
        MIN(DATE(order_date)) AS cohort_date,
        MAX(DATE(order_date)) AS last_activity_date
    FROM
        orders
    GROUP BY
        user_id
),
RollingRetention AS (
    SELECT
        cohort_date,
        SUM(CASE WHEN DATEDIFF(last_activity_date, cohort_date) >= 7 THEN 1 ELSE 0 END) AS retained_users_day_7,
        COUNT(user_id) AS total_users
    FROM
        UserActivity
    GROUP BY
        cohort_date
)
SELECT
    cohort_date,
    retained_users_day_7 * 100.0 / total_users AS rolling_retention_day_7
FROM
    RollingRetention;
*/