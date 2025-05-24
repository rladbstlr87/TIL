## fetch_data
```
import requests
from . import api_key

class APIClient:
    def __init__(self):
        self.api_key = api_key.API_KEY
        self.base_url = api_key.BASE_URL
        self.headers = {'x-nxopen-api-key': self.api_key}

    def fetch_data(self, endpoint: str, params: dict = {}):
        url = f'{self.base_url}/{endpoint}'
        res = requests.get(url, headers=self.headers, params=params)
        res.raise_for_status()
        return res.json()
```

- fetch_data 메소드는 API 요청을 보내는 일반적인 유틸리티 함수
  1. API 엔드포인트 URL을 구성합니다 (base_url에 특정 엔드포인트를 붙임)
  2. API 키를 포함한 헤더 설정
  3. 파라미터를 포함하여 GET 요청
  4. HTTP 에러가 있으면 예외를 발생(raise_for_status())
  5. 응답을 JSON으로 파싱하여 반환
