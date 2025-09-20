-- IN : 컬럼 안에 특정 값이 있는지 확인
-- 여러개중 하나라도 일치하는 값이 있으면 가져옴
-- LIMIT 키워드를 지원하지 않으며, ROWNUM 또는 FETCH FIRST N ROWS ONLY를 사용
SELECT *
FROM cal_lineup
WHERE stadium_id IN ('잠실', '고척') -- 괄호는 필수고 숫자형이면 따옴표 없어도 됨
FETCH FIRST 10 ROWS ONLY;

-- ROWNUM을 사용하는 구식 방법
/*
SELECT *
FROM (
    SELECT *
    FROM cal_lineup
    WHERE stadium_id IN ('잠실', '고척')
)
WHERE ROWNUM <= 10;
*/

-- 고척 - 위도: 37.4949° 경도: 126.8752°
SELECT *
FROM cal_stadium
WHERE lat >= 37 AND lat <= 37.5;

-- BETWEEN : 특정 범위 안에 값이 있는지 확인
-- 시작값과 종료값을 포함하는 값을 조회한다(이상, 이하)
SELECT *
FROM cal_stadium
WHERE lat BETWEEN 37 AND 37.5;

-- Oracle에서는 문자열을 날짜로 비교할 때 TO_DATE 함수를 명시적으로 사용하는 것이 안전
SELECT *
FROM cal_game
WHERE "DATE" BETWEEN TO_DATE('2025-08-01', 'YYYY-MM-DD') AND TO_DATE('2025-08-31', 'YYYY-MM-DD');
-- 날짜는 숫자와 다르므로 따옴표 해줘야 함
-- Oracle에서 DATE는 예약어이므로 컬럼명이 DATE라면 큰따옴표로 감싸야 할 수 있음
