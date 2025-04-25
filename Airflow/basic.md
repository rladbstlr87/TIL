# Airflow
작업 간 자동화

## 유향 비순환 그래프(有向 非循環 graph, directed acyclic graph, **DAG**)
유향 비순환 그래프 및 방향 비순환 그래프(方向 非循環 graph)는 수학, 컴퓨터 과학 분야의 용어의 하나로서 방향 순환이 없는 무한 유향 그래프이다.
![DAG](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Topological_Ordering.svg/500px-Topological_Ordering.svg.png)

### 기본구조
```py
from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.python_operator import PythonOperator
from utils.yt_data import *

def my_task():
    target_handle = '@유튜버 ID'
    data = get_handle_to_comments(youtube, target_handle)
    save_to_hdfs(data, '/input/yt-data')

with DAG( # DAG의 정보들 입력구간
    dag_id='07_yt_data',
    description='yt data',
    start_date=datetime(2025, 1, 1),
    catchup=False,
    schedule=timedelta(minutes=10)
) as dag:
    t1 = PythonOperator(
        task_id='yt',
        python_callable=my_task
    )

    t1 # DAG에 task 여러개 두는 경우 태스크들의 순서에 따라 작동
    # t1 > t2 이런식으로
```

#### Python Operator
- 작성한 파이썬 코드를 Airflow 워크플로우에서 Task로 만들어 실행할 수 있게 해주는 도구

```python
dag_id='airflow' # 웹UI->DAGs에서 DAG 이름으로 뜨는 부분'
description='yt data' # DAG 설명
start_date=datetime(2025, 1, 1) # 지정한 날짜부터 작업을 시작하겠다
catchup=False # DAG을 처음 시작할 때 불필요한 과거 데이터 처리를 건너뛰고, 현재 시점부터 스케줄에 따라 실행되도록 하고 싶을 때 사용
schedule=timedelta(minutes=10) # 실행 주기
```
##### schedule=timedelta()
- days: 일 수 (정수 또는 부동 소수점)
- seconds: 초 수 (정수 또는 부동 소수점, 0에서 86399 사이)
- microseconds: 마이크로초 수 (정수 또는 부동 소수점, 0에서 999999 사이)
- milliseconds: 밀리초 수 (정수 또는 부동 소수점)
- minutes: 분 수 (정수 또는 부동 소수점)
- hours: 시간 수 (정수 또는 부동 소수점)
- weeks: 주 수 (정수 또는 부동 소수점)

### For example
#### ex.1-1
-  DAG 파일들이 불러와지는 폴더에 함수만 모아놓은 `.py`들을 `from utils.yt_data import *`로 불러와서 태스크 유지보수를 쉽도록 관리할 수 있다
def print_hello():
    print("Hello Airflow!")

task = PythonOperator(
    task_id='say_hello',
    python_callable=print_hello,
    dag=dag
)
- dag=dag은 Airflow 태스크가 어떤 DAG에 속하는지를 명시하는 인자
안해도 되는 것으로 보이는데 선임이 시키면 그런가보다 하고 그냥 하자

#### ex.1-2
- TIL의 github관리도 할수있을거같다. TIL 안쓰면 알림도 보내줄 수 있을지는 모르겟다. 하면 되긴 할듯.
