-- IFNULL: NULL을 다른 값으로 치환
-- IFNULL(표현식, 대체값)

-- 닉네임이 NULL이면 'Guest' 반환
SELECT IFNULL(nickname, 'Guest') AS display_name
FROM user_profiles;

-- 점수가 NULL인 학생은 0점으로 처리하여 평균 계산
SELECT AVG(IFNULL(score, 0)) AS average_score
FROM exam_results;
