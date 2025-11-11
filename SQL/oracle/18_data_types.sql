-- Oracle 주요 데이터 타입

-- 문자열 타입
-- VARCHAR2(n): 가변 길이 문자열, n은 바이트 수. VARCHAR도 있지만 VARCHAR2 사용이 표준.
-- CLOB: 매우 큰 텍스트 데이터 (최대 4GB).
CREATE TABLE posts_oracle (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    title VARCHAR2(255),
    content CLOB
);

-- 숫자 타입
-- NUMBER(p, s): 정수와 실수를 모두 저장할 수 있는 유연한 숫자 타입. p는 총 자릿수, s는 소수부.
-- INTEGER: NUMBER(38,0)의 서브타입.
CREATE TABLE products_oracle (
    id NUMBER,
    price NUMBER(10, 2)
);

-- 논리 타입 (Boolean)
-- SQL에서 BOOLEAN 타입이 직접 지원되지 않음.
-- NUMBER(1) 또는 CHAR(1) ('Y'/'N')로 대체하여 사용.
CREATE TABLE tasks_oracle (
    id NUMBER,
    is_completed NUMBER(1) CHECK (is_completed IN (0, 1)) -- 0: false, 1: true
);
INSERT INTO tasks_oracle VALUES (1, 1);