# Hadoop

## 정의
대용량 데이터를 분산 처리하기 위한 프레임워크
- Google의 MapReduce와 GFS(Google File System) 개념을 기반으로 개발됨

## 주요 구성요소
1. HDFS (Hadoop Distributed File System)
대용량 파일을 여러 노드에 나눠 저장하는 분산 파일 시스템

2. MapReduce(처리방식이 맵리듀스)
데이터를 병렬로 처리하는 분산 컴퓨팅 프로그래밍 모델

3. YARN (Yet Another Resource Negotiator)
자원 관리 및 작업 스케줄링 기능 수행

4. Hadoop Common
위 구성요소들이 공유하는 공통 유틸리티 및 라이브러리

## 구동환경
운영체제: 대부분의 리눅스 계열 (CentOS, Ubuntu 등)

자바 기반: Java 8 이상 필요

클러스터 환경: 다수의 노드로 구성 (Master-Slave 구조)

기본 포트 예시:
```
ResourceManager: 8088
NameNode: 9870

DataNode: 9864
```

## 장점
확장성: 노드 추가만으로 저장 용량과 처리 능력 향상 가능

내결함성: 노드 장애 시 데이터 자동 복제 및 복구

비용 효율성: 범용 하드웨어 기반 구축 가능

## 단점
실시간 처리에 부적합 (배치 처리 중심)

복잡한 설정 및 관리

## 실행
디렉토리 : `~/hadoop-3.3.6`
```shell
sbin/start-yarn.sh
sbin/start-dfs.sh
```
## test
```shell
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar pi 10 10000
```
## 종료
디렉토리 : `~/hadoop-3.3.6`
```shell
sbin/stop-yarn.sh
sbin/stop-dfs.sh
```
Ubuntu는 일정시간 미사용시 종료됨
