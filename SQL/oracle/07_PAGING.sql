-- Oracle에는 LIMIT 키워드가 없으며, ROWNUM 또는 OFFSET-FETCH를 사용

-- 1. ROWNUM 사용 (Oracle 11g 및 이전 버전 - 구 방식)
-- ROWNUM은 ORDER BY보다 먼저 실행되므로, 정렬 후 일부를 가져오려면 서브쿼리 필수

-- 정렬 후 상위 N개 조회 (서브쿼리 사용)
-- 연봉이 가장 높은 5명을 조회
SELECT *
FROM (
    SELECT *
    FROM employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 5;

-- 페이지네이션 (중간 부분 N개 조회)
-- ROWNUM을 직접 비교(rn >= 6)하기 위해 인라인 뷰(Inline View)를 한번 더 사용
-- 연봉 순으로 6번째부터 10번째까지(5명) 조회
SELECT *
FROM (
    SELECT ROWNUM AS rn, sorted_emp.*
    FROM (
        SELECT *
        FROM employees
        ORDER BY salary DESC
    ) sorted_emp
    WHERE ROWNUM <= 10
)
WHERE rn >= 6;


-- 2. OFFSET-FETCH 사용 (Oracle 12c 및 이후 버전 - 신 방식, 권장)
-- 표준 SQL과 유사하며 훨씬 직관적

-- 상위 N개 행 가져오기
-- 연봉이 가장 높은 5명을 조회
SELECT *
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;

-- 페이지네이션 (중간 부분 N개 조회)
-- 5개 행을 건너뛰고 (OFFSET) 그 다음 5개 행을 가져옴 (FETCH)
-- 연봉 순으로 6번째부터 10번째까지(5명) 조회
SELECT *
FROM employees
ORDER BY salary DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
