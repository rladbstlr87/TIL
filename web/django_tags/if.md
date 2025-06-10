## if
### 조건 종류
### For examples
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
