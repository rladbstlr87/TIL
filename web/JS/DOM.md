## DOM(Document Object Model)
- 브라우저가 HTML 문서를 해석해 구성한 트리 구조의 객체 모델
- JS는 DOM을 통해 페이지 구조, 텍스트, 스타일 등을 동적으로 조작할 수 있음
```js
const title = document.querySelector('h1');
title.textContent = '반갑습니다!';
title.style.color = 'red';
```

### DOM 트리
- 트리 형태:
```
Document
└── html
    └── body
        └── h1 ("안녕하세요")
```

### 자바스크립트 페이지네이션의 한계
- 문제 상황: JS 기반 페이지네이션에서 requests만으로는 2페이지 이후의 데이터 수집 불가

- 원인:
  * requests는 JS를 실행하지 않음
  * 페이지 넘김은 JS로 처리되고, 추가 데이터는 AJAX 등으로 동적 삽입됨

### 해결 방법

* 1단계: Selenium 사용

  * 실제 브라우저를 구동해 JS 실행 포함
  * .page\_source로 렌더링 완료된 HTML 수집 가능

* 2단계: AJAX 요청 분석

  * 크롬 개발자도구(Network 탭)에서 실제 요청 URL, 파라미터 파악
  * 해당 URL을 requests로 직접 호출하여 데이터 수집

---

### 정리

* DOM은 웹 문서를 조작할 수 있게 해주는 JS 인터페이스 트리
* JS 기반 페이지네이션은 requests로 직접 접근 불가
* Selenium이나 AJAX 요청 분석을 통해 우회 수집 가능
