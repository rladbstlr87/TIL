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

-- SUM과 함께 사용하여 조건부 합계 계산
-- 'LG' 팀의 총 홈런과 'HH' 팀의 총 홈런 합계
SELECT
    SUM(DECODE(team, 'LG', HR, 0)) AS "LG팀 총 홈런",
    SUM(DECODE(team, 'HH', HR, 0)) AS "한화팀 총 홈런"
FROM all_hitter_stats;
