# 자원의 표현
- URI
- Singleton and Collection Resources
- Collection and Sub-collection Resources

### URI (Uniform Resource Identifiers)
- REST에서 자원을 구분하고 처리하기 위해 사용
- URI 네이밍을 잘 할수록 API가 직관적이고 사용하기 쉽다
- ex) `/books`, `/customers`

### Singleton and Collection Resources
- URI는 singleton이나 collection인 것을 감안한다
- `/customer` : singleton resource
- `/customers` : collection resource

### Collection and Sub-collection Resources
- URI는 서브 컬렉션을 포함할 수 있다
- 특정 고객의 계좌라고 한다면
    - /customers/{customerId}/accounts

## URI 네이밍 규칙
네이밍 규칙을 따르게 되면 개발하며 정해진 규칙대로 접근하면 혼동이 없다.

1. 명사를 사용해서 자원을 표현한다
    - `/users` : 유저들의 정보
    - 예외적으로 동사 허용하는 경우(controller)
        - `/game/play` 에 접근 시 게임이 시작된다면?
            게임의 시작 여부를 컨트롤하는 URI이므로 동사 `play`로 표현
2. 자원간 계층 관계를 표현하기 위해 `/`(슬래시)를 사용
    - `/users/frontend`
    - `/users/5`
3. URI 경로 마지막에는 `/`를 붙이지 않는다
    - `/users/` (X)
    - `/users` (O)
4. `-`(하이픈)을 사용하여 URI의 가독성을 향상할 수 있다
    - `/profilemanagement` (X)
    - `/profileManagement` (X)
    - `/profile-management` (O)
5. URI에는 가급적 밑줄을 사용하지 않는다
    - 일부 브라우저나 화면에서 글꼴에 따라 `_`(언더바)가 가려지거나 숨겨질 수 있다
    - `/frontend_users` (X)
    - `/users/frontend` (O)
6. URI에는 소문자를 사용한다
    - `/USERS` (X)
    - `/users` (O)
7. URI에 파일 확장자를 표시하지 않는다
    - `index.do` (X)
8. URI에 CRUD 함수의 이름을 사용하지 않는다
    HTTP 메서드로 구분해야 한다
    - `/create/users` (X)
    - `/add/users` (X)
    - `/read/users` (X)
    - `/update/users` (X)
    - `/update-crews` (X)
9. 자원의 필터링을 위해 새로운 API를 만들지 않는다
    필터링을 위해 Query string을 사용
    - Query string : `주소?속성=값&속성=값&...`
    - 특정 주소로 접근할 때 페이지에 대한 옵션으로 활용
    - 프론트엔드 유저를 이름, 오름차순으로 보고싶다면?
    - `/users?type=frontend&sort=name,asc` (O)

## 자원의 상태
HTTP 메서드 <-> HTTP 상태코드

### HTTP Method
GET, POST, PUT, PATCH, DELETE...
- 유저 리스트를 얻어오고 싶다면?
    - /users + GET
- 유저 리스트에 등록하고 싶으면?
    - /users + POST
- 같은 URI 사용 + 다른 동작으로 CRUD 메서드의 이름을 URI에 표현하지 않을 수 있음

1. GET
자원을 검색할 때 사용
- GET + /getUsers (X)
- GET + /users
- GET + /users/5

2. POST
자원을 생성할 때 사용
- POST + /register_user (X)
- POST + /user -> body: {"name": "이름", "type": "frontend"}...

    | id | name | type |
    | --- | --- | --- |
    | 1 | 이름 | frontend |
    | 2 | 이름2 | ... |

3. PUT
자원을 업데이트 할 때 사용. 보내지 않은 정보는 null값으로 없데이트
- /users/1
- PUT + body: {"type": "backend"} <-네임이 없음
    | id | name | type |
    | --- | --- | --- |
    | 1 | null | backend |

4. PATCH
자원을 업데이트 할 때 사용. 보내지 않은 정보는 기존 데이터를 유지
- /users/1
- PATCH + body: {"type": "backend"} <-네임이 없음
    | id | name | type |
    | --- | --- | --- |
    | 1 | 이름 | backend |

5. DELETE
자원을 삭제할 때 사용
- /users/1
- DELETE
