CREATE TABLE orders (
    order_id INT,
    category VARCHAR(50),
    amount DECIMAL(10, 2),
    status VARCHAR(20)
);

-- 데이터 삽입
INSERT INTO orders (order_id, category, amount, status) VALUES
(1, '전자제품', 1200.00, '정상'),
(2, '의류', 50.00, '정상'),
(3, '전자제품', 800.00, '환불'),
(4, '도서', 25.00, '정상'),
(5, '전자제품', 1500.00, '정상'),
(6, '의류', 75.00, '환불'),
(7, '도서', 15.00, '정상');

-- 사용자의 요청: "전체 주문 중 '전자제품' 카테고리 주문은 몇 건인가요?"
-- COUNT: 조건에 맞는 건수(개수) 계산
SELECT COUNT(CASE WHEN category = '전자제품' THEN 1 END)
FROM orders;

-- 사용자의 요청: "카테고리별로 '환불'된 주문 건수를 알려주세요."
-- COUNT: 그룹별 조건에 맞는 건수(개수) 계산
SELECT category, COUNT(CASE WHEN status = '환불' THEN 1 END)
FROM orders
GROUP BY category;

-- 사용자의 요청: "'전자제품' 카테고리의 총 매출액은 얼마인가요?"
-- SUM: 조건에 맞는 값(금액)의 합계 계산
SELECT SUM(CASE WHEN category = '전자제품' THEN amount END)
FROM orders;

-- 사용자의 요청: "카테고리별 '정상' 주문의 총 매출액을 보여주세요."
-- SUM: 그룹별 조건에 맞는 값(금액)의 합계 계산
SELECT category, SUM(CASE WHEN status = '정상' THEN amount END)
FROM orders
GROUP BY category;

-- --- 야구 데이터 예시 ---

-- 사용자의 요청: "팀별로 30홈런 이상 친 타자가 몇 명인지 알려주세요."
-- COUNT: all_hitter_stats 테이블에서 팀별로 홈런(HR)이 30개 이상인 선수의 수를 계산
SELECT team, COUNT(CASE WHEN "HR" >= 30 THEN 1 END) as "30홈런 이상 타자 수"
FROM all_hitter_stats
GROUP BY team;

-- 사용자의 요청: "팀별로 퀄리티스타트(QS)를 10번 이상 달성한 투수는 몇 명인가요?"
-- COUNT: all_pitcher_stats 테이블에서 팀별로 퀄리티스타트(QS)가 10회 이상인 투수의 수를 계산
SELECT team, COUNT(CASE WHEN "QS" >= 10 THEN 1 END) as "QS 10회 이상 투수 수"
FROM all_pitcher_stats
GROUP BY team;

-- 사용자의 요청: "팀별 '파워히터' 스타일(style=0) 선수들의 총 홈런 개수를 알려주세요."
-- SUM: all_hitter_stats 테이블에서 style이 0인 선수들의 홈런(HR) 합계를 팀별로 계산
SELECT team, SUM(CASE WHEN style = 0 THEN "HR" END) as "파워히터 총 홈런"
FROM all_hitter_stats
GROUP BY team;

-- 사용자의 요청: "선수별로, 3안타 이상 친 경기에서 기록한 총 타점은 얼마인가요?"
-- SUM: hitters_records 테이블에서 한 경기에 3안타(H) 이상 친 경우에만 해당 경기의 타점(RBI)을 선수별로 합산
SELECT player_id, SUM(CASE WHEN "H" >= 3 THEN "RBI" END) as "3안타 이상 경기 타점"
FROM hitters_records
GROUP BY player_id;
