# `models.py` 복습
## `models.py`에서 할 수 있는 일들
Django의 ORM에서 여러가지 일들을 수행한다

1. 데이터 처리를 위한 작업
쿼리 생성, 데이터 접근, 저장 및 갱신할 수 있는 방식 제공

### 모델 설계
어떤 컬럼들이 어떤 필드타입인지를 설정

### 예시
```
class Team(models.Model):
    KBO_TEAMS = [
        ('SSG', 'SSG 랜더스'),
        ('LG', 'LG 트윈스'),
        ('KT', 'KT 위즈'),
        ('NC', 'NC 다이노스'),
        ('두산', '두산 베어스'),
        ('삼성', '삼성 라이온즈'),
        ('롯데', '롯데 자이언츠'),
        ('키움', '키움 히어로즈'),
        ('한화', '한화 이글스'),
        ('KIA', 'KIA 타이거즈'),
    ]

    team = models.CharField(
        max_length=10,
        choices=KBO_TEAMS,
        blank=True,
        null=True,
        verbose_name='응원팀'
    )
    logo = models.ImageField(upload_to='team_logos/', null=True, blank=True)
    stadium = models.CharField(max_length=100)
    navi_url = models.URLField(max_length=200)

class User(AbstractUser):
    favorite_team = models.ForeignKey(
        'teams.Team',
        on_delete=models.PROTECT,
        null=False,
        blank=False
    )
    nickname = models.CharField(max_length=12, unique=True) # 한글 6글자 까지 허용
```
2. 도메인 로직 보관
계산, 상태 판별, 제약 조건 등 핵심 규칙 구현

3. DB구조의 선언
테이블 , 필드 들의 1:N, M:N 등 관계 정의

## ManyToManyField
```
class Post(models.Model):
    content = models.T#### extField()
    created_at = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(upload_to='image')
    # image = ResizedImageField(
    #     size=[500, 500],
    #     crop=['middle', 'center'],
    #     upload_to='image/%Y/%m',
    # )
    # 작성자
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

    # 이 글에 좋아요 누른 사람(중간 테이블 만들어주는 역할)
    like_users = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name='like_posts',
    )
```
### 정의
- 여러 개의 객체가 서로 연결될 수 있도록 하는 필드
- 두 모델 간 다대다(Many-to-Many) 관계를 설정하는 필드로, 중개 테이블을 통해 각 객체가 여러 개의 다른 객체와 연결될 수 있도록 함
### 기본 구조
```
class 모델명(models.Model):
    관계필드명 = models.ManyToManyField(연결할_모델, 옵션들)
```
#### 파라미터 설명

to: 연결할 모델을 지정
related_name: 역참조 시 사용할 이름 설정
through: 중개 테이블을 직접 정의할 때 사용
symmetrical: 기본값 True, 단방향 관계 설정 시 False로 변경
db_table: 생성될 중개 테이블 이름을 지정할 때 사용
⸻

### For example
ex.1-1: 기본적인 ManyToMany 관계 설정
class Post(models.Model): content = models.T#### extField() like_users = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_posts')

#### ex.1-2: 데이터 추가 및 조회
```
post = Post.objects.create(content="새 게시글")
user = User.objects.first()

# 좋아요 추가
post.like_users.add(user)

# 좋아요한 사용자 목록 조회
liked_users = post.like_users.all()
```
### What it can do?
#### ex.level.2: 중개 모델을 사용하여 추가 정보 저장
```
class Like(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

class Post(models.Model):
    content = models.T#### extField()
    like_users = models.ManyToManyField(settings.AUTH_USER_MODEL, through='Like', related_name='like_posts')

# 좋아요 추가
Like.objects.create(user=user, post=post)

# 특정 게시글을 좋아요한 사용자 조회
liked_users = User.objects.filter(like__post=post)
ex.level.3: ManyToMany 관계에서 필터링
# 특정 사용자가 좋아요한 게시글 목록 조회
user_like_posts = Post.objects.filter(like_users=user)

# 좋아요 수가 5개 이상인 게시글 조회
popular_posts = Post.objects.annotate(like_count=Count('like_users')).filter(like_count__gte=5)
```

#### ex.level.3: 특정 조건으로 ManyToMany 관계 정렬
가장 많은 좋아요를 받은 게시글 순 정렬
```
most_liked_posts = Post.objects.annotate(like_count=Count('like_users')).order_by('-like_count')
```
