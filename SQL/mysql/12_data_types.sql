-- MySQL 주요 데이터 타입

-- 문자열 타입
-- VARCHAR(n): 가변 길이 문자열, n은 최대 길이. 행 크기 제한에 영향을 받음.
-- TEXT: 긴 텍스트, 최대 65,535자.
CREATE TABLE posts_mysql (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
);

-- 숫자 타입
-- INT: 일반적인 정수 (4바이트).
-- DECIMAL(p, s): 고정 소수점 숫자. 금융 계산처럼 정확한 정밀도가 필요할 때 사용. p는 총 자릿수, s는 소수부.
CREATE TABLE products_mysql (
    id INT,
    price DECIMAL(10, 2)
);

-- 논리 타입
-- BOOLEAN 또는 BOOL: 내부적으로 TINYINT(1)로 처리 (0=false, 1=true).
CREATE TABLE tasks_mysql (
    id INT,
    is_completed BOOLEAN
);
INSERT INTO tasks_mysql VALUES (1, TRUE);