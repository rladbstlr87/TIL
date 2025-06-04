# JIT
- Tailwind CSS에서 JIT(Just-In-Time) 모드는 빌드 시점에 필요한 클래스만 실시간으로 생성하는 방식
- 실제로 사용된 클래스만 포함하므로 성능과 유연성 면에서 이점이 큼

### JIT 모드 핵심
- Just-In-Time 방식: 클래스가 사용되는 순간, 즉시 CSS가 생성됨.
- 사용된 것만 포함 → 결과 CSS 파일 크기 대폭 감소
- 클래스를 자유롭게 조합 가능 (`w-[123px]`, `top-[42%]` 등)

### 기존 방식(CLI 기반)과 차이점

|항목|기존 Preflight 방식|JIT 모드|
|---|---|---|
|CSS 생성 시점|미리 생성 (build 시 전체 생성)|사용 시 실시간 생성 (JIT)|
|커스텀 클래스 지원|제한적 (w-1/2, p-4 등만)|매우 유연 (w-[123px] 등 가능)|
|CSS 파일 크기|매우 큼|매우 작음|
|개발 속도|느림|빠름|
|Purge 설정 필요 여부|필요함|보통 필요 없음 (자동 인식)|


### JIT 모드가 중요해지는 이유
#### For examples
```html
card.classList.add('left-[150px]');
```
- 이 클래스는 동적 문자열이므로 Tailwind는 일반적으로 인식하지 못함.
- JIT 모드는 실제 빌드 시 HTML/JS/Template에서 이 문자열이 보이면 동적으로 만들어줌.
- 하지만, 완전히 동적인 문자열 (예: classList.add('left-' + x + 'px')) 은 여전히 인식 못함 → 이 경우는 Safelist 필요


#### 주의사항
	•	classList.add(dynamicValue)처럼 완전히 동적인 클래스명은 Tailwind가 인식 못 함
	•	해결법: safelist 설정
	•	예:
```html
// tailwind.config.js
module.exports = {
  safelist: ['left-[150px]', 'right-[150px]', 'bg-move-left', 'bg-move-right'],
}
```
