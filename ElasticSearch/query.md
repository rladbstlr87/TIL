# ElasticSearch Query 검색

## URL 검색
URL창에 직접 입력해서 요청 보내듯이 엘라스틱 서치에서 URL형식으로 데이터를 검색할 수 있다
```
# 네이버 'elasticsearch' 검색 URL예시
https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&ssc=tab.nx.all&query=elasticsearch&oquery=엘라스틱서치&tqi=ju4sWdpzLiwssSRYiEGssssssKw-030516&ackey=m4e0z4al
```
### 기본형식
여기서 `?`다음에 있는 `q`는 쿼리의 Q
```
GET /경로/_search?q=찾고싶은 키밸류쌍
```
### ex.1-1
```
GET /movie/_search?q=prdtYear:2018
GET /movie/_search?q=movieNm:star
```

## Request Body 검색
제일 많이 사용하는 검색형식. URL방식과 Request Body방식 둘다 기능의 차이는 없는데 쿼리문 작성자입장에서 Request Body 방식이 쓰기 쉬움
```
GET /movie/_search
{
    "query": {
        "term": {"prdtYear": 2018}
    }
}

GET /movie/_search
{
    "query": {
        "bool":{
            "filter ": {
                "term": {
                    "prdtYear": 2018
                }
            }
        }
    }
}
```
- aliases로 데이터셋 이름(경로) 재설정할 때,  actions의 밸류는 리스트로 감싸야함 주의
```
GET /kibana_sample_data_ecommerce/_search

POST _aliases
{
    "actions": [
      {
        "add": {
          "index": "kibana_sample_data_ecommerce",
          "alias": "ecommerce"
        }
      }
    ]
}

GET /ecommerce/_search
{
    "query": {
        "match": {
            "customer_full_name": "mary"
        }
    }
}
```
### Multi match : 여러컬럼 조회할 때
```
GET /ecommerce/_search
{
    "query": {
        "multi_match": {
          "query": "Clothing",
          "fields": ["category", "products.product_name"]
        }
    }
}
```
### term query : 키워드 검색이므로 검색어가 정확하게 일치해야함
```
GET /ecommerce/_search
{
    "query": {
        "term": {
          "day_of_week": {
            "value": "Monday"
          }
        }
    }
}
```
### bool query
```
GET /ecommerce/_search
{
    "query": {
        "bool": {
            "must": [
                {
                    "match": {
                      "category": "clothing"
                    }
                }
            ],
            "must_not": [{
                "term": {
                    "day_of_week": {"value": "Monday"}
                }
            }],
            "should": [],
            "filter": [
                {
                    "range": {
                        "taxful_total_price": {
                            "gte": 1,
                            "lte": 50
                        }
                    }
                }
            ]
        }
    }
}
```
### perfix(접두어)
```
GET /ecommerce/_search
{
    "query": {
        "prefix": {
          "category": {
            "value": "me"
          }
        }
    }
}
```
### exists(해당 컬럼이 존재 하는지 조회)
```
GET /ecommerce/_search
{
    "query": {
        "exists": {
            "field": "currency"
        }        
    }
}
```
### wildcard query(와일드카드 검색)
```
GET /ecommerce/_search
{
    "query": {
        "wildcard": {
          "customer_first_name": {
            "value": "e?????"
          }
        }
    }
}
```
