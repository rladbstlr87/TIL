# API 명세서
협업/외부에서 소비하는 API면 ‘명세(계약)부터’ 시작하는 게 일반적. 내부 소규모라면 코드→명세도 하지만, 최소 초안(OpenAPI)이라도 먼저 잡아두고 그걸 기준으로 시리얼라이저·뷰를 구현이 좋음

## 엔드포인트
- `POST /api/auth/signup` → 가입 및 세션 시작(201)
- `POST /api/auth/login` → 로그인(200), `Set-Cookie`

```yaml
openapi: 3.0.3
paths:
  /api/auth/login:
    post:
      tags: [Auth]
      summary: Login (session-based)
      description: |
        유효한 자격증명으로 로그인하고 세션을 시작합니다.
        성공 시 Set-Cookie 헤더로 세션이 설정됩니다.
        (SessionAuthentication+CSRF를 쓰면 POST에 CSRF 토큰 필요)
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [username, password]
              properties:
                username: { type: string }
                password: { type: string, format: password }
            examples:
              ok:
                value: { username: "tester1", password: "Str0ng!Pass" }
          application/x-www-form-urlencoded:
            schema:
              type: object
              required: [username, password]
              properties:
                username: { type: string }
                password: { type: string }
      responses:
        "200":
          description: 로그인 성공 (세션 생성)
          headers:
            Set-Cookie:
              description: "세션 쿠키(ex. sessionid=...; Path=/; HttpOnly; Secure)"
              schema: { type: string }
          content:
            application/json:
              schema:
                type: object
                properties:
                  id:          { type: integer }             # DB PK
                  username:    { type: string }
                  email:       { type: string, format: email }
                  nickname:    { type: string, nullable: true }
                  team:        { type: string, nullable: true }
                  profile_image: { type: string, nullable: true }  # URL 등
              examples:
                ok:
                  value:
                    id: 123
                    username: tester1
                    email: t1@example.com
                    nickname: null
                    team: LG
                    profile_image: null
        "400":
          description: 요청 형식/필드 유효성 오류 (필수 누락 등)
          content:
            application/json:
              schema:
                type: object
                properties:
                  detail: { type: string }
                  errors:
                    type: object
                    additionalProperties:
                      type: array
                      items: { type: string }
              examples:
                missing:
                  value:
                    detail: "Invalid request."
                    errors:
                      username: ["This field is required."]
        "401":
          description: 인증 실패(아이디/비밀번호 불일치)
          content:
            application/json:
              schema:
                type: object
                properties:
                  detail: { type: string }
              examples:
                invalid:
                  value:
                    detail: "Invalid credentials."
        "429":
          description: 레이트 리밋 초과(선택: 스로틀 적용 시)
```

## 문서/운영 개념 정리

- YAML을 쓰는 이유: JSON도 가능하나,가독성/주석가능/anchor 재사용/PR diff 의 이점이 있음
- `schema`의 의미: 요청/응답 바디의 형식 정의 자리(비워두면 불완전 명세). 인라인 정의 or `$ref` 필요
- 에러 바디의 `additionalProperties`: `errors`가 사전 구조이며 키 이름(필드명)이 무엇이든 허용, 각 값은 문자열 배열

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
