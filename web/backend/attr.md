# Attribute 접근 (내장함수 종류)
attr은 객체의 속성 이름을 문자열로 콕 찍어서 지정한다고 생각하면 된다
## 1. getattr
그럼 get은 그 attr을 가져온다 정도가 되겠다
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
속성으로 조건을 만들수 있음. 야구선수 중 투수가 가질만한 스탯으로 투수인지 타자인지 구별. 그에 따라 각각의 투타 스타일에 설명을 부여, 툴팁에 사용 가능
```py
# apps/templatetags/custom_filters.py

@register.filter
def style_description(obj):
    style_value = str(getattr(obj, 'style', ''))
    is_pitcher = hasattr(obj, 'ERA') or hasattr(obj, 'IP')  # 투수만 가질 만한 필드

    if is_pitcher:
        pitcher_styles = {
            '0': '구속형',
            '1': '제구형',
            '2': '체력형',
            '3': '노멀형',
        }
        return pitcher_styles.get(style_value, '알 수 없는 유형')
    else:
        hitter_styles = {
            '0': '파워형',
            '1': '스피드형',
            '2': '타격형',
            '3': '선구안형',
            '4': '노멀형',
        }
        return hitter_styles.get(style_value, '알 수 없는 유형')
```
```html
{% load custom_filters %}

{{ lineup.hitter|style_description }}
{{ lineup.pitcher|style_description }}
```

## 2. hasattr
has는 attr이 가지고 있는가? 존재 여부를 확인하는 의미다
### 기본구조
```py
hasattr(object, name)
```

- 객체에 특정 이름의 속성이 존재하는지 여부를 불리언으로 반환하는 내장 함수
- 객체가 지정한 이름의 속성을 가지고 있으면 `True`, 없으면 `False` 반환

| 파라미터     | 설명                  |
| -------- | ------------------- |
| `object` | 속성 존재 여부를 검사할 대상 객체 |
| `name`   | 문자열 형태의 속성 이름       |

### For example
#### ex.2-1

```py
class User:
    username = 'alice'

user = User()
print(hasattr(user, 'username'))  # True
```

#### ex.2-2
없어서 false
```py
class Product:
    price = 100

product = Product()
print(hasattr(product, 'stock'))  # False
```
더미에 아무것도 없어서 false
```py
class Dummy:
    pass

d = Dummy()
print(hasattr(d, 'anything'))  # False
```

### What it can do?
#### ex.level.2
동적으로 속성 존재 여부 확인 후 조건 처리 가능
```py
field_name = 'email'
if hasattr(user, field_name):
    print(getattr(user, field_name))
else:
    print('속성 없음')
```

#### ex.level.3
Django 모델 인스턴스 필드 존재 여부 체크 후 안전하게 값 접근 가능
```py
for field in ['username', 'email', 'is_active']:
    if hasattr(user, field):
        print(f"{field}: {getattr(user, field)}")
    else:
        print(f"{field} 속성 없음")
```
