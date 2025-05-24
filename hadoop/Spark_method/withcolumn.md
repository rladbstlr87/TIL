# PySpark DataFrame 메서드
## 1. withColumn 메서드
```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit

# SparkSession 생성
spark = SparkSession.builder.appName("WithColumnExample").getOrCreate()

# 샘플 데이터 생성
data = [("Alice", 25), ("Bob", 30), ("Charlie", 35)]
df = spark.createDataFrame(data, ["name", "age"])
```

### 기본구조
```python
df.withColumn(추가하거나 대체할 칼럼의 이름, col(컬럼명))
```

- DataFrame에 새로운 칼럼을 추가하거나 기존 칼럼을 대체하는 메서드
- 지정된 컬럼 표현식을 기반으로 새 칼럼을 추가하거나 기존 칼럼을 대체하여 새로운 DataFrame을 반환하는 메서드

### For example
#### ex.1-1: 간단한 칼럼 추가
```python
# 상수 값을 가진 새로운 칼럼 추가
df_with_country = df.withColumn("country", lit("Korea"))
df_with_country.show()
```
|   name|age|country|
|-------|---|------|
|  Alice| 25| Korea|
|    Bob| 30| Korea|
|Charlie| 35| Korea|


#### ex.1-2: 기존 칼럼 연산으로 새 칼럼 생성
```python
# 기존 칼럼을 활용한 새 칼럼 생성
df_with_next_year_age = df.withColumn("next_year_age", col("age") + 1)
df_with_next_year_age.show()
```
|   name|age|next_year_age|
|-------|---|-------------|
|  Alice| 25|           26|
|    Bob| 30|           31|
|Charlie| 35|           36|

#### ex.1-3: 기존 칼럼 대체
```python
# 기존 칼럼을 대체
df_age_updated = df.withColumn("age", col("age") + 5)
df_age_updated.show()
```
|   name|age|
|-------|---|
|  Alice| 30|
|    Bob| 35|
|Charlie| 40|

### What it can do?
#### ex.level.2: 조건부 칼럼 추가
- 조건식을 사용하여 새로운 칼럼을 생성할 수 있습니다.
```python
from pyspark.sql.functions import when, col

# 나이에 따른 카테고리 분류
df_with_category = df.withColumn(
    "age_category",
    when(col("age") < 30, "Young")
    .when(col("age") < 40, "Middle")
    .otherwise("Senior")
)
df_with_category.show()
```
|   name|age|age_category|
|-------|---|------------|
|  Alice| 25|       Young|
|    Bob| 30|      Middle|
|Charlie| 35|      Middle|
