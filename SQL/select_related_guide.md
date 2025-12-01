# select_related 로 라인업 N+1 문제 해결
- 라인업 템플릿이 FK를 매 행 조회하며 발생한 N+1을 `select_related`로 제거한 기록
- 한 번의 쿼리에서 LEFT OUTER JOIN으로 연결된 객체를 미리 가져와 웹서버 워커/DB 커넥션 점유 문제를 해소

## 배경
- 증상: 8월 경 라인업 페이지가 느려지다가, 라인업을 열지 않아도 다른 페이지까지 500/타임아웃 확산
- 원인: 라인업 뷰의 `select_related` 누락으로 FK를 반복 조회, `Hitter_Daily.objects.all()`/`Pitcher_Daily.objects.all()` 전체 스캔까지 겹쳐 요청 시간이 길어짐
- 조치: `select_related('pitcher', 'hitter')`로 FK를 선조인하고, 필요한 player_id만 필터링해 풀스캔을 제거

## 발생 지점
- 요청 흐름: `/cal/calendar/<game_id>/` → `cal/views.py:lineup` → `cal/templates/lineup.html`
- 문제: `Lineup.objects.filter(game=game)` 결과만 전달한 뒤 템플릿 파셜에서 `lineup.pitcher.*`, `lineup.hitter.*`를 매 행마다 조회해 N+1 발생
- 증폭: 동일 FK 필드를 이미지·스탯·스티커용으로 반복 접근해 같은 라인업에서도 FK 쿼리가 중복

## 쿼리 흐름 (FK 조회 전/후)
### select_related 적용 전
- 기본 1회 라인업 + FK 접근 20회(투수 2, 타자 18) = 렌더링 중 21회 쿼리
```sql
SELECT * FROM lineup WHERE game_id = ? ORDER BY id;

SELECT * FROM pitcher WHERE id = ?; -- 두 팀 선발
SELECT * FROM hitter  WHERE id = ?; -- 타자 18명
```

### select_related 적용 후
- 한 번의 LEFT OUTER JOIN으로 FK를 미리 붙여 추가 FK 쿼리 제거
```sql
SELECT lineup.*
     , pitcher.*
     , hitter.*
FROM lineup
LEFT OUTER JOIN pitcher ON lineup.pitcher_id = pitcher.id
LEFT OUTER JOIN hitter  ON lineup.hitter_id  = hitter.id
WHERE game_id = ?
ORDER BY lineup.id;
```

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

### 2) `select_related('pitcher', 'hitter')` 결과 (LEFT OUTER JOIN 포함, 개념적)
- `Lineup` 행에 `Pitcher`, `Hitter` 테이블의 열이 함께 붙어 내려옴
- 예시 CSV에는 선수 이름이 없으므로 이름/팀 컬럼은 DB에 채워진 값이라고 가정해 `(DB 값)`으로 표기

| date     | game_id | batting_order | pitcher.id | pitcher.player_name | pitcher.team_name | hitter.id | hitter.player_name | hitter.team_name |
|----------|---------|---------------|------------|---------------------|-------------------|-----------|--------------------|------------------|
| 20250322 | 51      | 1             | 55730      | (DB 값)             | (DB 값)           | 1         | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 2             | 1          | (DB 값)             | (DB 값)           | 66704     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 3             | 1          | (DB 값)             | (DB 값)           | 53764     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 4             | 1          | (DB 값)             | (DB 값)           | 55734     | (DB 값)            | (DB 값)          |
| 20250322 | 51      | 5             | 1          | (DB 값)             | (DB 값)           | 69737     | (DB 값)            | (DB 값)          |

- 투수 행에서는 `hitter.*`가 NULL, 타자 행에서는 `pitcher.*`가 NULL로 채워지는 형태 (LEFT OUTER JOIN 특성)

## 템플릿 접근 흐름
- 뷰: `lineups = Lineup.objects.select_related('pitcher', 'hitter').filter(game=game).order_by('id')` 실행
- 템플릿: `{% for lineup in user_lineup %}`에서 `lineup.pitcher` 또는 `lineup.hitter`를 바로 사용
- 결과: 별도 DB 왕복 없이 조인된 객체를 활용해 속도 향상, N+1 제거
