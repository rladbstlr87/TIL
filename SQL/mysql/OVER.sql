-- OVER: 집계 함수 및 분석 함수를 위한 윈도우를 정의
-- PARTITION BY: 데이터를 특정 그룹으로 분할 (기존 행 유지)
-- GROUP BY: 데이터를 특정 그룹으로 묶어 하나의 요약된 행으로 만듦 (기존 행 축소)

-- GROUP BY 예시: 팀별 평균 홈런 수 계산 (팀당 하나의 행만 반환)
SELECT
    team,
    AVG(HR) AS avg_hr
FROM all_hitter_stats
GROUP BY team
ORDER BY team;

-- PARTITION BY 예시: 팀 내 선수별 홈런 순위 계산 (모든 선수 행 유지)
-- RANK() 같은 순위 함수는 어떤 기준으로 순위를 매길지 알려줘야 하므로 ORDER BY가 필수
SELECT
    team,
    player_name,
    HR,
    RANK() OVER (PARTITION BY team ORDER BY HR DESC) AS hr_rank_in_team
FROM all_hitter_stats
ORDER BY team, hr_rank_in_team;

-- 집계 함수와 함께 사용하는 OVER
-- ORDER BY가 선택적이며, 있고 없음에 따라 기능이 달라짐

-- 1. ORDER BY가 없는 경우: 파티션 전체의 집계 값
-- 예: 팀별 총 홈런 수를 각 선수의 행에 표시
SELECT
    team,
    player_name,
    HR,
    SUM(HR) OVER (PARTITION BY team) AS total_hr_in_team
FROM all_hitter_stats
ORDER BY team, HR DESC;

-- 2. ORDER BY가 있는 경우: 누적 집계 값 (Running Total)
-- 예: 팀 내에서 홈런 순서대로 누적 홈런 수 계산
SELECT
    team,
    player_name,
    HR,
    SUM(HR) OVER (PARTITION BY team ORDER BY HR DESC, player_name) AS running_total_hr
FROM all_hitter_stats
ORDER BY team, HR DESC;
-- 참고: ORDER BY에 player_name을 추가하여 홈런 수가 같을 때의 순서를 보장
