-- MySQL 날짜/시간 타입

-- DATE: 날짜만 저장 (YYYY-MM-DD)
-- DATETIME: 날짜와 시간 저장 (YYYY-MM-DD HH:MI:SS)
-- TIMESTAMP: 타임존 정보 사용, 1970-2038년 범위
CREATE TABLE logs_mysql (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_date DATE,
    event_time DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 현재 날짜 및 시간 삽입
INSERT INTO logs_mysql (event_date, event_time) VALUES (CURDATE(), NOW());

-- 문자열로 삽입
INSERT INTO logs_mysql (event_time) VALUES ('2025-09-30 14:30:00');
