-- 중복 데이터 제거하기
-- `DISTINCT`는 선택한 **모든 컬럼 조합**으로 중복 제거
SELECT DISTINCT game_id, stadium_id
FROM cal_lineup;

SELECT DISTINCT stadium_id, game_id
FROM cal_lineup;
-- 두 쿼리의 결과는 같고 보이는 컬럼의 순서와, 로우의 순서가 다를 뿐이다

-- 첫 컬럼만 기준으로 1행 선택이 필요할 때
-- PostgreSQL: DISTINCT ON
SELECT DISTINCT ON (game_id) game_id, stadium_id
FROM cal_lineup
ORDER BY game_id, stadium_id;

-- 표준 SQL: 집계 + GROUP BY
SELECT game_id, MIN(stadium_id) AS stadium_id
FROM cal_lineup
GROUP BY game_id;

-- 윈도 함수
SELECT game_id, stadium_id
FROM (
SELECT game_id, stadium_id,
ROW_NUMBER() OVER (PARTITION BY game_id ORDER BY stadium_id) AS rn
FROM cal_lineup
) s
WHERE rn = 1;

-- AS - 컬럼의 이름 변경하여 표시
SELECT stadium_id AS 구장
FROM cal_lineup
LIMIT 10;

-- AS 생략 가능
SELECT stadium_id 구장
FROM cal_lineup
LIMIT 10;

-- 띄어쓰기 가능
SELECT stadium_id AS '구장 이름'
FROM cal_lineup
LIMIT 10;