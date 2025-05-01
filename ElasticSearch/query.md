# Query

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

# Multi match : 여러컬럼 조회할 때
GET /ecommerce/_search
{
    "query": {
        "multi_match": {
          "query": "Clothing",
          "fields": ["category", "products.product_name"]
        }
    }
}

# term query : 키워드 검색이므로 검색어가 정확하게 일치해야함
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

# bool query
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

# perfix(접두어)
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

# exists(해당 컬럼이 존재 하는지 조회)
GET /ecommerce/_search
{
    "query": {
        "exists": {
            "field": "currency"
        }        
    }
}

# wildcard query(와일드카드 검색)
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
