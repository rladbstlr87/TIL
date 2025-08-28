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