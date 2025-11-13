-- INNER JOIN: 두 테이블에 공통으로 존재하는 데이터만 결합
-- 양쪽 테이블에 모두 일치하는 키가 있는 행만 반환

-- 선수 정보(all_hitter_stats)와 경기 기록(hitters_records)을 결합
-- 3안타 이상 친 'LG' 팀 선수의 이름과 경기 날짜, 안타 수 조회
SELECT
    a.player_name,
    a.team,
    h."date",
    h.H
FROM
    all_hitter_stats a
INNER JOIN
    hitters_records h ON a.player_id = h.player_id
WHERE
    a.team = 'LG' AND h.H >= 3
FETCH FIRST 10 ROWS ONLY;

-- JOIN ... USING: 조인하는 테이블 간에 컬럼명이 동일할 때 사용
-- ON a.player_id = h.player_id 대신 USING (player_id)로 축약 가능
-- USING 절에 사용된 컬럼은 SELECT 목록에서 테이블 별칭 없이 참조해야 함
SELECT
    player_id, -- 'a.player_id' 또는 'h.player_id'가 아닌 'player_id'로 참조
    a.player_name,
    a.team,
    h."date",
    h.H
FROM
    all_hitter_stats a
INNER JOIN
    hitters_records h USING (player_id)
WHERE
    a.team = 'LG' AND h.H >= 3
FETCH FIRST 10 ROWS ONLY;
