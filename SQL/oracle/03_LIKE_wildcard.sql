-- MySQL과 동일한 표준 SQL 구문으로 Oracle에서도 대부분 동일하게 작동합니다.
-- LIKE : 와일드카드로 만든 패턴과 일치하는 데이터 검색

-- LIKE와 % 사용법
-- '김%': '김'으로 시작하는 모든 문자열
-- '%김': '김'으로 끝나는 모든 문자열
-- '%김%': '김'이 포함된 모든 문자열

-- lineups 테이블에서 '잠'으로 시작하는 경기장(stadium) 조회
SELECT * FROM lineups
WHERE stadium LIKE '잠%';

-- all_hitter_stats 테이블에서 이름에 '민'이 포함된 모든 선수 조회
SELECT player_name, team FROM all_hitter_stats
WHERE player_name LIKE '%민%';

-- '김_': '김'으로 시작하는 두 글자 이름
-- '김__': '김'으로 시작하는 세 글자 이름

-- all_hitter_stats 테이블에서 '김'씨 성을 가진 세 글자 이름의 선수 조회
SELECT player_name, team FROM all_hitter_stats
WHERE player_name LIKE '김__';


-- NOT LIKE : 지정된 패턴과 일치하지 않는 데이터만 조회
-- lineups 테이블에서 '잠실'이 아닌 다른 모든 경기장 정보 조회
SELECT DISTINCT stadium FROM lineups
WHERE stadium NOT LIKE '잠%';


-- 비교 연산자를 이용한 검색
-- LIKE, 특히 맨 앞에 %를 사용하는 패턴 매칭은 인덱스를 사용하지 못해 성능이 저하될 수 있음
-- (Full Table Scan)

-- 이런 경우 비교 연산자를 사용하면 더 빠른 검색이 가능

-- lineups 테이블에서 '잠'으로 시작하는 경기장(stadium) 조회
-- >= '잠': '잠'을 포함하여 '잠'으로 시작하는 모든 값
-- < '자': '자' 이전의 모든 값 (다음 글자인 '자'는 포함하지 않음)
-- 결과적으로 '잠'으로 시작하는 모든 값을 효율적으로 검색
SELECT * FROM lineups
WHERE stadium >= '잠' AND stadium < '자';
