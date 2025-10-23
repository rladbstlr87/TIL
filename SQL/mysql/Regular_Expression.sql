-- 정규 표현식(Regular Expression)

-- 앵커 (Anchors)
-- ^: 문자열의 시작
-- 'Hello'로 시작하면 true
SELECT 'Hello, world' REGEXP '^Hello';
-- 'Hello'로 시작하지 않으면 false
SELECT 'Hi, Hello, world' REGEXP '^Hello';
-- $: 문자열의 종료
-- 'world'로 끝나면 true
SELECT 'Hello, world' REGEXP 'world$';
-- 'world'로 끝나지 않으면 false
SELECT 'Hello, world' REGEXP 'world$';
-- .: 임의의 한 글자
-- w와 d 사이에 세 글자 있으면 true
SELECT 'Hello, world' REGEXP 'w...d';
-- w와 d 사이에 한 글자만 있으면 false
SELECT 'Hello, world' REGEXP 'w.d';
-- |: OR
-- 'Hello' 또는 'Hi'가 있으면 true
SELECT 'Hello, world' REGEXP 'Hello|Hi';
-- 'Hello' 또는 'Hi'가 없으면 false
SELECT 'Bye, world' REGEXP 'Hello|Hi';

-- 수량자 (Quantifiers)
-- *: 0개 이상 반복
SELECT 'ct' REGEXP 'ca*t';
SELECT 'cat' REGEXP 'ca*t';
SELECT 'caaat' REGEXP 'ca*t';
-- +: 1개 이상 반복
SELECT 'cat' REGEXP 'ca+t';
SELECT 'ct' REGEXP 'ca+t'; -- false
-- ?: 0개 또는 1개
SELECT 'ct' REGEXP 'ca?t';
SELECT 'cat' REGEXP 'ca?t';
SELECT 'caat' REGEXP 'ca?t'; -- false
-- {x}: x번 반복
SELECT 'dataa' REGEXP 'data{2}';
SELECT 'data' REGEXP 'data{2}'; -- false
-- {x,}: x번 이상 반복
SELECT 'dataaa' REGEXP 'data{2,}';
SELECT 'data' REGEXP 'data{2,}'; -- false
-- {x,y}: x번 이상 y번 이하 반복
SELECT 'dataaaa' REGEXP 'data{2,5}';
SELECT 'dataaaaaa' REGEXP 'data{2,5}'; -- false

-- 그룹 (Grouping)
-- (): 표현식 그룹화
SELECT 'datarian' REGEXP 'data(rian)';
SELECT 'data' REGEXP 'data(rian)'; -- false

-- 문자 클래스 (Character Classes)
-- [abc]: 대괄호 안의 문자 중 하나
SELECT 'datar' REGEXP 'data[rian]';
SELECT 'datax' REGEXP 'data[rian]'; -- false
-- [^abc]: 대괄호 안의 문자를 제외
SELECT 'datat' REGEXP 'data[^rian]';
SELECT 'datar' REGEXP 'data[^rian]'; -- false

-- 이스케이프 시퀀스 (Character Class Escapes)
-- \d: 숫자 ([0-9]와 동일)
SELECT '123' REGEXP '\\d+';
SELECT 'abc' REGEXP '\\d+'; -- false
-- \w: 단어 문자 (알파벳, 숫자, 밑줄)
SELECT 'abc123_' REGEXP '\\w+';
SELECT '!!' REGEXP '\\w+'; -- false
-- \s: 공백 문자
SELECT 'a b' REGEXP 'a\\sb';
SELECT 'ab' REGEXP 'a\\sb'; -- false
