# Analyze
```
POST _analyze
{
    "analyzer": "standard",
    "text": "Hello world!!!"
}

# 결과
{
  "tokens": [
    {
      "token": "hello",
      "start_offset": 0,
      "end_offset": 5,
      "type": "<ALPHANUM>",
      "position": 0
    },
    {
      "token": "world",
      "start_offset": 6,
      "end_offset": 11,
      "type": "<ALPHANUM>",
      "position": 1
    }
  ]
}
```
```
POST _analyze
{
    "analyzer": "whitespace",
    "text": "Hello world!!!"
}

# 결과
{
  "tokens": [
    {
      "token": "Hello",
      "start_offset": 0,
      "end_offset": 5,
      "type": "word",
      "position": 0
    },
    {
      "token": "world!!!",
      "start_offset": 6,
      "end_offset": 14,
      "type": "word",
      "position": 1
    }
  ]
}
```
## Déjà vu 의 일반 알파벳화 차이 발견
POST _analyze
{
    "analyzer": "standard",
    "text": "Is this Déjà vu?"
}
```
{
    "token": "déjà",
    "start_offset": 8,
    "end_offset": 12,
    "type": "<ALPHANUM>",
    "position": 2
},
```

POST _analyze
{
    "tokenizer": "standard",
    "filter": ["lowercase", "asciifolding"],
    "text": "Is this Déjà vu"
}
```
{
    "token": "deja",
    "start_offset": 8,
    "end_offset": 12,
    "type": "<ALPHANUM>",
    "position": 2
},
```

## make for english analyzer
### basic
```
PUT /article
{
    "settings": {
        "analysis": {
            "analyzer": {
                "my_analyzer": {
                    "type": "custom",
                    "tokenizer": "standard",
                    "filter": ["lowercase", "asciifolding"]
                }
            }
        }
    },
    "mappings": {
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "my_analyzer"
            }
        }
    }
}

GET /article/_analyze
{
    "analyzer": "my_analyzer",
    "text": "Is this Déjà vu?"
}
```
```
{
    "token": "deja",
    "start_offset": 8,
    "end_offset": 12,
    "type": "<ALPHANUM>",
    "position": 2
},
```
### 형태소 분석 추가
1. `"char_filter": ["html_strip"],`로 html태그 제외
2. `"filter": ["lowercase", "asciifolding", "stemmer"]`로 소문자, 악센트 뺀 알파벳, 단어의 원형으로 변경
3. 매핑 부분의 `"analyzer": "my_analyzer"`는 매핑에다가 사전작성한 "my_analyzer"를 적용하는 부분
```
PUT /article
{
    "settings": {
        "analysis": {
            "analyzer": {
                "my_analyzer": {
                    "type": "custom",
                    "char_filter": ["html_strip"],
                    "tokenizer": "standard",
                    "filter": [
                        "lowercase",
                        "asciifolding",
                        "stemmer"
                    ]
                }
            }
        }
    },
    "mappings": {
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "my_analyzer"
            }
        }
    }
}

POST /article/_analyze
{
    "field": "content",
    "text": "<b>Is this Déjà vu?<b> foxes are jumping"
}
```
- stemmer가 하는 역할에 집중해보자
```
# 결과
{
  "tokens": [
    {
      "token": "is",
      "start_offset": 3,
      "end_offset": 5,
      "type": "<ALPHANUM>",
      "position": 0
    },
    {
      "token": "thi",
      "start_offset": 6,
      "end_offset": 10,
      "type": "<ALPHANUM>",
      "position": 1
    },
    {
      "token": "deja",
      "start_offset": 11,
      "end_offset": 15,
      "type": "<ALPHANUM>",
      "position": 2
    },
    {
      "token": "vu",
      "start_offset": 16,
      "end_offset": 18,
      "type": "<ALPHANUM>",
      "position": 3
    },
    {
      "token": "fox",
      "start_offset": 23,
      "end_offset": 28,
      "type": "<ALPHANUM>",
      "position": 4
    },
    {
      "token": "ar",
      "start_offset": 29,
      "end_offset": 32,
      "type": "<ALPHANUM>",
      "position": 5
    },
    {
      "token": "jump",
      "start_offset": 33,
      "end_offset": 40,
      "type": "<ALPHANUM>",
      "position": 6
    }
  ]
}
```
- Déjà를 deja로 잘 인식하지만 this를 thi로 인식하는 것 처럼 기본내장 애널라이저라서 성능이 좋지는 않다
- 엘라스틱서치는 text를 유연하게 검색한다

