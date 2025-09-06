-- CASE: SQL에서 조건부 로직 처리

-- 선수 타율(AVG)에 따라 등급 나누기
-- 0.300 이상 '우수', 0.270 이상 '평균', 그 외 '개선 필요'
SELECT player_name, AVG,
        CASE
            WHEN AVG >= 0.300 THEN '우수'
            WHEN AVG >= 0.270 THEN '평균'
            ELSE '개선 필요'
        END AS '타격 등급'
FROM all_hitter_stats
WHERE PA >= 100; -- 100타석 이상인 선수만 대상

-- 팀 연고지에 따라 수도권/지방으로 분류
SELECT team,
        CASE
            WHEN team IN ('LG', 'OB', 'WO', 'SK', 'KT') THEN '수도권'
            ELSE '지방'
        END AS '연고지'
FROM all_hitter_stats
GROUP BY team;

-- 집계 함수 내에서 CASE 사용
-- 총 득점이 10점 초과인 '다득점 경기'와 그 외 '저득점 경기' 수 계산
SELECT
    SUM(CASE WHEN team1_score + team2_score > 10 THEN 1 ELSE 0 END) AS '다득점 경기',
    SUM(CASE WHEN team1_score + team2_score <= 10 THEN 1 ELSE 0 END) AS '저득점 경기'
FROM kbo_schedule
WHERE team1_score IS NOT NULL; -- 취소된 경기 제외

-- 홈런(HR) 개수에 따라 선수 유형 분류
SELECT player_name, HR,
        CASE
            WHEN HR >= 20 THEN '장타자'
            WHEN HR >= 10 THEN '중장거리'
            ELSE '단타 위주'
        END AS '타자 유형'
FROM all_hitter_stats
WHERE PA >= 100; -- 100타석 이상인 선수만 대상
