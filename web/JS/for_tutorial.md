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
HTML 문서가 완전히 파싱되고 나면(<script>가 <head>나 <body> 어디에 있든 관계없이) 이벤트 리스너 내부의 콜백 함수`(()=>{})`가 실행
```js
document.addEventListener('DOMContentLoaded', () => {
    // 여기에 들어간 함수를 실행
});
```

## 고유 키 생성
현재 페이지의 경로(pathname)를 기반으로 로컬스토리지에서 사용할 고유 키를 생성(ex. `/about` 페이지라면 `visited_/about`이라는 키가 생성됨)
```js
const pageKey = `visited_${window.location.pathname}`;
```