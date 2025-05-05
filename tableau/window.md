# WINDOW 함수
WINDOW_* 함수는 Tableau에서만 사용할 수 있는 Table Calculation 함수
- Tableau 내에서 집계 창 계산(Window Calculation)을 수행할 때 사용되는 특수한 함수들
- 계산 필드에서 테이블 내 데이터를 행, 열, 또는 전체 범위에 대해 계산할 때 사용

### 기본구조
`계산된 필드 만들기`에서 진행
```
WINDOW_FUNCTION(expression, [start, end])
```

# 함수 정의 및 설명

| 함수 | 정의 | 설명 |
|------|------|------|
| `WINDOW_MIN()` | 집계창 범위 내 최소값 | 보통 정규화에 사용 |
| `WINDOW_MAX()` | 집계창 범위 내 최대값 | 보통 정규화에 사용 |
| `WINDOW_AVG()` | 평균 | 전 범위의 평균 |
| `WINDOW_SUM()` | 합계 | 전체 합산 |
| `WINDOW_MEDIAN()` | 중간값 | 중앙값 계산 |
| `WINDOW_VAR()` | 분산 | 전체 분산 |
| `WINDOW_STDEV()` | 표준편차 | 전체 표준편차 |
| `WINDOW_COUNT()` | 갯수 | 전체 항목 수 |
| `WINDOW_PERCENTILE(expr, percentile)` | 분위수 | 예: 0.9 → 90% 분위값 |