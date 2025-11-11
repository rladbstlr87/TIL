-- NTILE: 결과를 지정된 수의 그룹으로 분할하고 각 행에 그룹 번호 할당
-- 예: 사용자들을 구매 금액 기준으로 4개 그룹으로 분할
WITH user_purchases AS (
    SELECT 'user1' AS user_id, 100 AS purchase_amount
    UNION ALL SELECT 'user2', 200
    UNION ALL SELECT 'user3', 50
    UNION ALL SELECT 'user4', 300
    UNION ALL SELECT 'user5', 150
    UNION ALL SELECT 'user6', 250
    UNION ALL SELECT 'user7', 120
    UNION ALL SELECT 'user8', 80
)
SELECT
    user_id,
    purchase_amount,
    NTILE(4) OVER (ORDER BY purchase_amount DESC) AS purchase_group
FROM user_purchases;

-- KBO 데이터 예시: 전체 타자를 타율(AVG) 기준으로 4개 그룹으로 분할
SELECT
    player_name,
    team,
    AVG,
    NTILE(4) OVER (ORDER BY AVG DESC) AS avg_group
FROM all_hitter_stats;

-- 타율(AVG)을 기준으로 전체 타자를 10분위로 나누고, 상위 10%(1분위)에 속하는 선수들을 조회
WITH player_deciles AS (
    SELECT
        player_name,
        team,
        AVG,
        NTILE(10) OVER (ORDER BY AVG DESC) AS decile
    FROM
        all_hitter_stats
)
SELECT
    player_name,
    team,
    AVG
FROM
    player_deciles
WHERE
    decile = 1;
