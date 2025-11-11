-- Equi Join (등가 조인)
-- 두 테이블 간의 공통된 컬럼 값을 '=' 연산자를 사용하여 비교하는 가장 일반적인 조인 방식

-- NULL 값 처리 주의사항
-- SQL에서 NULL은 '알 수 없음'을 의미하며, 어떤 값과도 같다고 간주되지 않음
-- 따라서 NULL = NULL 또한 참이 아닌 거짓(UNKNOWN)으로 평가됨
-- NULL 값을 비교할 때는 'IS NULL' 또는 'IS NOT NULL'을 사용

-- 암시적 조인 (Implicit Join) 예시
-- FROM 절에 여러 테이블을 나열하고 WHERE 절에서 조인 조건을 명시하는 방식
-- 명시적 JOIN 키워드를 사용하는 방식(INNER JOIN)과 기능적으로 동일
SELECT
    emp.ename,
    dept.dname
FROM
    emp,
    dept
WHERE
    emp.deptno = dept.deptno;

-- all_hitter_stats와 hitters_records 테이블을 player_id로 조인
-- 3안타 이상 친 'LG' 팀 선수의 이름, 팀, 경기 날짜, 안타 수 조회
SELECT
    a.player_name,
    a.team,
    h.date,
    h.H
FROM
    all_hitter_stats a
JOIN
    hitters_records h ON a.player_id = h.player_id
WHERE
    a.team = 'LG' AND h.H >= 3
LIMIT 10;
0
--------------------------------------------------------------

-- Non-Equi Join (비등가 조인)
-- '=' 이외의 비교 연산자(>, <, BETWEEN 등)를 사용하여 조인
-- 특정 범위에 해당하는 데이터를 연결할 때 유용

-- 예제 1: 타율에 따라 선수 등급 부여
-- 가상의 타율 등급 테이블(performance_grades)을 생성하고, 선수의 타율(AVG)이 등급의 범위(min_avg, max_avg)에 속하는지 비교
WITH performance_grades AS (
    SELECT 'A 등급' AS grade, 0.300 AS min_avg, 1.000 AS max_avg
    UNION ALL
    SELECT 'B 등급' AS grade, 0.270 AS min_avg, 0.299 AS max_avg
    UNION ALL
    SELECT 'C 등급' AS grade, 0.000 AS min_avg, 0.269 AS max_avg
)
SELECT
    a.player_name,
    a.AVG,
    g.grade
FROM
    all_hitter_stats a
JOIN
    performance_grades g ON a.AVG BETWEEN g.min_avg AND g.max_avg
WHERE
    a.PA >= 144 -- 규정 타석 이상 선수만 대상
ORDER BY
    a.AVG DESC
LIMIT 10;

-- 예제 2: Self Join을 활용한 Non-Equi Join
-- 같은 팀 내에서 한 선수가 다른 선수보다 홈런은 많지만 타율은 낮은 경우를 조회
SELECT
    p1.player_name AS player1,
    p1.HR AS player1_hr,
    p1.AVG AS player1_avg,
    p2.player_name AS player2,
    p2.HR AS player2_hr,
    p2.AVG AS player2_avg
FROM
    all_hitter_stats p1
JOIN
    all_hitter_stats p2 ON p1.team = p2.team
                       AND p1.player_id < p2.player_id -- 중복 쌍 제거 (p1, p2와 p2, p1)
                       AND p1.HR > p2.HR
                       AND p1.AVG < p2.AVG
WHERE
    p1.team = 'LG' -- 'LG' 팀으로 제한하여 분석
LIMIT 10;
