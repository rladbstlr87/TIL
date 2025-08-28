# HTTP 상태 코드
주로 사용하는 코드 위주

## 1xx Informational
| 코드  | 이름                  | 용도                |
| --- | ------------------- | -------------------- |
| 100 | Continue            | 본문 전송 계속하라는 신호(드묾)   |
| 101 | Switching Protocols | 프로토콜 전환(WebSocket 등) |
| 102 | Processing          | 서버 처리 중(WebDAV, 드묾)  |
| 103 | Early Hints         | 사전 링크 힌트(드묾)         |

## 2xx Success
| 코드  | 이름                     | 용도                      |
| --- | ---------------------- | -------------------------- |
| 200 | OK                     | 일반 성공(조회/갱신 본문 포함)         |
| 201 | Created                | 리소스 생성 성공(+ `Location` 권장) |
| 202 | Accepted               | 비동기 작업 접수(아직 미완료)          |
| 203 | Non-Authoritative Info | 프록시가 일부 수정(드묾)             |
| 204 | No Content             | 본문 없이 성공(DELETE 등)         |
| 205 | Reset Content          | 입력 초기화 지시(드묾)              |
| 206 | Partial Content        | 범위 전송(다운로드/스트리밍)           |
| 207 | Multi-Status           | 배치 개별 결과(WebDAV, 드묾)       |
| 208 | Already Reported       | 중복 보고(WebDAV, 드묾)          |
| 226 | IM Used                | 델타 인코딩(매우 드묾)              |

## 3xx Redirection
| 코드  | 이름                 | 용도             |
| --- | ------------------ | ----------------- |
| 300 | Multiple Choices   | 여러 선택지(거의 사용 안 함) |
| 301 | Moved Permanently  | 영구 리다이렉트(SEO)     |
| 302 | Found              | 임시 리다이렉트(전통적)     |
| 303 | See Other          | POST 후 GET로 리다이렉트 |
| 304 | Not Modified       | 캐시 유효(본문 없음)      |
| 307 | Temporary Redirect | 메서드 유지 임시 리다이렉트   |
| 308 | Permanent Redirect | 메서드 유지 영구 리다이렉트   |

## 4xx Client Error
| 코드  | 이름                     | 용도               |
| --- | ---------------------- | ------------------- |
| 400 | Bad Request            | 형식/검증 오류(필수 누락 등)   |
| 401 | Unauthorized           | 인증 필요/실패(로그인 실패)    |
| 402 | Payment Required       | 결제 요구(거의 미사용)       |
| 403 | Forbidden              | 인증됨이나 권한 없음         |
| 404 | Not Found              | 경로/리소스 없음           |
| 405 | Method Not Allowed     | 지원하지 않는 메서드         |
| 406 | Not Acceptable         | 협상 불가(`Accept` 불일치) |
| 408 | Request Timeout        | 클라이언트 지연            |
| 409 | Conflict               | 중복/상태 충돌(아이디 중복 등)  |
| 410 | Gone                   | 영구 삭제됨              |
| 412 | Precondition Failed    | 조건 헤더 불충족           |
| 413 | Payload Too Large      | 업로드 크기 초과           |
| 415 | Unsupported Media Type | 콘텐츠 타입 미지원          |
| 422 | Unprocessable Entity   | 의미론적 검증 실패(유효성)     |
| 429 | Too Many Requests      | 레이트 리밋 초과           |

## 5xx Server Error
| 코드  | 이름                    | 용도        |
| --- | --------------------- | ------------ |
| 500 | Internal Server Error | 서버 예외 일반     |
| 501 | Not Implemented       | 미구현 메서드      |
| 502 | Bad Gateway           | 게이트웨이/프록시 오류 |
| 503 | Service Unavailable   | 점검/과부하       |
| 504 | Gateway Timeout       | 업스트림 타임아웃    |