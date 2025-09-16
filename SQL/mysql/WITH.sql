-- WITH: CTE(Common Table Expression)를 사용하여 임시 결과 집합 정의
-- 복잡한 쿼리를 더 읽기 쉽게 만들고 재사용 가능
WITH employees AS (
    SELECT 'Sales' AS department, 'John' AS emp_name, 5000 AS salary
    UNION ALL SELECT 'Sales', 'Jane', 7000
    UNION ALL SELECT 'HR', 'Peter', 4500
    UNION ALL SELECT 'HR', 'Mary', 8000
),
department_avg_salary AS (
    SELECT department, AVG(salary) as avg_sal
    FROM employees
    GROUP BY department
)
SELECT e.emp_name, e.salary, d.avg_sal
FROM employees e
JOIN department_avg_salary d ON e.department = d.department
WHERE e.salary > d.avg_sal;

-- ---
-- KBO 데이터 예시: 각 팀의 평균 타율(AVG)보다 높은 타율을 기록한 선수들 조회
-- team_avg_batting CTE: 팀별 평균 타율 계산
-- 메인 쿼리: 선수 타율과 팀 평균 타율을 JOIN하여 비교
WITH team_avg_batting AS (
    SELECT
        team,
        AVG(AVG) as avg_batting_average
    FROM all_hitter_stats
    GROUP BY team
)
SELECT
    a.team,
    a.player_name,
    a.AVG,
    t.avg_batting_average
FROM all_hitter_stats a
JOIN team_avg_batting t ON a.team = t.team
WHERE a.AVG > t.avg_batting_average
ORDER BY a.team, a.AVG DESC;

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
