# Accounts/Auth API (Minimal)

세션 기반 인증(로그인 시 세션 쿠키)과 JSON 응답을 전제로 한 최소 엔드포인트 목록입니다.

## Auth
- **POST `/api/auth/signup`**
  - req: `{ username, password, email, nickname?, team?, profile_image? }` *(multipart 가능)*
  - res: **201** `{ id, username, email, nickname, team, profile_image }`

- **POST `/api/auth/login`**
  - req: `{ username, password }`
  - res: **200** `{ id, username, email, nickname, team }` *(세션 쿠키 설정)*

- **POST `/api/auth/logout`** *(인증 필요)*
  - req: `{}`
  - res: **204**

- **POST `/api/auth/username/find`** *(기존 find_id_view)*
  - req: `{ email }`
  - res: **200** `{ sent: true }` *(해당 이메일로 아이디 목록 발송)*

## Password Reset (이메일 인증번호 흐름)
- **POST `/api/auth/password/reset/request`** *(기존 reset_password_view)*
  - req: `{ username, email }`
  - res: **200** `{ sent: true }`

- **POST `/api/auth/password/reset/verify`** *(기존 confirm_verification_code)*
  - req: `{ username, code }`
  - res: **200** `{ verified: true }`

- **POST `/api/auth/password/reset/complete`** *(기존 set_new_password)*
  - req: `{ username, new_password }`
  - res: **200** `{ done: true }`

## Accounts / Profile
- **GET `/api/me`** *(인증 필요)*
  - res: **200** `{ id, username, email, nickname, team, profile_image }`

- **PATCH `/api/me/password`** *(인증 필요)*
  - req: `{ old_password, new_password }`
  - res: **200** `{ done: true }`

- **PATCH `/api/me/nickname`** *(인증 필요)*
  - req: `{ nickname }`
  - res: **200** `{ nickname }`

- **PATCH `/api/me/team`** *(인증 필요)*
  - req: `{ team }`
  - res: **200** `{ team }`
  - 비고: 응원팀 변경 시, 기존 응원팀이 관련된 참석 경기에서 사용자 제거 처리 포함

- **POST `/api/me/profile-image`** *(인증 필요, multipart)*
  - req: `file=profile_image`
  - res: **200** `{ profile_image }`

## Utility
- **POST `/api/accounts/check-duplicate`** *(기존 check_duplicate)*
  - req: `{ field: "username" | "nickname", value }`
  - res: **200** `{ available: true | false }` *(또는 중복 시 **409** 가능)*
