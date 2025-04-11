# 데이터 전처리
- csv 구분자 "," 아닌 ";"의 경우, 값에 "가 있는 경우 "\""으로 Serde properties 진행
```sql
CREATE EXTERNAL TABLE books (
  ISBN STRING,
  Book_Title STRING,
  Book_Author STRING,
  Year_Of_Publication INT,
  Publisher STRING,
  Image_URL_S STRING,
  Image_URL_M STRING,
  Image_URL_L STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ";",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/input/book/books';

CREATE EXTERNAL TABLE ratings (
  User_ID INT,
  ISBN STRING,
  Book_Rating INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ";",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/input/book/ratings';

CREATE EXTERNAL TABLE users (
  User_ID INT,
  Location STRING,
  Age INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ";",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/input/book/users';
```

## VIEW
- DataFrame에서 `df.copy()`한 효과
```sql
CREATE VIEW books_view AS
SELECT
  ISBN,
  Book_Title,
  Book_Author,
  CAST(Year_Of_Publication AS INT) AS Year_Of_Publication,
  Publisher,
  Image_URL_S,
  Image_URL_M,
  Image_URL_L
FROM books;

---

CREATE VIEW ratings_view AS
SELECT
  CAST(User_ID AS INT) AS User_ID,
  ISBN,
  CAST(Book_Rating AS INT) AS Book_Rating
FROM ratings;

---

CREATE VIEW users_view AS
SELECT
  CAST(User_ID AS INT) AS User_ID,
  Location,
  CAST(Age AS INT) AS Age
FROM users;
```
# 문제
## 1. 데이터의 기초 정보 확인
### 1-1. Books 테이블에서 중복된 ISBN 확인
```sql
SELECT isbn, COUNT(*)
FROM books_view
GROUP BY isbn
HAVING COUNT(*)>1;
```
### 1-2. Users 테이블에서 Age의 결측값 확인
```sql
SELECT COUNT(*)
FROM users_view
WHERE age IS NULL;
```
## 2. 데이터의 기초 통계 확인
### 2-1. 사용자 연령의 기초 통계(최소, 최대, 평균)를 확인
```sql
SELECT MIN(age), MAX(age), AVG(age)
FROM users_view;
```
### 2.2 책의 출판 연도에 대한 기초 통계(최소, 최대, 평균)를 확인
```sql
SELECT MIN(year_of_publication), MAX(year_of_publication), AVG(year_of_publication)
FROM books_view;
```
### 2.3 평점의 분포 확인
```sql
SELECT book_rating, COUNT(*)
FROM ratings_view
GROUP BY book_rating;
--WHERE book_rating.user_id IS NOT NULL;
```
## 3. 데이터의 주요 패턴 탐색
### 3-1. 출판사별로 얼마나 많은 책이 있는지, 그리고 그 책들의 평균 평점이 어떤지 확인
```sql
SELECT bv.publisher, COUNT(bv.book_title), AVG(rv.book_rating)
FROM books_view bv JOIN ratings_view rv 
ON bv.isbn = rv.isbn
GROUP BY bv.publisher
ORDER BY COUNT(bv.book_title) DESC
LIMIT 10;
```
### 3.2 가장 많이 평가된 책이 무엇인지 확인
```sql
SELECT bv.book_title, COUNT(rv.book_rating), AVG(rv.book_rating)
FROM books_view bv JOIN ratings_view rv 
ON bv.isbn = rv.isbn
GROUP BY bv.book_title
ORDER BY COUNT(rv.book_rating) DESC
LIMIT 10;
```
## 4. 데이터 관계 분석
### 4.1 책의 출판 연도와 평점 간의 관계를 확인
```sql
SELECT bv.year_of_publication, AVG(rv.book_rating)
FROM books_view bv JOIN ratings_view rv
ON bv.isbn = rv.isbn
GROUP BY bv.year_of_publication;
```
### 4.2 사용자 위치별 평점 차이
--위치(location)에 따라 평균 평점을 출력합니다. 적어도 10개 이상의 평가를 한 경우만 출력
```sql
SELECT uv.location, AVG(rv.book_rating), COUNT(rv.book_rating)
FROM users_view uv JOIN ratings_view rv 
ON uv.user_id = rv.user_id
GROUP BY uv.location
HAVING COUNT(rv.user_id)>=10
ORDER BY AVG(rv.book_rating) DESC;
```
### 4.3 ## 책 저자별 평균 평점
--각 저자별로 평균 평점이 어떻게 다른지 확인합니다. 적어도 10개 이상의 평가를 한 경우만 출력
```sql
SELECT bv.book_author, AVG(rv.book_rating), COUNT(rv.book_rating)
FROM books_view bv JOIN ratings_view rv 
ON bv.isbn = rv.isbn
GROUP BY bv.book_author 
HAVING COUNT(bv.book_author)>10
ORDER BY AVG(rv.book_rating) DESC;
```
