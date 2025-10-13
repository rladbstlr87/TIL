-- 범위 리텐션 (Range / Bracket Retention)
-- 클래식 리텐션을 유연하게 확장한 개념으로, 특정 '구간(Range)' 내에 사용자가 한 번이라도 활동했는지를 측정
-- 사용자가 매일 접속하지 않더라도, 특정 기간 내에만 돌아오면 유지 사용자로 간주하여 노이즈에 강함
-- 사용 주기가 길거나 주기적인 서비스에서 유용하게 사용

-- 예시: 12월 1일 가입자 5명의 방문 기록을 3일 단위 구간으로 분석
/*
| 사용자 | 12-01(Day 0) | 12-02(Day 1) | 12-03(Day 2) | 12-04(Day 3) | 12-05(Day 4) | 12-06(Day 5) | 12-07(Day 6) |
|---|---|---|---|---|---|---|---|
| A | 방문 | 방문 | 방문 | 방문 | 방문 | 방문 | 방문 |
| B | 방문 | 방문 | | 방문 | | | |
| C | 방문 | | 방문 | 방문 | | | |
| D | 방문 | | | | | 방문 | |
| E | 방문 | | | | | | 방문 |

-- 구간 정의:
-- Day 0: 12월 1일 (가입일)
-- Day 1~3: 12월 2일 ~ 4일
-- Day 4~6: 12월 5일 ~ 7일

-- 구간별 리텐션 계산:
| | Day 0 | Day 1~3 | Day 4~6 |
|---|---|---|---|
| 방문자 수 | 5 | 3 (A,B,C) | 3 (A,D,E) |
| 범위 리텐션 % | 100% | 60% | 60% |

-- Day 1~3 구간에 A, B, C가 방문했으므로 리텐션은 3/5 = 60%
-- Day 4~6 구간에 A, D, E가 방문했으므로 리텐션은 3/5 = 60%
*/

-- ---

-- SQL 예제: 첫 구매일 기준 코호트의 범위 리텐션 계산

-- 1. 사용자별 첫 구매일(코호트) 탐색
WITH UserFirstOrder AS (
    SELECT
        user_id,
        MIN(DATE(order_date)) AS cohort_date
    FROM
        orders
    GROUP BY
        user_id
),
-- 2. 모든 주문에 코호트 날짜를 연결하고 첫 구매일로부터의 경과일 계산
ActivitySinceFirstOrder AS (
    SELECT
        o.user_id,
        ufo.cohort_date,
        DATEDIFF(DATE(o.order_date), ufo.cohort_date) AS days_since_first
    FROM
        orders o
    JOIN
        UserFirstOrder ufo ON o.user_id = ufo.user_id
),
-- 3. 사용자별로 각 리텐션 구간(Bracket) 내 활동 여부 플래그(0 또는 1) 생성
RetentionBrackets AS (
    SELECT
        cohort_date,
        user_id,
        -- Day 1-3 구간 활동 여부
        MAX(CASE WHEN days_since_first BETWEEN 1 AND 3 THEN 1 ELSE 0 END) AS active_day_1_3,
        -- Day 4-6 구간 활동 여부
        MAX(CASE WHEN days_since_first BETWEEN 4 AND 6 THEN 1 ELSE 0 END) AS active_day_4_6,
        -- 주간 리텐션으로 확장 가능 (Day 7-13)
        MAX(CASE WHEN days_since_first BETWEEN 7 AND 13 THEN 1 ELSE 0 END) AS active_day_7_13
    FROM
        ActivitySinceFirstOrder
    GROUP BY
        cohort_date,
        user_id
)
-- 4. 코호트별로 각 구간의 리텐션 비율 집계
SELECT
    cohort_date,
    COUNT(user_id) AS cohort_size,
    -- Day 1-3 리텐션 (%)
    AVG(active_day_1_3) * 100 AS retention_day_1_3_percent,
    -- Day 4-6 리텐션 (%)
    AVG(active_day_4_6) * 100 AS retention_day_4_6_percent,
    -- Day 7-13 (Week 2) 리텐션 (%)
    AVG(active_day_7_13) * 100 AS retention_day_7_13_percent
FROM
    RetentionBrackets
GROUP BY
    cohort_date
ORDER BY
    cohort_date;

-- ---
-- 리텐션 분석 시 주의사항
-- 1. 비교 대상 통일: 다른 서비스와 리텐션을 비교할 때, 동일한 계산 방식을 사용했는지 확인
-- 2. 서비스 특성 고려: 서비스의 사용 주기에 맞는 리텐션 분석 방식을 선택
-- 3. 형식에 얽매이지 않기: 비즈니스 목표에 맞게 리텐션 정의와 구간을 유연하게 변경하여 사용