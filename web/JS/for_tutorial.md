# User Journey
브라우저에 처음 진입한 사용자에게 튜토리얼 진행시키는 오버레이 js 구문

## 본문
```html
<script>
document.addEventListener('DOMContentLoaded', () => {
    const pageKey = `visited_${window.location.pathname}`;
    const overlay = document.getElementById('introOverlay');
    const steps = document.querySelectorAll('#introSteps p');
    const finalMessage = document.getElementById('finalMessage');
    let currentStep = 0;

    if (!localStorage.getItem(pageKey)) {
    overlay.classList.remove('hidden');
    steps[0].classList.remove('hidden');

    overlay.addEventListener('click', () => {
        // 현재 p 숨기기
        steps[currentStep].classList.add('hidden');

        currentStep++;

        if (currentStep < steps.length) {
        // 다음 p 보이기
        steps[currentStep].classList.remove('hidden');
        } else {
        // 모든 설명 끝나면 안내 박스 표시
        finalMessage.classList.remove('hidden');
        }
    });
    }

    window.closeIntro = () => {
    overlay.classList.add('hidden');
    localStorage.setItem(pageKey, 'true');
    };
});
</script>
```

## DOMContentLoaded
HTML 문서가 완전히 파싱되고 나면(`<script>`가 `<head>`나 `<body>` 어디에 있든 관계없이) 이벤트 리스너 내부의 콜백 함수`(()=>{})`가 실행
```js
document.addEventListener('DOMContentLoaded', () => {
    // 여기에 들어간 함수를 실행
});
```

## 로컬 스토리지 방문 키 처리
현재 페이지의 경로(pathname)를 기반으로 로컬스토리지에서 사용할 고유 키를 생성(ex. `/about` 페이지라면 `visited_/about`이라는 키가 생성됨)
- `visited_`는 로컬 스토리지에 저장될 방문 여부 확인용 키의 접두사
- 로컬 스토리지에 저장되는건 세션 스토리지에 저장되는 것과 쿠키와도 다르다
| 항목 | localStorage | sessionStorage | cookie |
|---|---|---|---|
| 지속 시간 | 삭제 전까지 유지 | 탭/창을 닫을 때까지 | 설정된 만료 시간까지 |
| 저장 용량 | 약 5MB | 약 5MB | 4KB 이하 |
| 서버 전송 | 안됨 | 안됨 | 매 요청마다 서버로 자동 전송 |
| 접근 방식 | JS로만 접근 (`localStorage.getItem`) | JS로만 접근 (`sessionStorage.getItem`) | JS 또는 서버에서 접근 가능 |
| 보안 관련 | JS에서 접근 가능 (XSS에 취약) | JS에서 접근 가능 (XSS에 취약) | `HttpOnly` 설정 가능 (보안 강함) |
```js
const pageKey = `visited_${window.location.pathname}`;
```
페이지 별로 고려해야 한다면 if와 정규식을 사용해서 분기처리해보자
```js
    const path = window.location.pathname;
    let pageKey = '';

    if (/^\/cal\/calendar\/\d+\/?$/.test(path)) {
        // 모든 숫자 경기 페이지는 공통 키 사용
        pageKey = 'visited_cal_calendar';
    } else if (/^\/cal\/[^\/]+\/stadium_info$/.test(path)) {
        // 경기장 정보 페이지는 경기장 이름 달라도 공통 키 사용
        pageKey = 'visited_stadium_info';
    } else {
        // 그 외 경로는 고유하게 처리
        pageKey = `visited_${path}`;
    }
```
### For examples
#### ex.1-1
사용자 방문 여부를 판단해 초기 오버레이, 안내, 튜토리얼 등을 1회만 보여주기 위한 용도로 경기 페이지 방문 기록 저장
```js
document.addEventListener('DOMContentLoaded', () => {
    const pageKey = `visited_${window.location.pathname}`;
    const overlay = document.getElementById('introOverlay');

    if (!localStorage.getItem(pageKey)) {
        overlay.classList.remove('hidden');

        overlay.addEventListener('click', () => {
            overlay.classList.add('hidden');
            localStorage.setItem(pageKey, 'true');
        });
    }
});
```
