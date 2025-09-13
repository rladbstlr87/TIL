-- Oracle에서는 두 날짜를 빼서 일수 차이를 계산
SELECT TRUNC(SYSDATE) - TO_DATE('2025-01-01', 'YYYY-MM-DD') AS days_from_new_year
FROM dual;

-- 날짜 간의 차이를 소수점 없이 정수로 확인
SELECT FLOOR(SYSDATE - TO_DATE('2025-09-10', 'YYYY-MM-DD')) AS day_difference
FROM dual;

-- SYSDATE: 현재 서버의 날짜와 시간을 반환 (DATE 타입)
SELECT SYSDATE FROM dual;

-- TRUNC(SYSDATE): SYSDATE에서 시간 부분을 제거하고 날짜만 반환
SELECT TRUNC(SYSDATE) FROM dual;

-- 문자열을 날짜로 변환 시 TO_DATE 함수를 명시적으로 사용해야 함
-- 자동 형 변환에 의존하는 것은 권장되지 않음
SELECT TO_DATE('2025-10-20', 'YYYY-MM-DD') - TO_DATE('2025-10-15', 'YYYY-MM-DD') FROM dual;

-- TO_DATE와 함께 사용하는 다양한 날짜 형식 지정자
SELECT TO_DATE('2024/01/01 15:30:00', 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_DATE('24-JAN-2024', 'DD-MON-YYYY') FROM dual;