# select_related 로 라인업 N+1 문제 해결
- 템플릿에서 `lineup.pitcher`나 `lineup.hitter`를 참조할 때마다 개별 쿼리가 나가면 N+1 발생
- `select_related`는 한 번의 쿼리에서 점프 조인(LEFT OUTER JOIN)으로 연결된 객체를 미리 가져와 추가 쿼리를 차단

## 쿼리 흐름
- 기존: `Lineup` 테이블만 읽고, 템플릿에서 `lineup.pitcher` 접근 시마다 `Pitcher`를 별도 조회
- 변경: `select_related('pitcher', 'hitter')`가 `Lineup`을 가져올 때 `Pitcher`, `Hitter`를 LEFT OUTER JOIN으로 묶어 한 번에 가져옴

## 실제 데이터로 본 테이블 모습
- `data/lineups.csv`

### 1) 기존 `Lineup.objects.filter(...)` 결과 (조인 없음)
| date     | game_id | batting_order | pitcher_id | hitter_id | stadium |
|----------|---------|---------------|------------|-----------|---------|
| 20250322 | 51      | 1             | 55730      | 1         | 수원    |
| 20250322 | 51      | 2             | 1          | 66704     | 수원    |
| 20250322 | 51      | 3             | 1          | 53764     | 수원    |
| 20250322 | 51      | 4             | 1          | 55734     | 수원    |
| 20250322 | 51      | 5             | 1          | 69737     | 수원    |

### 2) `select_related('pitcher', 'hitter')` 결과 (점프 조인 포함, 개념적)
- `Lineup` 행에 `Pitcher`, `Hitter` 테이블의 열이 함께 붙어 내려옴
- 예시 CSV에는 선수 이름이 없으므로 이름/팀 컬럼은 DB에 채워진 값이라고 가정해 `(DB 값)`으로 표기

| date     | game_id | batting_order | pitcher.id | pitcher.player_name | pitcher.team_name | hitter.id | hitter.player_name | hitter.team_name |
|----------|---------|---------------|------------|---------------------|-------------------|-----------|--------------------|------------------|
| 20250322 | 51      | 1             | 55730      | (DB 값)             | (DB 값)           | 1         | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 2             | 1          | (DB 값)             | (DB 값)           | 66704     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 3             | 1          | (DB 값)             | (DB 값)           | 53764     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 4             | 1          | (DB 값)             | (DB 값)           | 55734     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 5             | 1          | (DB 값)             | (DB 값)           | 69737     | (DB 값)            | (DB 값)          |

## 템플릿 접근 흐름
- 뷰: `lineups = Lineup.objects.select_related('pitcher', 'hitter').filter(game=game).order_by('id')` 실행
- 템플릿: `{% for lineup in user_lineup %}`에서 `lineup.pitcher` 또는 `lineup.hitter`를 바로 사용
- 결과: 별도 DB 왕복 없이 조인된 객체를 활용해 속도 향상, N+1 제거
