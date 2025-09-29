# NPS (Net Promoter Score)

## 1. 정의

-- 고객 충성도와 만족도를 측정하는 지표
-- "우리 제품/서비스를 다른 사람에게 얼마나 추천하고 싶으신가요?" (0-10점 척도) 질문을 통해 측정
-- 점수에 따라 고객을 세 그룹으로 분류:
    -- 추천 고객 (Promoters, 9-10점): 적극적으로 추천할 의향이 있는 충성 고객
    -- 중립 고객 (Passives, 7-8점): 만족은 하지만 열성적이지 않으며, 경쟁 제품으로 쉽게 이동 가능
    -- 비추천 고객 (Detractors, 0-6점): 불만족 경험을 가졌으며, 부정적 입소문을 낼 수 있는 고객

---

## 2. 계산 공식

-- NPS = (적극적 추천 그룹 - 비추천 그룹) / 전체 응답자

`NPS = ((Number of Promoters - Number of Detractors) / Total Respondents) * 100`

---

## 3. SQL 예시 쿼리

-- `survey_responses` 테이블에 `user_id`, `score` (0-10점) 컬럼이 있다고 가정

```sql
-- 특정 기간(예: 1월)의 NPS 계산
WITH ScoreGroups AS (
    -- 1. 점수별로 그룹 분류
    SELECT
        CASE
            WHEN score >= 9 THEN 'Promoter'
            WHEN score >= 7 THEN 'Passive'
            ELSE 'Detractor'
        END AS score_group
    FROM
        survey_responses
    WHERE
        response_date BETWEEN '2025-01-01' AND '2025-01-31'
),
GroupCounts AS (
    -- 2. 그룹별 인원수 및 전체 응답자 수 계산
    SELECT
        COUNT(CASE WHEN score_group = 'Promoter' THEN 1 END) AS promoter_count,
        COUNT(CASE WHEN score_group = 'Detractor' THEN 1 END) AS detractor_count,
        COUNT(*) AS total_responses
    FROM
        ScoreGroups
)
-- 3. NPS 점수 계산
SELECT
    ROUND(
        (promoter_count * 100.0 / total_responses) - (detractor_count * 100.0 / total_responses),
    2) AS nps
FROM
    GroupCounts;
```
