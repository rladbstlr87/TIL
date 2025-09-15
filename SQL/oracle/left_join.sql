-- LEFT JOIN: 왼쪽 테이블의 모든 데이터를 기준으로 오른쪽 테이블의 데이터를 결합
-- 오른쪽 테이블에 일치하는 데이터가 없으면 해당 컬럼은 NULL로 표시

-- 모든 선수(all_hitter_stats)를 기준으로, 경기 기록(hitters_records)이 있는 선수의 기록을 조회
-- 경기 기록이 없는 선수도 명단에 포함됨
SELECT
    a.player_name,
    a.team,
    h."date",
    h.H
FROM
    all_hitter_stats a
LEFT JOIN
    hitters_records h ON a.player_id = h.player_id
WHERE
    a.team = 'KT' AND a.PA > 0
FETCH FIRST 10 ROWS ONLY;
