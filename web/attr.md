# Attribute 접근 (내장함수 종류)
## 1. getattr
- 객체의 속성값을 문자열 이름으로 접근할 수 있게 해주는 내장 함수
- Django ORM 모델은 DB 레코드 하나를 객체로 표한하고 이 모델 인스턴스의 **필드(field)**가 바로 **속성(attribute)**이 됨. 야구선수 스탯을 저장한 DB에서 ERA, IP 이런 것들이 속성이 되는 것

### 기본구조
```py
getattr(object, name[, default])
```

- 객체에 존재하는 속성(attribute)을 문자열로 받아 해당 값을 반환. 없으면 `default` 반환 혹은 `AttributeError` 발생

| 파라미터 | 설명 |
| --- | --- |
| `object` | 속성을 확인하려는 대상 객체 |
| `name` | 문자열 형태의 속성 이름 |
| `default` | (optional) 속성이 없을 때 반환할 기본값. 생략 시 `AttributeError` 발생 |

### For example

#### ex.1-1
```py
class User:
    username = 'alice'

user = User()
print(getattr(user, 'username'))  # 'alice'
```

#### ex.1-2

```py
class Article:
    title = 'Django Tips'

article = Article()
print(getattr(article, 'content', 'No Content'))  # 'No Content'
```

#### ex.1-3

```py
class Dummy:
    pass

d = Dummy()
try:
    print(getattr(d, 'something'))
except AttributeError as e:
    print('Error:', e)
```

### What it can do?
#### ex.level.2
동적으로 모델 인스턴스의 필드값에 접근할 수 있음 (ex. 필드 이름이 변수일 때)
```py
field_name = 'email'
user = User(email='alice@example.com')
value = getattr(user, field_name)
print(value)  # 'alice@example.com'
```

#### ex.level.3
속성으로 조건을 만들수 있음
```py

```
```html

```
