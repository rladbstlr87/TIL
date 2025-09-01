# DATA TYPE
- integer: 정수만 저장하는 정밀·범위 고정(주로 16/32/64비트)형
- number(= numeric/decimal 계열): 정밀도(p)와 소수점(scale)을 지정하는 임의정밀 고정소수점형

# DBMS별 요약

| DBMS | integer | number 계열 |
| --- | --- | --- |
| PostgreSQL | smallint/int/bigint(16/32/64비트) | numeric(p,s) 임의정밀 고정소수점               |
| MySQL      | TINYINT\~BIGINT                 | DECIMAL(p,s) 최대 65자리                  |

# 차이점

- 값의 종류: integer는 소수 불가, number는 소수 허용
- 정밀도/범위: integer는 타입 고정, number는 p,s로 조절
- 용도: 카운트/ID/정수 연산은 integer, 금액·환율·정밀 수치는 number

# 예시

- Oracle
  CREATE TABLE t1(id INTEGER, price NUMBER(12,2));
- PostgreSQL
  CREATE TABLE t2(cnt INTEGER, amount NUMERIC(18,4));

선택 기준

- 소수점 필요 없음 → integer
- 소수점·반올림 규칙·자릿수 통제가 필요 → number(numeric/decimal)

요점 먼저 답합니다.

- p,s는 각각 전체 자릿수(precision), 소수 자릿수(scale)입니다. 표기는 (p,s)이며 --둘 다 조절--하는 개념입니다.

  - PostgreSQL: `numeric`, `numeric(p)`, `numeric(p,s)` 모두 가능 (`numeric(p)`이면 `s=0`)
  - MySQL: `DECIMAL[(M[,D])]` 형태 (`DECIMAL(M)`이면 `D=0`, 미지정 시 기본 `DECIMAL(10,0)`)

아래 예시는 MySQL·PostgreSQL만 사용합니다.

# 위경도(좌표) 예시 — number 계열

권장 스펙

- 위도(lat): `±90` 범위 → `NUMERIC(8,6)` / `DECIMAL(8,6)`  (정수 2자리 + 소수 6자리)
- 경도(lng): `±180` 범위 → `NUMERIC(9,6)` / `DECIMAL(9,6)` (정수 3자리 + 소수 6자리)

## PostgreSQL

```sql
CREATE TABLE places_pg (
  id        bigserial PRIMARY KEY,
  name      text NOT NULL,
  lat       numeric(8,6)  NOT NULL,  -- -90.000000 ~ 90.000000
  lng       numeric(9,6)  NOT NULL   -- -180.000000 ~ 180.000000
);

-- 서울시청 좌표(약 37.566535, 126.9779692) → scale=6이므로 소수 7자리 값은 반올림
INSERT INTO places_pg (name, lat, lng)
VALUES ('Seoul City Hall', 37.566535, 126.9779692);

-- 확인: lng는 126.977969로 저장(마지막 자리 반올림)
SELECT name, lat, lng FROM places_pg;

-- 범위 초과 예시: 정수부가 4자리라 정밀도 초과 → 오류
INSERT INTO places_pg (name, lat, lng) VALUES ('Bad', 12.345678, 1234.1);
-- ERROR:  numeric field overflow
```

## MySQL

```sql
CREATE TABLE places_my (
  id   BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  lat  DECIMAL(8,6) NOT NULL,
  lng  DECIMAL(9,6) NOT NULL
);

INSERT INTO places_my (name, lat, lng)
VALUES ('Seoul City Hall', 37.566535, 126.9779692); -- 저장 시 126.977969로 반올림

SELECT name, lat, lng FROM places_my;

-- 정밀도 초과(정수부 4자리) → STRICT 모드면 오류, 아니면 잘림/경고
INSERT INTO places_my (name, lat, lng) VALUES ('Bad', 12.345678, 1234.1);
```

# 정수(integer) vs number 예시

## PostgreSQL

```sql
CREATE TABLE counters_pg (
  id    serial PRIMARY KEY,
  cnt   integer NOT NULL,          -- 소수 불가
  price numeric(12,2) NOT NULL     -- 금액(두 자리 소수)
);

INSERT INTO counters_pg (cnt, price) VALUES (5, 19.99);      -- OK
INSERT INTO counters_pg (cnt, price) VALUES (5.2, 19.999);   -- cnt는 오류, price는 20.00으로 반올림
```

## MySQL

```sql
CREATE TABLE counters_my (
  id    BIGINT PRIMARY KEY AUTO_INCREMENT,
  cnt   INT NOT NULL,
  price DECIMAL(12,2) NOT NULL
);

INSERT INTO counters_my (cnt, price) VALUES (5, 19.99);     -- OK
INSERT INTO counters_my (cnt, price) VALUES (5.2, 19.999);  -- cnt는 오류, price는 20.00으로 반올림
```

# 요약 선택 기준

- 소수점 필요 없음, ID/카운트 → `INT/BIGINT`
- 좌표/금액처럼 소수·자릿 통제가 필요 → `NUMERIC/DECIMAL(p,s)`
  (위도 `NUMERIC(8,6)`, 경도 `NUMERIC(9,6)`이 실무 안전선)