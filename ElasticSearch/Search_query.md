# ElasticSearch 검색

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
