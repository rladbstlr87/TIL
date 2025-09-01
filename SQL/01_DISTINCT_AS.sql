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

-- 결과 열의 기본 표시 순서는 SELECT에 나열한 순서
SELECT stadium_id, game_id FROM cal_lineup;
SELECT game_id, stadium_id FROM cal_lineup;

-- ORDER BY는 행 순서만 변경, 열 순서는 그대로
SELECT game_id, stadium_id
FROM cal_lineup
ORDER BY stadium_id DESC;

-- 열 순서·표시에 영향 주는 예외

-- SELECT * / t.* 확장 순서
SELECT b.*, a.id
FROM a JOIN b ON a.id = b.id;
-- b의 모든 열 뒤에 a.id

-- JOIN ... USING(...): 공통 컬럼이 한 번만, 먼저 배치
-- a(id, x), b(id, y)
SELECT * FROM a JOIN b USING (id);
-- 결과 열: id, x, y

-- NATURAL JOIN: 모든 동명 컬럼이 합쳐져 먼저 배치
-- c(u, v), d(v, w)
SELECT * FROM c NATURAL JOIN d;
-- 결과 열: v, u, w

-- USING에 여러 컬럼
SELECT * FROM a JOIN b USING (id, code);
-- 결과 열: id, code, a의 나머지, b의 나머지

-- UNION / UNION ALL: 첫 번째 SELECT의 열 순서·이름이 기준
SELECT id, name FROM t1
UNION ALL
SELECT name, id FROM t2;
-- 결과 열: id, name

-- VIEW + SELECT *: 뷰 생성 시점 열 목록 고정
-- 필요 시에만 실행 권장
CREATE VIEW v_example AS SELECT * FROM a;
ALTER TABLE a ADD COLUMN z int;
SELECT * FROM v_example;  -- z는 보이지 않음