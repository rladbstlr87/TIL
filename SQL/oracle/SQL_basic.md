# SQL 기본 문법 (Oracle 버전)
SQL명령어는 대문자 권장

## ALTER
데이터베이스에서 객체(테이블, 뷰 등)의 구조를 변경하는 명령어

```sql
-- 테이블 이름 변경
RENAME test TO "USER"; -- Oracle에서는 USER가 예약어이므로 큰따옴표로 감싸야 함

-- 컬럼 추가 (Oracle은 TEXT 타입 대신 VARCHAR2 또는 CLOB 사용)
ALTER TABLE "USER" ADD (email VARCHAR2(255));

-- 컬럼 이름 변경
ALTER TABLE "USER" RENAME COLUMN name TO username;
```
- Oracle SQL Developer와 같은 툴에서 GUI를 통해 테이블 구조를 쉽게 변경할 수 있습니다.

## INSERT
값을 직접 삽입할 수 있음
```sql
INSERT INTO movies_movie (title, "YEAR")
VALUES ('dark night', 2008);
```
> title 컬럼에 'dark night'
> year 컬럼에 2008
각각 삽입됨. YEAR 또한 Oracle 예약어이므로 큰따옴표 사용을 권장.

## SELECT FROM
특정 테이블 에서(FROM) 값을 골라온다(SELECT)
```sql
SELECT * FROM movies_user;
-- movies_user 테이블에서 *(전부) 골라온다
```
### ORDER BY
정렬하는 명령어. MySQL과 동일.
```sql
SELECT * FROM movies_movie
ORDER BY "YEAR" ASC;
-- year 컬럼을 기준으로 오름차순(ASC) 정렬
-- 내림차순은 DESC
```
### WHERE
조건문 명령어. MySQL과 동일.
```sql
SELECT MAX(value), AVG(value) FROM movies_score
WHERE movie_id=1;
-- 1번 영화의 최대 평점값, 평균 평점
```
### WHERE LIKE
검색 명령어. MySQL과 동일.
```sql
SELECT * FROM movies_movie
WHERE title LIKE '%the%';
-- title 컬럼의 값들 중 the가 들어가는 값. 근데 앞뒤로 무슨 글자가 들어가던 상관이 없는.
```

### WHERE IN
범위 지정이 아닌 특정 값을 검색하는 명령어. MySQL과 동일.
```sql
SELECT * FROM movies_movie
WHERE "YEAR" IN (2000, 2005, 2010)
ORDER BY "YEAR" ASC;
-- year 컬럼중에 값이 2000, 2005, 2010인 값을 골라오는데 year 컬럼 기준 오름차순 정렬
```
