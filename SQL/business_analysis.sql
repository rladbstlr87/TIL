-- KBO 데이터 기반 비즈니스 분석 SQL 쿼리

-- 1. 클러치 히터(Clutch Hitter) 발굴을 통한 스타 마케팅 강화
-- -- 비즈니스 목표: 중요한 순간(득점권 상황)에 높은 타율을 기록하는 선수를 발굴하여 "클러치 히터"로 브랜딩하고, 관련 상품(유니폼, 응원도구) 판매 및 팬덤 강화를 위한 마케팅에 활용
-- -- 분석 내용: 규정 타석을 넘긴 선수 중 득점권 타율(RISP)이 가장 높은 상위 10명의 선수를 조회
SELECT 
    player_name, 
    team, 
    RISP,
    PA
FROM 
    all_hitter_stats
WHERE 
    PA >= 300 -- 유의미한 통계를 위해 타석 300 이상으로 필터링
ORDER BY 
    RISP DESC
LIMIT 10;

-- 2. '역전의 명수' 팀 브랜딩을 위한 근거 데이터 확보
-- -- 비즈니스 목표: 1점 차 승부가 잦은 박진감 넘치는 팀, 혹은 역전승이 많은 팀을 "역전의 명수"로 브랜딩하여 팬들에게 극적인 재미를 선사하고 팀의 충성도를 높이는 스토리텔링 자료로 활용
-- -- 분석 내용: 1점 차로 승리한 경기가 가장 많은 팀 순위를 집계
SELECT 
    winner AS team,
    COUNT(*) AS one_run_wins
FROM 
    (SELECT 
        CASE 
            WHEN team1_result = '승' THEN team1 
            ELSE team2 
        END AS winner
    FROM 
        kbo_schedule
    WHERE 
        ABS(team1_score - team2_score) = 1 AND team1_result != '무') AS one_run_games
GROUP BY 
    winner
ORDER BY 
    one_run_wins DESC;

-- 3. '창과 방패' 빅매치업 홍보
-- -- 비즈니스 목표: 최고의 홈런 타자와 최고의 방어율(피홈런) 투수 간의 맞대결을 "창과 방패" 컨셉으로 홍보하여 특정 경기의 주목도를 높이고 티켓 판매 및 중계 시청률을 증대
-- -- 분석 내용: 올 시즌 최고의 홈런 타자 Top 5와, 규정 이닝을 충족한 투수 중 이닝 당 피홈런이 가장 적은 Top 5를 각각 조회하여 빅매치 홍보 자료로 활용
-- -- 최고의 홈런 타자 Top 5
SELECT 
    player_name, 
    team, 
    HR 
FROM 
    all_hitter_stats 
ORDER BY 
    HR DESC 
LIMIT 5;

-- -- 이닝 당 피홈런이 가장 적은 투수 Top 5 (100이닝 이상)
SELECT 
    player_name, 
    team, 
    IP, 
    HR, 
    (HR / IP) AS HR_per_Inning 
FROM 
    all_pitcher_stats 
WHERE 
    IP > 100 
ORDER BY 
    HR_per_Inning ASC 
LIMIT 5;

-- 4. 팬들에게 가장 큰 즐거움을 주는 '믿고 보는 선수' 발굴
-- -- 비즈니스 목표: 단타보다 2루타, 3루타, 홈런 등 팬들을 열광시키는 플레이를 자주 보여주는 선수를 "믿고 보는 선수"로 지정하여 팬 감사 이벤트, 특별 유니폼 제작 등 팬 서비스 마케팅에 활용
-- -- 분석 내용: (2루타*2 + 3루타*3 + 홈런*4)로 가중치를 부여한 'Thrill Score'를 계산하여 가장 높은 점수를 기록한 선수 10명을 선정
SELECT 
    player_name, 
    team, 
    (2B * 2 + 3B * 3 + HR * 4) AS thrill_score,
    G
FROM 
    all_hitter_stats
WHERE
    G >= 100 -- 100경기 이상 출전 선수로 필터링
ORDER BY 
    thrill_score DESC
LIMIT 10;
