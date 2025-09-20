-- LIMIT: 쿼리 결과의 행 수를 제한

-- 상위 N개 행 가져오기: LIMIT [개수]
-- 연봉이 가장 높은 5명을 조회
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 중간 부분의 N개 행 가져오기: LIMIT [시작점], [개수]
-- 시작점은 0부터 계산 (예: 5는 6번째 행을 의미)
-- 연봉 순으로 6번째부터 10번째까지(5명) 조회
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5, 5;

-- --- LIMIT 활용 ---

-- 1. 그룹별 상위 N개 조회 (Top N per Group)
-- LIMIT만으로 해결 불가, 윈도우 함수(ROW_NUMBER)와 함께 사용
-- 각 부서(department)별로 연봉(salary)이 가장 높은 2명을 조회
WITH RankedEmployees AS (
    SELECT
        emp_name,
        department,
        salary,
        -- 부서별로 연봉 내림차순으로 순위를 매김
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rn
    FROM employees
)
SELECT
    emp_name,
    department,
    salary
FROM RankedEmployees
WHERE rn <= 2; -- 순위가 1 또는 2인 직원만 선택

-- 2. UNION과 함께 사용
-- 'Sales' 부서 상위 3명과 'HR' 부서 상위 3명을 각각 뽑아서 합치기
(SELECT emp_name, department, salary FROM employees WHERE department = 'Sales' ORDER BY salary DESC LIMIT 3)
UNION ALL
(SELECT emp_name, department, salary FROM employees WHERE department = 'HR' ORDER BY salary DESC LIMIT 3);

-- 3. 서브쿼리(Subquery) 내에서 사용
-- 가장 최근에 가입한 10명의 고객이 주문한 모든 내역 조회
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    ORDER BY signup_date DESC
    LIMIT 10
);