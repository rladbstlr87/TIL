-- MySQL 주요 데이터 타입

-- 문자열
-- VARCHAR(n): 가변 길이 문자열, n은 최대 길이
-- TEXT: 긴 텍스트, 65,535자까지
CREATE TABLE posts_mysql (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
);

-- 숫자
-- INT: 정수
-- DECIMAL(p, s): 고정 소수점, p는 총 자릿수, s는 소수부 자릿수
CREATE TABLE products_mysql (
    id INT,
    price DECIMAL(10, 2)
);

-- 논리
-- BOOLEAN 또는 BOOL: 내부적으로 TINYINT(1)로 처리 (0=false, 1=true)
CREATE TABLE tasks_mysql (
    id INT,
    is_completed BOOLEAN
);
