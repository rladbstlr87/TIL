-- 선수 스타일 분류 쿼리

-- 1. 타자 스타일 분류
-- Power: HR >= 20
-- Contact: AVG >= 0.300 and PA >= 200
-- Speed: SB >= 25
-- Batting Eye: BB >= 60
-- Normal: 그 외 (PA 100 미만 포함)
SELECT
    player_name,
    team,
    AVG,
    HR,
    SB,
    BB,
    PA,
    CASE
        WHEN PA < 100 THEN 'Normal'
        WHEN HR >= 20 THEN 'Power'
        WHEN AVG >= 0.300 AND PA >= 200 THEN 'Contact'
        WHEN SB >= 25 THEN 'Speed'
        WHEN BB >= 60 THEN 'Batting Eye'
        ELSE 'Normal'
    END AS play_style
FROM
    all_hitter_stats
WHERE
    PA > 0 -- 타석에 들어선 기록이 있는 선수만 조회
ORDER BY
    team,
    play_style,
    HR DESC,
    AVG DESC,
    SB DESC,
    BB DESC;

-- 2. 투수 스타일 분류
-- Power Pitcher (구속): speed >= 148 km/h
-- Stamina (체력): QS >= 15
-- Control (제구): WHIP <= 1.25 and IP >= 50
-- Normal: 그 외 (IP 30 미만 포함)
SELECT
    player_name,
    team,
    ERA,
    speed,
    IP,
    QS,
    WHIP,
    CASE
        WHEN IP < 30 THEN 'Normal'
        WHEN speed >= 148 THEN 'Power Pitcher'
        WHEN QS >= 15 THEN 'Stamina'
        WHEN WHIP <= 1.25 AND IP >= 50 THEN 'Control'
        ELSE 'Normal'
    END AS pitch_style
FROM
    all_pitcher_stats
WHERE
    IP > 0 -- 등판 기록이 있는 선수만 조회
ORDER BY
    team,
    pitch_style,
    speed DESC,
    QS DESC,
    WHIP ASC;
