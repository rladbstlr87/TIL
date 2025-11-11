-- 단일행 서브쿼리: '김현수' 선수보다 타율이 높은 선수 상위 10명 조회
-- LIMIT를 사용하여 결과 수를 제한
SELECT player_name, team, AVG
FROM all_hitter_stats
WHERE AVG > (SELECT AVG FROM all_hitter_stats WHERE player_name = '김현수')
ORDER BY AVG DESC
LIMIT 10;

-- 단일행 서브쿼리: 전체 선수 평균 타점보다 많은 타점을 기록한 선수 조회
SELECT player_name, team, RBI
FROM all_hitter_stats
WHERE RBI > (SELECT AVG(RBI) FROM all_hitter_stats);

-- 단일행 서브쿼리: '오스틴' 선수와 같은 팀의 다른 선수들 조회
SELECT player_name, team
FROM all_hitter_stats
WHERE team = (SELECT team FROM all_hitter_stats WHERE player_name = '오스틴')
  AND player_name != '오스틴';

-- 다중행 서브쿼리 (IN): 15승 이상을 기록한 투수가 있는 팀에 소속된 모든 타자 조회
SELECT player_name, team
FROM all_hitter_stats
WHERE team IN (SELECT team FROM all_pitcher_stats WHERE W >= 15);

-- 다중행 서브쿼리 (NOT IN): 타자 스탯에만 있고 투수 스탯에는 없는 선수(순수 타자) 조회
SELECT player_name, team
FROM all_hitter_stats
WHERE player_id NOT IN (SELECT player_id FROM all_pitcher_stats);

-- 다중행 서브쿼리 (ANY): 'KT' 팀 타자 중 한 명이라도 기록한 홈런 수보다 적은 홈런을 친 다른 팀 선수 조회
SELECT player_name, team, HR
FROM all_hitter_stats
WHERE HR < ANY (SELECT HR FROM all_hitter_stats WHERE team = 'KT')
  AND team != 'KT';

-- 다중행 서브쿼리 (ALL): 'KT' 팀의 모든 타자보다 많은 홈런을 친 선수 조회
SELECT player_name, team, HR
FROM all_hitter_stats
WHERE HR > ALL (SELECT HR FROM all_hitter_stats WHERE team = 'KT');
