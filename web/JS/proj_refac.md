```html
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const bg = document.getElementById('bg-circle');
    const card = document.getElementById('form-card');
    const currentMode = '{{ mode }}'; // 'login' or 'signup'

    // 폼 카드 위치 조절용 Tailwind 클래스
    const cardPositionClasses = ['left-[150px]', 'right-[150px]'];

    // 초기 위치 설정
    setTimeout(() => {
      applyTransitionState(currentMode);
    }, 50);

    function applyTransitionState(mode) {
      // 배경 원 위치
      bg.classList.remove('bg-move-left', 'bg-move-right');
      bg.classList.add('bg-center');

      // 카드 위치
      card.classList.remove(...cardPositionClasses);
      if (mode === 'signup') {
        card.classList.add('left-[150px]');
      } else {
        card.classList.add('right-[150px]');
      }
    }

    function resetTransitionState() {
      bg.classList.remove('bg-center', 'bg-move-left', 'bg-move-right');
      card.classList.remove(...cardPositionClasses);
    }

    window.triggerSwitch = function (targetMode) {
      resetTransitionState();

      // 방향 전환 애니메이션
      if (targetMode === 'signup') {
        bg.classList.add('bg-move-right'); // 100vw
      } else {
        bg.classList.add('bg-move-left'); // -200px
      }

      // 다시 중앙 위치로 복귀 + 카드 이동
      setTimeout(() => {
        applyTransitionState(targetMode);
      }, 50);

      // 페이지 리로드 (모드 전환)
      setTimeout(() => {
        window.location.href = `?mode=${targetMode}`;
      }, 550);
    };
  });
</script>
```
