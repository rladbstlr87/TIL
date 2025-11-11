-- SELF JOIN: 한 테이블을 자기 자신과 결합
-- 테이블 내의 행들을 서로 비교할 때 사용

-- 같은 날, 같은 구장에서 열린 다른 경기(더블헤더)를 찾기
-- kbo_schedule 테이블을 자신과 조인
SELECT
    a.day,
    a.stadium,
    a.team1 || ' vs ' || a.team2 AS game1,
    b.team1 || ' vs ' || b.team2 AS game2,
    a.time AS game1_time,
    b.time AS game2_time
FROM
    kbo_schedule a
JOIN
    kbo_schedule b ON a.day = b.day AND a.stadium = b.stadium AND a.time < b.time;
