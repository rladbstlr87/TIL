-- SUM() vs SUM() OVER()

-- SUM(): 집계 함수
-- GROUP BY와 함께 사용, 그룹별 합계를 계산하고 그룹당 하나의 행으로 요약
SELECT
    team,
    SUM(HR) AS total_hr
FROM all_hitter_stats
GROUP BY team
ORDER BY team;

-- SUM() OVER(): 윈도우 함수
-- 기존 행들을 유지하면서, 각 행에 대해 계산된 합계(전체, 누적 등)를 추가
-- 개별 행의 정보를 보존해야 할 때 유용

-- 1. 파티션 전체 합계
-- ORDER BY 없이 사용하면 파티션 전체의 합계를 계산
-- 선수별로 자신이 속한 팀의 총 홈런 수를 함께 조회
SELECT
    team,
    player_name,
    HR,
    SUM(HR) OVER (PARTITION BY team) AS team_total_hr
FROM all_hitter_stats
ORDER BY team, HR DESC;

-- 2. 누적 합계 (Running Total)
-- ORDER BY와 함께 사용하면 현재 행까지의 누적 합계를 계산
-- 팀별로 홈런 순으로 정렬하고, 각 선수의 홈런까지의 누적 합계를 계산
SELECT
    team,
    player_name,
    HR,
    SUM(HR) OVER (PARTITION BY team ORDER BY HR DESC, player_name) AS running_total_hr
FROM all_hitter_stats
ORDER BY team, HR DESC;

-- 3. 전체 집합에 대한 누적 합계
-- PARTITION BY를 생략하면 전체 데이터셋에 대한 누적 합계를 계산
-- 모든 선수를 홈런 순으로 정렬하고, 리그 전체의 누적 홈런 수를 계산
SELECT
    player_name,
    team,
    HR,
    SUM(HR) OVER (ORDER BY HR DESC, player_name) AS league_running_total_hr
FROM all_hitter_stats
ORDER BY HR DESC;