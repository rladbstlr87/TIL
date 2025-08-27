# API 구현

## 데이터 스키마와 시리얼라이저 정의
### ModelSerializer (클래스)
- 모델 필드 자동 매핑 기반 직렬화 구성
- Meta에 model과 fields만 최소 지정

```py
class UserSignupSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("username","password","email")
```

## 유효성 검사와 예외 처리

### raise (명령어)

* 조건 불충족 시 즉시 예외 발생

```py
if User.objects.filter(username=username).exists():
    raise serializers.ValidationError({"username": "이미 사용 중"})
```

### is\_valid (메소드)

* 유효성 검사 실행
* raise\_exception=True 사용 시 실패를 예외로 처리

```py
s = UserSignupSerializer(data=request.data)
s.is_valid(raise_exception=True)
```

## validate 확장과 부모 로직 유지

### validate (메소드)

* 다필드 교차 검사 추가 구현

```py
def validate(self, attrs):
    username = attrs.get("username")
    email = attrs.get("email")
    # 추가 검사 로직
    return attrs
```

### super (키워드)

* 부모 로직 호출로 기본 동작 유지

```py
def validate(self, attrs):
    attrs = super().validate(attrs)
    # 확장 검사 로직
    return attrs
```

### super().validate (메소드 호출)

* 부모의 유효성 검사 결과를 이어받아 확장

```py
attrs = super().validate(attrs)
```

## 사용자 생성 로직

### create (메소드)

* validated\_data로 객체 생성 반환

```py
def create(self, validated_data):
    password = validated_data.pop("password")
    user = User.objects.create_user(password=password, **validated_data)
    return user
```

### create\_user (메소드)

* 비밀번호 해싱 포함 안전한 사용자 생성

```py
user = User.objects.create_user(username=username, email=email, password=password)
```

## 인증과 세션 처리

### authenticate (메소드)

* 자격 증명으로 사용자 확인

```py
user = authenticate(request, username=u, password=p)
```

### login (메소드)

* 인증된 사용자 세션 유지

```py
auth_login(request, user)
```

## CSRF 처리와 보안 설정

### ensure\_csrf\_cookie (데코레이터)

* GET 요청 시 CSRF 쿠키 강제 발급

```py
@api_view(["GET"])
@permission_classes([AllowAny])
@ensure_csrf_cookie
def csrf(request):
    return Response({"detail": "CSRF cookie set"})
```

## 파일 업로드 파서 구성

### JSONParser (클래스)

* JSON 본문 파싱

```py
@parser_classes([JSONParser])
```

### FormParser (클래스)

* form-urlencoded 파싱

```py
@parser_classes([FormParser])
```

### MultiPartParser (클래스)

* 파일 포함 multipart 파싱

```py
@parser_classes([MultiPartParser])
```

### 혼합 사용 예

* JSON과 파일 동시 허용

```py
@parser_classes([JSONParser, FormParser, MultiPartParser])
```

## URL 라우팅 구성

### path (함수)

* 경로와 뷰 매핑

```py
urlpatterns = [
    path("api/csrf/", csrf, name="csrf"),
    path("api/auth/signup/", signup, name="signup_api"),
    path("api/auth/login/", login, name="login_api"),
]
```

## 에러 응답 포맷과 상태코드

### ValidationError (예외 클래스)

* 유효성 실패 시 사용

```py
raise serializers.ValidationError({"email": "이미 사용 중"})
```

### Response (클래스)

* 일관된 응답 본문 구성

```py
return Response(serializer.data, status=status.HTTP_201_CREATED)
```

### status (상수 모듈)

* 의미 있는 상태코드 이름 제공

```py
from rest_framework import status
```

## 테스트 흐름과 확인 절차

### curl (명령어)

* CSRF 쿠키 수신

```bash
curl -i -X GET http://localhost:8000/accounts/api/csrf/ -c cookies.txt
```

* 가입 요청 JSON

```bash
curl -i -X POST http://localhost:8000/accounts/api/auth/signup/ \
  -H "Content-Type: application/json" \
  -b cookies.txt -c cookies.txt \
  -d '{"username":"u1","password":"P@ssw0rd!","email":"u1@example.com"}'
```

* 로그인 요청 JSON

```bash
curl -i -X POST http://localhost:8000/accounts/api/auth/login/ \
  -H "Content-Type: application/json" \
  -b cookies.txt -c cookies.txt \
  -d '{"username":"u1","password":"P@ssw0rd!"}'
```

* 파일 업로드 multipart

```bash
curl -i -X POST http://localhost:8000/accounts/api/auth/signup/ \
  -b cookies.txt -c cookies.txt \
  -F "username=u2" -F "password=P@ssw0rd!" -F "email=u2@example.com" \
  -F "profile_image=@/path/to/img.png"
```