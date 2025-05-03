# Spark RDD
hadoop의 mapreducing을 spark로 계산하면 상대적으로 매우 빠르다. hadoop은 mapreducing간에 데이터를 분리하고 넘버링하고 카운트하는 중간중간에 GDD에 임시파일을 저장하는 방식을 사용하고 spark는 RAM에 저장하는 방식을 사용하는 것이 원인이라고 이해했다.

## Spark 지원 언어
1. Python(pyspark)
2. Scala(Spark 기본 언어)
3. Java
4. R
5. SQL

## pyspark
제플린 노트북으로 공부해보았다.
1. read file
    ```
    %pyspark
    file_path_HDFS = 'hdfs://localhost:9000/input/text.txt'
    lines = sc.textFile(file_path_HDFS)
    # print(lines.collect())
    
    file_path = 'file:///Users/m2/damf2/data/text.txt'
    lines = sc.textFile(file_path)
    # print(lines.collect())
    ```
2. `-mapper`
    ```
    words = lines.flatMap(lambda line: line.split())
    mapped_words = words.map(lambda word: (word, 1))
    ```

3. `-reducer`
    ```
    reduced_words = mapped_words.reduceByKey(lambda a, b: a+b)
    ```
### log파일로 계산
```
%pyspark

file_path = 'file:///home/ubuntu/damf2/data/logs/2024-01-01.log'
lines = sc.textFile(file_path)
# print(lines.collect())

mapped_lines = lines.map(lambda line: line.split())
# print(mapped_lines.collect())

# 4xx status code 필터링
def filter_4xx(line):
    return line[5][0] == '4'
    
filtered_lines = mapped_lines.filter(filter_4xx)
# print(filtered_lines.collect())

# method('GET', 'POST') 별 요청수 계산
method_rdd = mapped_lines.map(lambda line: (line[2], 1)).reduceByKey(lambda a, b: a+b)
# print(method_rdd.collect())

# 시간대별 요청수
time_rdd = mapped_lines.map(lambda line: (line[1].split(':')[1], 1)).reduceByKey(lambda a, b: a+b)
# print(time_rdd.collect())

# status_code, api method 별 count
count_rdd = mapped_lines.map(lambda line: ((line[5], line[2]), 1)).reduceByKey(lambda a, b: a+b)
print(count_rdd.collect())
```
### RDD(Resilient Distributed Dataset)
Spark에서 데이터를 다루는 가장 기본적인 데이터 형태
- 여러 컴퓨터에 나눠서 저장된 데이터(immutable) 덩어리이면서 데이터를 읽고, 변형(transform), 계산(action) 할 수 있다

- Resilient: 문제가 생겨도 자동으로 복구 가능
- Distributed: 여러 컴퓨터에 분산되어 있음
- Dataset: 데이터의 모음
