-- 클래식 리텐션 (Classic Retention) 또는 N-day Retention
-- 특정 시점에 서비스를 시작한 사용자 그룹(코호트)이 '정확히 N일째 되는 날'에 다시 돌아와 활동하는 비율을 측정하는 방법
-- 매일 접속하여 사용하는 것이 기대되는 서비스(예: 메신저, SNS)의 사용자 유지율을 분석하는 데 적합

-- 예시: 202X년 12월 1일에 5명의 사용자가 가입했다고 가정
/*
| 사용자 | 12-01(Day 0) | 12-02(Day 1) | 12-03(Day 2) | 12-04(Day 3) | 12-05(Day 4) |
|---|---|---|---|---|---|
| A | 방문 | 방문 | 방문 | 방문 | 방문 |
| B | 방문 | 방문 | | 방문 | |
| C | 방문 | | 방문 | 방문 | |
| D | 방문 | | | | |
| E | 방문 | | | | |

-- 위 표를 바탕으로 12월 1일 코호트의 일별 리텐션 계산
| | Day 0 | Day 1 | Day 2 | Day 3 | Day 4 |
|---|---|---|---|---|---|
| 방문자 수 | 5 | 2 | 2 | 3 | 1 |
| 리텐션 % | 100% | 40% | 40% | 60% | 20% |

-- Day 1 리텐션: 12월 1일 가입자 5명 중 2명(A, B)이 정확히 1일 후인 12월 2일에 방문했으므로 40%
-- Day 2 리텐션: 5명 중 2명(A, C)이 정확히 2일 후인 12월 3일에 방문했으므로 40%
*/

-- ---

-- SQL 예제: 사용자별 첫 구매일을 기준으로 코호트를 생성하고, 클래식 리텐션 계산을 위한 일별 잔존 사용자 수 집계

-- 1. 사용자별 첫 구매일(코호트 기준일) 탐색
WITH UserFirstOrder AS (
    SELECT
        user_id,
        MIN(DATE(order_date)) AS cohort_date
    FROM
        orders
    GROUP BY
        user_id
),

-- 2. 모든 주문에 코호트 기준일을 연결하고, 첫 구매일로부터의 경과일 계산
ActivitySinceFirstOrder AS (
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
-- 이 데이터를 기반으로 특정 코호트의 N일차 리텐션율을 계산할 수 있음
-- 예: (N일차 잔존 사용자 수 / 0일차 총 사용자 수) * 100
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

-- ---

-- 클래식 리텐션의 한계
-- 매일 사용하는 서비스가 아닐 경우, 사용 주기가 길어 실제보다 리텐션이 과소평가될 수 있음
-- 예: 사용자 B는 Day 3에 다시 방문했지만, Day 2에는 방문하지 않아 Day 2 리텐션 계산에서 제외됨
-- 이러한 한계를 보완하기 위해 '롤링 리텐션(Rolling Retention)'과 같은 다른 측정 방식을 사용하기도 함
