## load static
- 개발 리소스로서의 정적인 파일들을 static 파일이라고 한다. 프로젝트 내에 있는 static 폴더를 `settings.py`에서 경로설정해주면 어느 앱애서든 불러와서 사용할 수 있다
- 탬플릿 태그를 통해 정적 파일 주소를 유연하게 처리할 수 있다
```py
STATIC_URL = '/static/'
```

### 기본구조
static 모듈 임포트
```html
{% load static %}
```

### For examples

#### ex.1-1
static 모듈을 통한 리소스 파일 로드 예시
```html
<img src="{% static 'my_app/example.jpg' %}" alt="My image">
```

#### ex.1-2
파일명 동적 처리
```html
<img id="style-icon" src="{% static 'images/icon/pitcher_icon/' %}{{ lineup.pitcher.style }}.png"
```
static 태그 안에서 동적처리는 불가능하므로 한 번 끊어주고 `{{파일명}}`을 통해서 처리

### What it can do?
#### ex.2
`base.html`에 static 링크해서 css파일 관리하기
```html
<head>
{% load static %}
    <link rel="stylesheet" href="{% static 'main.css' %}">
</head>
```
만약 개별 페이지 마다의 css 파일을 만들었다면 똑같이 static 폴더에 넣어준 뒤 각 템플릿에서 static으로 링크하면 된다