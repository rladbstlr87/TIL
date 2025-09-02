-- 여러개중 하나라도 일치하는 값이 있으면 가져옴
SELECT *
FROM cal_lineup
WHERE stadium_id IN ('잠실', '고척')
limit 10;

-- 괄호는 필수고 숫자형이면 따옴표 없어도 됨