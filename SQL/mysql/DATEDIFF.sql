-- DATEDIFF: 두 날짜 사이의 일수 차이 계산
SELECT DATEDIFF('2025-09-13', '2025-09-10') AS day_difference;

-- 오늘 날짜와 특정 날짜 사이의 일수 차이 계산
SELECT DATEDIFF(CURDATE(), '2025-01-01') AS days_from_new_year;

-- CURDATE: CURRENT_DATE의 줄임말, 현재 날짜를 'YYYY-MM-DD' 형식으로 반환
SELECT CURDATE();

-- CURTIME: CURRENT_TIME의 줄임말, 현재 시간을 'HH:MM:SS' 형식으로 반환
SELECT CURTIME();

-- 문자열을 날짜로 자동 형 변환하여 계산
-- 'YYYY-MM-DD' 형식의 문자열은 DATE 타입으로 자동 변환됨
SELECT DATEDIFF('2025-10-20', '2025-10-15');

-- MySQL 날짜 함수와 함께 사용시 자동으로 날짜로 인식되는 주요 문자열 형식
-- YYYY-MM-DD, YY-MM-DD, YYYYMMDD, YYMMDD 등
SELECT DATEDIFF(CURDATE(), '2024-01-01');
SELECT DATEDIFF(CURDATE(), '24-01-01');
SELECT DATEDIFF(CURDATE(), '20240101');
SELECT DATEDIFF(CURDATE(), '240101');