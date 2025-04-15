# FastAPI

## 개념
- Python 기반 웹 프레임워크
- 비동기(Async) 지원, 자동 문서화, 타입 기반 유효성 검사 등
- Starlette(웹 기능) + Pydantic(데이터 유효성 검사) 기반

## 주요 특징
- 빠름: Starlette 기반으로 Uvicorn과 함께 사용 시 매우 빠른 성능
- 타입 힌트 기반 자동 유효성 검사 및 문서화
- 자동 Swagger UI / Redoc 생성
- 비동기 지원 (async/await)

## 기본 구조
```
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}
```

## 주요 구성 요소

> FastAPI()	: 애플리케이션 객체 생성
> @app.get()	: HTTP GET 요청 라우팅
> @app.post()	: HTTP POST 요청 라우팅
> @app.put()	: HTTP PUT 요청 라우팅
> @app.delete()	: HTTP DELETE 요청 라우팅
> Query, Path, Body	: 요청 파라미터 정의 도우미
> Pydantic 모델 : 데이터 유효성 검사 및 스키마 정의
> Depends	: 의존성 주입 처리


## 비동기 처리
```
@app.get("/items/")
async def read_items():
    return {"status": "async works!"}
```

## 요청 파라미터 예시
```
from fastapi import FastAPI

# '/'(루트)요청으로 들어왔을 때 아래의 함수 내용을 실행해 주세요 라는 구문
@app.get('/') # => urls.py
def index(): # => views.py
    return {'hello': 'world'}
```


## 생성되는 문서 UI
> Swagger UI: http://localhost:8000/docs
> ReDoc: http://localhost:8000/redoc

## 실행 방법

`uvicorn main:app --reload`

- main: Python 파일 이름 (main.py)
- app: FastAPI 인스턴스 변수명
- --reload: 코드 변경 시 자동 재시작 (개발용)
