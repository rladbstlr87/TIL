# Spark로 ML 모델 만들기
python 머신 러닝과 약간의 차이가 있다

## Regression
### path
하둡에서 불러와보자
```
file_path = 'hdfs://localhost:9000/input/fish.csv'
df = spark.read.csv(file_path, header=True, inferSchema=True)
```
- inferSchema :  컬럼의 값들을 보고 데이터 타입을 알아서 적당히 지정해줌(알아서 적당히라서 틀릴 수도 있음)

## Feature
학습 모델에 입력될 수 있는 덩어리로 만드는 모듈. 수치형이나 벡터형 데이터를 만들기 위한 전처리 도구들이 있다(Spark ML에서는 학습 모델에 반드시 숫자 또는 벡터 형태의 feature만 사용할 수 있기 떄문)
```
from pyspark.ml.feature import StringIndexer
indexer = StringIndexer(inputCols=['Species'], outputCols=['species_idx'])
df = indexer.fit(df).transform(df)
```
- inputCols : 범주형 문자열 컬럼
- outputCols : 해당 범주에 대해 자동으로 부여한 인덱스 숫자 컬럼 (0부터 시작)

ex:
|Species|species_idx|
|---|---|
|Bream|0.0|
|Pike|1.0|
|Roach|2.0|
- 원핫인코딩이랑 비슷한 역할을 한다