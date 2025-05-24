# Logstash
## Django log
- 여기서 logging이란 django에서 사용자가 서버와 주고받은 요청의 기록을 남기는 것
- 프로그램 실행 중 발생하는 사건(event), 상태(state), 오류(error) 등의 정보를 지속적으로 기록. 이를 통해 시스템의 동작을 추적, 디버깅, 분석, 감시할 수 있도록 하는 메커니즘

## `logging` 구성
python에서 기본제공하는 logging을 통해 기본적이며 핵심적인 로그 설정을 해본다
- 경로예시 : `isnta/posts/middleware.py
```py
import logging
from datetime import datetime

loggers = logging.getLogger('mylogger')

class MyLogMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        ip = request.META.get('REMOTE_ADDR')
        user = request.user
        method = request.method
        path = request.get_full_path()

        log = f'{timestamp} {ip} {user} {method} {path}'

        loggers.info(log)

        return self.get_response(request)
```
## 프로젝트바깥에 따로 있는 `logstash/django_log.conf`
화살표 함수인줄 알았는데 그냥 logstash 설정에서만 쓰는 문법이라 함
```conf
input {
    file {
        path => "/Users/m2/damf2/insta/django.log"
        start_position => "beginning"
        codec => plain { charset => "UTF-8" }
    }
}

filter {
    grok {
        match => {
            "message" => "%{TIMESTAMP_ISO8601:timestamp} %{IP:ip} %{WORD:user} %{WORD:method} %{URIPATHPARAM:path}"
        }
    }
    date {
        match => ["timestamp", "yyyy-MM-dd HH:mm:ss"]
        timezone => "Asia/Seoul"
    }
}

output {
    elasticsearch {
        hosts => ["https://localhost:9200"]
        user => "elastic"
        password => "123456"
        ssl_enabled => true
        ssl_certificate_authorities => "/Users/m2/elasticsearch-8.18.0/config/certs/http_ca.crt"
        index => "django-log-data"
    }

    stdout {
        codec => rubydebug
    }
}
```
## `insta/insta/settings.py`
```py
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,

    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': 'django.log'
        },
        'console': {
            'class': 'logging.StreamHandler',

        },
    },

    'loggers': {
        'django.server': {
            'handlers': [],
            'level': 'INFO',
            'propagate': False,
        },
        'mylogger': {
            'handlers': ['file', 'console'],
            'level': 'INFO',
            'propagate': False,
        }
    }
}
```
### propagate
이 로거(logger)가 상위 로거로 로그를 전달하는 여부를 결정
- 로그가 중복 출력돼서 헷갈리거나, 로그를 독립적으로 출력하고 싶다면 False 값을 할당한다
#### 0. logger의 계층 구조
Python의 로깅 시스템은 트리(tree) 구조로 되어 있음
```
root
├── myapp
│   └── myapp.module
```
- logging.getLogger("myapp.module") → myapp.module이라는 하위 로거 생성
- 이 로거는 자동으로 **myapp → root**로 이어지는 부모 체계를 가짐
- 그래서 기본값이 `propagate = True`로 부모 로거에게도 전달

#### 1. `propagate = False`
- 이 로거에서 핸들러가 처리한 로그는 그걸로 끝
- 상위 로거에 전달하지 않음 → 중복 방지 또는 독립성 유지
