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
