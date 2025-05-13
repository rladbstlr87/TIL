PUT /movie

PUT /movie/_doc/1
{
    "movieNm": "살아남은 아이",
    "prodYear": 2017
}

PUT /movie/_doc/2
{
    "movieNm": "아이언맨",
    "prodYear": 2010
}

GET /movie/_search

GET /movie

### type은 인덱싱처리를 ES가 해주는 타입
- keyword는 인덱싱 안할 듯(알아보자
DELETE /movie

### 스키마 구조를 잡아서 인덱스 생성(=자바:모델링한다 / =ES:매핑한다)
PUT /movie
{
    "mappings": {
        "properties": {
            "movieNm": {
                "type": "text"
            },
            "prdtYear": {
                "type": "integer"
            }
        }
    }
}

### row 입력
PUT /movie/_doc/1
{
    "movieNm": "살아남은 아이",
    "prdtYear": 2017
}

PUT /movie/_doc/2
{
    "movieNm": "아이언맨",
    "prdtYear": 2010
}

### 스키마 구조 확인
GET /movie

### 데이터 확인
GET /movie/_search

### 삭제
DELETE /movie/_doc/2

### ID값 지정 안하고 데이터 입력
POST /movie/_doc
{
    "movieNm": "Thor",
    "prdtYear": 2020
}

### 매핑 확인
GET /movie/_mapping

PUT /movie_mapping

## 타입 종류
### keyword
PUT movie_mapping/_mapping/
{
    "properties": {
        "multiMovieYn": {
            "type": "keyword"
        }
    }
}

### text
PUT movie_mapping/_mapping/
{
    "properties": {
        "movieComment": {
            "type": "text"
        }
    }
}

### integer
PUT movie_mapping/_mapping/
{
    "properties": {
        "Year": {
            "type": "integer"
        }
    }
}

### date
PUT movie_mapping/_mapping/
{
    "properties": {
        "date": {
            "type": "date",
            "format": "yyyy-MM-dd"
        }
    }
}

### range
PUT movie_mapping/_mapping/
{
    "properties": {
        "showRange": {
            "type": "date_range"
        }
    }
}

POST movie_mapping/_doc/
{
    "showRange": {
        "gte": "2025-01-01",
        "lte": "2025-02-15"
    }
}

### GEO
PUT movie_mapping/_mapping/
{
    "properties": {
        "filmLocation": {
            "type": "geo_point"
        }
    }
}

POST movie_mapping/_doc
{
    "filmLocation": {
        "lat": 55,
        "lon": -1
    }
}

## 분석기
POST _analyze
{
    "analyzer": "standard",
    "text": "우리나라가 좋은나라, 대한민국 화이팅"
}

## CRUD
### C
PUT movie_mapping/_doc/1
{
    "movieNm": "아이언맨"
}

### R
GET movie_mapping/_doc/1

### U (기존 문서 지우고 다시 create하는 개념)
PUT movie_mapping/_doc/1
{
    "movieNm": "아이언맨2"
}

### D
DELETE movie_mapping/_doc/1

### from, size (페이지네이션:유사도 높은 1페이지 보여줌(구글검색 1페이지같은 느낌))
GET /movie/_search
{
    "query": {
        "term": {"prdtYear": 2018}
    },
    "from": 1,
    "size": 10
}

### sort
GET /movie/_search
{
    "query": {
        "term": {"movieNm": "star"}
    },
    "sort": {
        "prdtYear": {
            "order": "asc"
        }
    }
}

### _source 필드 필터링 : 보고싶은 컬럼만 보이게 함
GET /movie/_search
{
    "query": {
        "term": {"movieNm": "star"}
    },
    "_source": ["movieNm"]
}

GET /movie/_search
{
    "query": {
        "range": {
            "prdtYear": {
                "gte": 2010,
                "lte": 2020
            }
        }
    }
}

### operator
GET movie/_search
{
    "query":{
        "match": {
            "movieNm": {
                "query": "Before city"
            }
        }
    }
}

GET movie/_search
{
    "query":{
        "match": {
            "movieNm": {
                "query": "Before city",
                "operator": "and"
            }
        }
    }
}


### fuzziness
GET /movie/_search
{
    "query": {
        "match": {
            "movieNm": {
                "query": "stat",
                "fuzziness": 1
            }
        }
    }
}

### boost 가중치 처리
-field 할 때 "필터링할이름"^3 이런식으로 더 가중치있게 필터링할 수 있다
