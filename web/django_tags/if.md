## if
조건에 따라 특정 블록을 렌더링할 때 사용
### 기본 구조
```html
{% if condition %}
    ...
{% elif condition %}
    ...
{% else %}
    ...
{% endif %}
```

### 내장 변수
| 이름 | 설명 |
|---|---|
| `forloop.counter` | 반복 횟수 (1부터 시작) |
| `forloop.first` | 첫 번째 반복일 때 True |
| `forloop.last` | 마지막 반복일 때 True |
| `user.is_authenticated` | 로그인 여부 (User 객체 필요) |
| `object.is_active` | 모델 인스턴스 속성 예시 |
| `request.GET` | GET 파라미터 (컨텍스트 포함 필요) |
### For examples
#### ex.1-1
```html
{% if product.stock > 0 %}
    <p>재고 있음</p>
{% elif product.stock == 0 %}
    <p>품절</p>
{% else %}
    <p>입고 예정</p>
{% endif %}
```
### What it can do?
#### ex.2
if문으로 and나 or 조건을 걸 때, python처럼 모든 방법이 되지는 않는다
- 잘못된 방법 : `{% if field.name in ('password1','password2') %}`
- 옳은 방법 : `{% if field.name == 'password1' or field.name == 'password2' %}`
#### ex.3
`game.result`에 값이 있으면(True이면) if문 내부를 실행하는 분기처리. 클래스, 스타일 등 내부에도 Django tag가 들어갈 수 있다
```html
{% if game.result %}
    <span class="game-result
        {% if game.result == '승' %}win{% elif game.result == '패' %}lose{% elif game.result == '취소' %}cancel{% endif %}">
        {{ game.result }}
    </span>
{% endif %}
```
