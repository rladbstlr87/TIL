# 03 JSX 기초
- JSX는 JS 안에서 HTML처럼 UI를 적을 수 있게 돕는 문법
- className으로 CSS 클래스를 지정하고 style에는 JS 객체를 넣음
- 중괄호{}로 JS 값이나 표현식을 바로 바인딩
- 반환 JSX는 한 개의 루트 요소로 감싸야 함

## 프로젝트 예시: [page.tsx](../../lightbearer/web/src/pages/teaser/page.tsx)
- className와 style을 함께 쓰며 동적 배경 이미지를 설정
```tsx
<div 
  className="fixed inset-0 bg-cover bg-center bg-no-repeat"
  style={{
    backgroundImage: `url('https://readdy.ai/api/search-image?query=Cosmic%20galaxy%20background%20with%20stars%20and%20nebula%2C%20deep%20space%20universe%20with%20bright%20stellar%20formations%2C%20purple%20and%20blue%20cosmic%20colors%2C%20ethereal%20light%20beams%20connecting%20distant%20stars%2C%20mystical%20space%20atmosphere%20with%20glowing%20particles%20and%20cosmic%20dust&width=1920&height=1080&seq=cosmic-bg-1&orientation=landscape')`
  }}
>
  <div className="absolute inset-0 bg-black/40"></div>
</div>
```
- 템플릿 리터럴을 중괄호로 감싸 동적 값을 전달하는 구조를 눈으로 익히기
