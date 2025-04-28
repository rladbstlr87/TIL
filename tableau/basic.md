# Tableau
- 여러가지 표현방식으로 데이터를 시각화 할 수 있음
- 시각화를 사용자가 쉽게 할 수 있게 해주는 BI 솔루션 툴
- 기본적으로 Groupby가 적용된다고 볼 수 있다

## Module Overview
1. Raw 데이터 전처리(Connect)
2. 데이터 시각화(Analyze)
3. 결과물 공유(Share)

## Connect 단계 - Tableau Prep
- 데이터를 결합, 형성, 정리, 데이터 흐름 예약, 모니터링 및 관리
### 1. Prep builder
- 분석을 위해 데이터를 결합, 변형, 정리

### 2. Prep Conductor
- 데이터 흐름을 예약하고, 모니터링 및 관리

## Analyze 단계 - Tableau Desktop
- 전처리한 데이터를 시각화

## Share 단계 - Tableau Online
- 공개를 위해 클라우드에 업로드하거나 자체서버 설치하여 On-Premise 형태로 사내공유 목적으로만 사용도 가능

## 용어
- 집계(agg) : 테이블에 올리는 자동집계된 값 데이터
- 차원 및 측정값 : 집계를 적용할 수 있으면 측정값/문자나 날짜 등은 차원
    - 불연속형 차원 : str
    - 연속형 차원 : date
    - 불연속 측정값 : int이긴 한데..잘 안쓴다
    - 연속 측정값 : int로 범위에 포함되어있는 숫자값들
- 계층
### 필터
#### 상위/하위
ORDER BY 의 LIMIT과 같은 개념

### 워크시트
### [대시보드](https://help.tableau.com/current/guides/get-started-tutorial/ko-kr/get-started-tutorial-build.htm)
워크시트를 한번에 모아볼 수 있는 탭
### [스토리](https://help.tableau.com/current/guides/get-started-tutorial/ko-kr/get-started-tutorial-story.htm)
워크시트나 대시보드를 프레젠테이션 할 수 있게 페이지로 만드는 탭
