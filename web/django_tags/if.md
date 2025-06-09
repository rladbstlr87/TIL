## if
### 조건 종류
#### For examples
if문으로 and나 or 조건을 걸 때, python처럼 모든 방법이 되지는 않는다
- 잘못된 방법 : `{% if field.name in ('password1','password2') %}`
- 옳은 방법 : `{% if field.name == 'password1' or field.name == 'password2' %}`
