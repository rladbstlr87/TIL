-- IF: 조건이 참이면 첫 번째 값을, 거짓이면 두 번째 값을 반환

-- IF(condition, value_if_true, value_if_false)

-- 타석(PA)이 300 이상이면 '주전', 아니면 '백업'으로 분류
SELECT player_name, PA, IF(PA >= 300, '주전', '백업') AS '선수 유형'
FROM all_hitter_stats
WHERE PA > 0;

-- 홈런(HR)이 10개 이상이면 '장타자', 아니면 '일반타자'로 분류
SELECT player_name, HR, IF(HR >= 10, '장타자', '일반타자') AS '타자 유형'
FROM all_hitter_stats
WHERE PA > 100;

-- 집계 함수와 함께 사용
-- 팀별로 'LG'팀 소속 선수 수와 그 외 팀 선수 수 계산
SELECT
    IF(team = 'LG', 'LG 트윈스', '그 외 팀') AS '팀 구분',
    COUNT(*) AS '선수 수'
FROM all_hitter_stats
GROUP BY IF(team = 'LG', 'LG 트윈스', '그 외 팀');

-- SUM과 함께 사용하여 조건부 합계 계산
-- 'LG' 팀의 총 홈런과 나머지 팀들의 총 홈런 합계
SELECT
    SUM(IF(team = 'LG', HR, 0)) AS 'LG팀 총 홈런',
    SUM(IF(team <> 'LG', HR, 0)) AS '나머지팀 총 홈런'
FROM all_hitter_stats;
