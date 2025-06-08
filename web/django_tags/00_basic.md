# Django tag
html에서 구현되는 django 문법

### 기본 구조
|종류|설명|
|---|---|
|`{{ 변수 }}`|템플릿에서 값을 출력할 때 사용|
|`{% 태그 %}`|로직이나 구조 제어|

### 템플릿 상속 관련 태그
0. comment
주석처리. 코드 레벨에서 완전 제거
```html
{% comment %}
    주석 내용
{% endcomment %}
```
2. extends
해당 템플릿이 다른 템플릿을 상속받도록 지정
```html
{% extends "base.html" %}
<div>
...
</div>
```
3. block
상속받은 템플릿에서 override 가능한 구역을 정의
- 부모 템플릿에서 어디에 위치할 것인지 정의하고난 뒤 -> `{% block 블럭이름 %}{% endblock %}`
- 자식 템플릿에서 블럭 안에 내용 입력하면 매칭됨 -> `{% block 블럭이름 %} 내용 {% endblock %}`

| block 이름 | 용도 | 위치 및 주 사용 예시 |
|------------|------|------------------------|
| `block head` | `<head>` 태그 안의 내용 삽입용 | 메타태그, SEO, title 등 |
| `block style` | 추가적인 CSS 삽입용 | `<head>` 내부 또는 인라인 스타일 용도 |
| `block content` / `block body` | 페이지의 주요 콘텐츠 영역 | `<body>` 내부. 실질적인 화면 내용 |
| `block script` / `block extra_js` | 추가적인 JavaScript 삽입 | `<body>` 하단. 페이지 별 JS 로딩 |