# Nori analyzer(한글 형태소 분석기)
뭐가 됐든 분석기는 아래의 기본형식을 따른다. 이 다음에서 노리 토크나이저를 사용해보겠다.
```
PUT /article
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {}
      }
    }
  },
  "mappings": {
    "properties": {
      "content": {
        "type": "text",
        "analyzer": "my_analyzer"
      }
    }
  }
}
```
## 노리 토크나이저
```
PUT /article
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_analyzer": {
          "type": "custom",
          "tokenizer": "nori_tokenizer",
          "filter": [
            "nori_part_of_speech",
            "nori_readingform"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "content": {
        "type": "text",
        "analyzer": "my_analyzer"
      }
    }
  }
}
```
### 기본형태
이제 간단하게 사용해보자
```
get /article/_analyze
{
  "analyzer": "my_analyzer",
  "text": ""
}
```
```
get /article/_analyze
{
  "analyzer": "my_analyzer",
  "text": "인천에서 롯데타워가 보여요"
}
```
- 결과
```
{
  "tokens": [
    {
      "token": "인천",
      "start_offset": 0,
      "end_offset": 2,
      "type": "word",
      "position": 0
    },
    {
      "token": "롯데",
      "start_offset": 5,
      "end_offset": 7,
      "type": "word",
      "position": 2
    },
    {
      "token": "타워",
      "start_offset": 7,
      "end_offset": 9,
      "type": "word",
      "position": 3
    },
    {
      "token": "보이",
      "start_offset": 11,
      "end_offset": 14,
      "type": "word",
      "position": 5
    }
  ]
}
```
## 토크나이저랑 필터 커스텀
### 기본형식
```
PUT /article
{
  "settings": {
    "analysis": {
      "tokenizer": {},
      "filter": {},
      "analyzer": {
        "my_analyzer":{

        }
      }
    }
  }
}
```
```
PUT /article
{
  "settings": {
    "analysis": {
      "tokenizer": {
        "my_tokenizer": {
          "type": "nori_tokenizer",
          "decompound_mode": "mixed",
          "user_dictionary": "custom/user_dict.txt"
        }
      },
      "filter": {},
      "analyzer": {
        "my_analyzer":{
          "type": "custom",
          "tokenizer": "my_tokenizer"
        }
      }
    }
  }
}
```
```
get /article/_analyze
{
  "analyzer": "my_analyzer",
  "text": "세종시"
}
```
```
{
  "tokens": [
    {
      "token": "세종시",
      "start_offset": 0,
      "end_offset": 3,
      "type": "word",
      "position": 0,
      "positionLength": 2
    },
    {
      "token": "세종",
      "start_offset": 0,
      "end_offset": 2,
      "type": "word",
      "position": 0
    },
    {
      "token": "시",
      "start_offset": 2,
      "end_offset": 3,
      "type": "word",
      "position": 1
    }
  ]
}
```
### `"user_dictionary_rules":`
`"user_dictionary":`는 추가되는 단어들을 파일로 관리하며 경로를 입력해주어야 하고 rules는 직접 단어를 한두개 정도 넣을 때 사용한다.
#### 동의어, 불용어 등
- elasticsearch-8.18.0/config`/custom` 같은 경로로 관리할 user의 dict, synonym, stop 등의 텍스트 파일을 넣어서 적용시킬 수 있다
