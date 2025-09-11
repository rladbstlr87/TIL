# SQL 기본 문법
SQL명령어는 대문자 권장
## ALTER
데이터베이스에서 객체(테이블, 뷰 등)의 구조를 변경하는 명령어
```sql
ALTER TABLE test RENAME TO user;

ALTER TABLE user ADD COLUMN email TEXT;

ALTER TABLE user RENAME COLUMN name TO username;
```
- workbench에서는 테이블에 우클릭하면 alter라는 메뉴 나오는데 거기서 테이블 구조 변경할 수 있는 GUI로 진입할 수 있다
- DBeaver에서는 테이블 더블클릭하면 나오는 우측 화면 윗쪽에 porperties 누르면 구조 변경할 수 있음

## INSERT
값을 직접 삽입할 수 있음
```sql
INSERT INTO movies_movie (title, year)
VALUES ('dark night', 2008);
```
> title 컬럼에 'dark night'
> year 컬럼에 2008
각각 삽입됨

## SELECT FROM
특정 테이블 에서(FROM) 값을 골라온다(SELECT)
```sql
SELECT * FROM movies_user;
-- movies_user 테이블에서 *(전부) 골라온다
```
### ORDER BY
정렬하는 명령어
```sql
SELECT * FROM movies_movie
ORDER BY year ASC;
-- year 컬럼을 기준으로 오름차순(ASC) 정렬
-- 내림차순은 DESC
```
### WHERE
조건문 명령어
```sql
SELECT MAX(value), AVG(value) FROM movies_score
WHERE movie_id=1;
-- 1번 영화의 최대 평점값, 평균 평점
```
### WHERE LIKE
검색 명령어
```sql
SELECT * FROM movies_movie
WHERE title LIKE '%the%';
-- title 컬럼의 값들 중 the가 들어가는 값. 근데 앞뒤로 무슨 글자가 들어가던 상관이 없는.
```

### WHERE IN
범위 지정이 아닌 특정 값을 검색하는 명령어
```sql
SELECT * FROM movies_movie
WHERE year IN (2000, 2005, 2010)
ORDER BY year ASC;
-- year 컬럼중에 값이 2000, 2005, 2010인 값을 골라오는데 year 컬럼 기준 오름차순 정렬
```