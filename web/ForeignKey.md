# Modeling 관계설정

## ForeignKey
- 다른 테이블을 가리키며 '@@@'테이블을 참조할거야 하는 필드. ForeignKey가 작성되는 모델입장에서는 '@@@'테이블로부터 끌어오는 필드라 할 수 있다.
- DB 상에서 다대일(Many-to-One) 관계를 표현한다. (ex: 여러 선수가 한 팀에 속함)
### 기본구조
to가 가르킬 타 테이블 들어가는 자리
```
models.ForeignKey(to, on_delete=옵션, 여러옵션)
```

| 파라미터           | 설명                                    |
| -------------- | ------------------------------------- |
| `to`           | 참조할 모델 (`Team`, `'app.ModelName'`, 등) |
| `on_delete`    | 참조 대상이 삭제될 때의 동작                      |
| `related_name` | 역참조 시 사용할 이름 (기본값: `modelname_set`)   |
| `null`         | DB에서 NULL 허용 여부                       |
| `blank`        | 폼에서 빈 값 허용 여부                         |
| `default`      | 기본값 지정                                |

### For examples
1. User테이블에서는 아직 Team 테이블이 정의되지 않아서 'Team'으로 표기
2. Player테이블에서는 이미 Team 테이블이 정의되었으므로 Team으로 표기
```
from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    nickname = models.CharField(max_length=30)
    favorite_team = models.ForeignKey('Team', null=True, blank=True, on_delete=models.SET_NULL)

class Team(models.Model):
    name = models.CharField(max_length=50, unique=True)

class Player(models.Model):
    name = models.CharField(max_length=50)
    team = models.ForeignKey(Team, on_delete=models.CASCADE)
```
