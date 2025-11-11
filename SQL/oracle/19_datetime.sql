-- Oracle 날짜/시간 타입

-- DATE: 날짜와 시간을 초 단위까지 함께 저장
-- TIMESTAMP: DATE보다 정밀한 시간(소수점 이하 초) 및 타임존 지원
CREATE TABLE logs_oracle (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    event_time DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 현재 날짜 및 시간 삽입
INSERT INTO logs_oracle (event_time) VALUES (SYSDATE);

-- 문자열을 날짜로 변환하여 삽입
-- TO_DATE 함수 사용 권장
INSERT INTO logs_oracle (event_time)
VALUES (TO_DATE('2025-09-30 14:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- 시간 없이 날짜만 사용
-- TRUNC 함수로 시간 부분 제거
SELECT TRUNC(SYSDATE) FROM dual;
