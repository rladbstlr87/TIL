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
