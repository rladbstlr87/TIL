-- Oracle에는 MySQL의 IF() 함수가 없음
-- 대신 CASE 문 또는 DECODE 함수를 사용

-- CASE: 표준 SQL 방식으로, 복잡한 조건 논리 처리 가능 (권장)
-- 타석(PA)이 300 이상이면 '주전', 아니면 '백업'으로 분류
SELECT player_name, PA,
    CASE
        WHEN PA >= 300 THEN '주전'
        ELSE '백업'
    END AS "선수 유형"
FROM all_hitter_stats
WHERE PA > 0;

-- DECODE: Oracle 전용 함수로, 간단한 동등 비교에 사용
-- DECODE(컬럼, 비교값1, 결과1, 비교값2, 결과2, ..., 기본값)

-- 팀명이 'LG'이면 'LG 트윈스', 'HH'이면 '한화 이글스', 그 외는 '기타'로 표시
SELECT player_name, team,
    DECODE(team, 'LG', 'LG 트윈스',
                 'HH', '한화 이글스',
                 '기타') AS "팀 이름"
FROM all_hitter_stats;

-- 집계 함수와 함께 사용
-- 팀별로 'LG'팀과 'HH'팀의 선수 수를 각각 계산
SELECT
    COUNT(DECODE(team, 'LG', 1)) AS "LG 선수 수",
    COUNT(DECODE(team, 'HH', 1)) AS "한화 선수 수"
FROM all_hitter_stats;

-- COUNT(DECODE(team, 'HH', 1)) 설명
-- 1. DECODE는 team이 'HH'이면 1, 아니면 NULL을 반환
-- 2. COUNT 함수는 NULL이 아닌 값(여기서는 1)의 개수만 계산
-- => 결과적으로 'HH' 팀의 선수 수를 세는 것과 동일

-- SUM과 함께 사용하여 조건부 합계 계산
-- 'LG' 팀의 총 홈런과 'HH' 팀의 총 홈런 합계
SELECT
    SUM(DECODE(team, 'LG', HR, 0)) AS "LG팀 총 홈런",
    SUM(DECODE(team, 'HH', HR, 0)) AS "한화팀 총 홈런"
FROM all_hitter_stats;

-- SUM(DECODE(team, 'LG', HR, 0)) 설명 (조건부 합계)
-- 1. DECODE는 team이 'LG'이면 HR(홈런 수), 아니면 0을 반환
-- 2. SUM 함수는 이 결과들을 모두 더함
-- => 'LG'팀 소속 선수의 홈런만 합산하고, 나머지는 0을 더하므로 'LG'팀의 총 홈런이 계산됨

