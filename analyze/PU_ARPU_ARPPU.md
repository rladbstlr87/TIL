# PU, ARPU, ARPPU

## 1. PU (Paying User)

-- 정의: 일정 기간 내 한 번이라도 결제한 유저
-- 목적: 실제 구매 행동을 한 유저 그룹의 크기 측정

```sql
-- 특정 기간(예: 1월) 동안의 결제 유저 수 계산
SELECT COUNT(DISTINCT user_id) AS paying_users
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31';
```

---

## 2. ARPU (Average Revenue Per User)

-- 정의: 전체 유저 1인당 평균 매출
-- 계산: 총 매출 / 전체 유저 수
-- 목적: 서비스의 전반적인 수익성 파악 (비결제 유저 포함)

```sql
-- 1월의 ARPU 계산
WITH TotalRevenue AS (
    SELECT SUM(amount) AS total_sales
    FROM orders
    WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31'
), TotalUsers AS (
    SELECT COUNT(id) AS total_user_count
    FROM users
)
SELECT tr.total_sales / tu.total_user_count AS arpu
FROM TotalRevenue tr, TotalUsers tu;
```

---

## 3. ARPPU (Average Revenue Per Paying User)

-- 정의: 결제 유저 1인당 평균 매출
-- 계산: 총 매출 / 결제 유저 수 (PU)
-- 목적: 실제 구매 유저의 평균적인 가치(객단가) 파악

```sql
-- 1월의 ARPPU 계산
SELECT SUM(amount) / COUNT(DISTINCT user_id) AS arppu
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31';
```
