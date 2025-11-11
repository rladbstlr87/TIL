-- MySQL에서는 SELECT 절에서 지정한 별칭(hitter_type, pitcher_type)을
-- GROUP BY와 ORDER BY 절에서 바로 사용 가능

-- 전환율 개념을 응용한 타자/투수 유형 퍼널 분석

-- 타자 유형 퍼널 분석
-- -- 규정 타석(PA)을 채운 타자를 대상으로, 정규화된 능력치에 따라 순차적으로 유형을 분류
-- -- 1. 파워형: power >= 0.7
-- -- 2. 컨택형: contact >= 0.9
-- -- 3. 스피드형: speed >= 0.8
-- -- 4. 선구안형: batting_eye >= 0.9
-- -- 5. 노멀: 위 조건에 해당하지 않는 모든 타자
SELECT
    CASE
        WHEN power >= 0.7 THEN '파워형'
        WHEN contact >= 0.9 THEN '컨택형'
        WHEN speed >= 0.8 THEN '스피드형'
        WHEN batting_eye >= 0.9 THEN '선구안형'
        ELSE '노멀'
    END AS hitter_type,
    COUNT(*) AS player_count
FROM all_hitter_stats
WHERE PA >= 144 -- KBO 규정 타석(시즌 경기 수 * 3.1)에 준하는 기준으로 필터링
GROUP BY hitter_type
ORDER BY
    CASE hitter_type
        WHEN '파워형' THEN 1
        WHEN '컨택형' THEN 2
        WHEN '스피드형' THEN 3
        WHEN '선구안형' THEN 4
        ELSE 5
    END;

-- -- 투수 유형 분류 퍼널 분석
-- -- 규정 이닝(IP)을 채운 투수를 대상으로, 정규화된 능력치에 따라 순차적으로 유형을 분류
-- -- 1. 파이어볼러: fireball >= 0.98
-- -- 2. 제구형: control >= 0.8
-- -- 3. 체력형: stamina >= 0.8
-- -- 4. 노멀: 위 조건에 해당하지 않는 모든 투수
SELECT
    CASE
        WHEN fireball >= 0.98 THEN '파이어볼러'
        WHEN control >= 0.8 THEN '제구형'
        WHEN stamina >= 0.8 THEN '체력형'
        ELSE '노멀'
    END AS pitcher_type,
    COUNT(*) AS player_count
FROM all_pitcher_stats
WHERE IP >= 100 -- 100 이닝 이상 투구한 투수를 대상으로 필터링
GROUP BY pitcher_type
ORDER BY
    CASE pitcher_type
        WHEN '파이어볼러' THEN 1
        WHEN '제구형' THEN 2
        WHEN '체력형' THEN 3
        ELSE 4
    END;