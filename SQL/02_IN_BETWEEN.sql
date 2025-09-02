-- IN : 컬럼 안에 특정 값이 있는지 확인
-- 여러개중 하나라도 일치하는 값이 있으면 가져옴
SELECT *
FROM cal_lineup
WHERE stadium_id IN ('잠실', '고척') -- 괄호는 필수고 숫자형이면 따옴표 없어도 됨
limit 10;

-- 고척 - 위도: 37.4949° 경도: 126.8752°
SELECT *
FROM cal_stadium
WHERE lat >= 37 AND lat <= 37.5;

-- BETWEEN : 특정 범위 안에 값이 있는지 확인
-- 시작값과 종료값을 포함하는 값을 조회한다(이상, 이하)
SELECT *
FROM cal_stadium
WHERE lat BETWEEN 37 AND 37.5;

SELECT *
FROM cal_game
WHERE date BETWEEN '2025-08-01' AND '2025-08-31';
-- 날짜는 숫자와 다르므로 따옴표 해줘야 함