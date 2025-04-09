# HiveQL

## data download

```bash
curl -L -O employees https://www.dropbox.com/scl/fi/v4ce4uz8jo82sr3yg792o/employees?rlkey=npfh5ok3pm0tr63kmtc3oayid&st=88bzfjo9&dl=0
```

## managed table

- 테이블 생성
```sql
CREATE TABLE employees
(
    emp_no     INT,
    birth_date DATE,
    first_name STRING,
    last_name  STRING,
    gender     STRING,
    hire_date  DATE,
    dept_no    STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
```

- 테이블 확인
```bash
SHOW tables;
```

- load data
```sql
LOAD DATA LOCAL INPATH '/Users/m2/damf2/data/employees'
INTO TABLE employees;
```

- 데이터 확인

```sql
SELECT * FROM employees LIMIT 10;
```

- 전체 데이터 확인
```sql
SELECT COUNT(*) FROM employees;
```

- 생일이 같은 사람 수 카운트
```sql
SELECT birth_date, COUNT(birth_date)
FROM employees
GROUP BY birth_date
LIMIT 10;
```

- 테이블 삭제 ⇒ HDFS에 올라간 파일도 같이 삭제
```sql
DROP TABLE employees;
```
