-- LEAD: 현재 행보다 뒤에 있는 행의 값 가져오기
-- LAG: 현재 행보다 앞에 있는 행의 값 가져오기

-- 선수들의 경기별 타석(PA)과 바로 다음 경기의 타석을 함께 조회
-- LAG(컬럼, N, 기본값): N번째 이전 행의 값, 없으면 기본값
-- LEAD(컬럼, N, 기본값): N번째 이후 행의 값, 없으면 기본값
WITH game_logs AS (
    SELECT
        player_id,
        date,
        PA,
        LAG(PA, 1, 0) OVER (PARTITION BY player_id ORDER BY date) AS prev_game_pa,
        LEAD(PA, 1, 0) OVER (PARTITION BY player_id ORDER BY date) AS next_game_pa
    FROM hitters_records
    WHERE player_id = 10001 -- 특정 선수 예시
)
SELECT * FROM game_logs ORDER BY date;


-- 팀별, 날짜순으로 이전 3경기 평균 득점 계산
-- 이동 평균(Moving Average) 계산에 LAG 활용
WITH team_scores AS (
    SELECT
        day,
        team1 AS team,
        team1_score AS score
    FROM kbo_schedule
    WHERE team1_score IS NOT NULL
    UNION ALL
    SELECT
        day,
        team2 AS team,
        team2_score AS score
    FROM kbo_schedule
    WHERE team2_score IS NOT NULL
),
scores_with_lag AS (
    SELECT
        day,
        team,
        score,
        LAG(score, 1, 0) OVER (PARTITION BY team ORDER BY day) AS prev1_score,
        LAG(score, 2, 0) OVER (PARTITION BY team ORDER BY day) AS prev2_score
    FROM team_scores
)
SELECT
    day,
    team,
    score,
    (score + prev1_score + prev2_score) / 3 AS moving_avg_3games
FROM scores_with_lag
WHERE team = 'LG' -- 특정 팀 예시
ORDER BY day;