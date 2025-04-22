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

### StringIndexer
학습 모델에 입력될 수 있는 덩어리로 만드는 모듈. 수치형이나 벡터형 데이터를 만들기 위한 전처리 도구들이 있다(Spark ML에서는 학습 모델에 반드시 숫자 또는 벡터 형태의 feature만 사용할 수 있기 떄문)
```
from pyspark.ml.feature import StringIndexer
indexer = StringIndexer(inputCols=['Species'], outputCols=['species_idx'])
df = indexer.fit(df).transform(df)
```
- inputCols : 범주형 문자열 컬럼
- outputCols : 해당 범주에 대해 자동으로 부여한 인덱스 숫자 컬럼 (0부터 시작. 값의 빈도수 기준으로 높은 값부터 낮은 값 순으로 인덱스를 할당)

ex:
|Species|species_idx|
|---|---|
|Bream|0.0|
|Pike|1.0|
|Roach|2.0|
- 원핫인코딩이랑 비슷한 역할을 한다
#### OneHotEncoder
```
from pyspark.ml.feature import OneHotEncoder
encoder = OneHotEncoder(inputCols=['species_idx'], outputCols=['species_ohe'])
df = encoder.fit(df).transform(df)
```
### VevtorAssembler
- 여러 개의 컬럼(피처)을 하나의 벡터 컬럼으로 결합해주는 PySpark의 전처리 도구
- Spark ML의 대부분 알고리즘은 입력을 벡터형 feature column으로 요구하기 때문에 필수
```
from pyspark.ml.feature import VectorAssembler
assembler = VectorAssembler(
    inputCols=[
        'species_ohe', 
        'Length1',
        'Length2',
        'Length3',
        'Height',
        'Width'
    ], 
    outputCol='features'
)
df = assembler.transform(df)
```
- inputCols: 결합하고자 하는 여러 피처 컬럼 이름 (리스트)
- outputCol: 결합된 벡터 컬럼 이름 (주로 "features")

### 데이터 분할
DataFrame을 무작위로 분할하여 학습용(train)과 테스트용(test) 데이터를 생성
```
train_data, test_data = df.randomSplit([0.8, 0.2])
```
실행할 때마다 분할한 데이터의 count가 달라질 수 있는데 시드설정하면 매번 같은 값 나옴
#### Seed
```
train_data, test_data = df.randomSplit([0.8, 0.2], seed=42)
```
##### 42의 유래: 문화적 배경 by GPT
> "42"는 더글라스 아담스의 소설
> **《은하수를 여행하는 히치하이커를 위한 안내서(The Hitchhiker's Guide to the Galaxy)》**에서 등장합니다.

> 이 소설에서 **“삶, 우주, 모든 것에 대한 궁극적인 해답(The Answer to the Ultimate Question of Life, the Universe, and Everything)”**은 바로...
👉 42

> 그런데 이게 진지한 답이 아니고 작가가 일부러 의미 없이 넣은 농담이에요.
> 그 뒤로 개발자들 사이에서 “의미 없는 기본값” 혹은 “무작위 예시 숫자”로 42가 자주 쓰이기 시작했죠.
