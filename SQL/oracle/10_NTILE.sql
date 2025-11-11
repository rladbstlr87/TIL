-- NTILE: 결과를 지정된 수의 그룹으로 분할하고 각 행에 그룹 번호 할당
-- 예: 사원들을 급여 기준으로 4개 그룹으로 분할
WITH employees AS (
    SELECT 'John' AS emp_name, 5000 AS salary FROM dual
    UNION ALL SELECT 'Jane', 7000 FROM dual
    UNION ALL SELECT 'Peter', 4500 FROM dual
    UNION ALL SELECT 'Mary', 8000 FROM dual
    UNION ALL SELECT 'David', 6000 FROM dual
    UNION ALL SELECT 'Sue', 5500 FROM dual
)
SELECT
    emp_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) AS salary_group
FROM employees;

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
