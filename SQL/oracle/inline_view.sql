-- 인라인 뷰: FROM 절 내에서 정의되는 서브쿼리
-- 한 번만 사용되고 재사용되지 않는 임시 테이블처럼 동작

SELECT
    a.department_name,
    b.total_salary
FROM
    departments a,
    (SELECT department_id, SUM(salary) AS total_salary FROM employees GROUP BY department_id) b
WHERE
    a.department_id = b.department_id;

------------

SELECT C.MODEL, C.CAR_TYPE, C.DAILY_FEE
FROM CAR C,
     (SELECT CAR_TYPE, MAX(DAILY_FEE) AS MAX_FEE
      FROM CAR
      GROUP BY CAR_TYPE) I
WHERE C.CAR_TYPE = I.CAR_TYPE
  AND C.DAILY_FEE = I.MAX_FEE;

-- | MODEL | CAR_TYPE | DAILY_FEE |
-- | ----- | -------- | --------- |
-- | K5    | SEDAN    | 65000     |
-- | 투싼   | SUV      | 85000     |
-- | K9    | LUXURY   | 220000    |
-- | EV6   | ELECTRIC | 95000     |