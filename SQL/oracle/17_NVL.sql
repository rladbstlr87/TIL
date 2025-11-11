-- NVL: NULL을 다른 값으로 치환
-- NVL(표현식, 대체값)

-- 닉네임이 NULL이면 'Guest' 반환
SELECT NVL(nickname, 'Guest') AS display_name
FROM user_profiles;

-- 보너스가 NULL인 직원은 0으로 처리하여 총 급여 계산
SELECT SUM(salary + NVL(bonus, 0)) AS total_compensation
FROM employees;

-- NVL2: NULL이 아닐 때와 NULL일 때 각각 다른 값 반환
-- NVL2(표현식, NULL 아닐때 값, NULL일때 값)
SELECT NVL2(bonus, '보너스 있음', '보너스 없음')
FROM employees;
