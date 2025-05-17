# CSS 선택자
CSS에서 마크업 언어의 요소를 선택하는 문자
## 선택 방법
종류는 이거 말고 더 있음
1. ID 선택자
`#ID` : 해당 ID의 요소를 선택. ID는 하나의 요소에 무조건 고유값을 가지기 때문에 골라오기 가장 편함
2. 클래스 선택자
`.클래스` : 해당 클래스의 요소를 선택한다. 클래스 여러 개가 모두 있는 요소를 선택할 경우 `.foo.bar`처럼 해당 클래스명을 붙여서 씀

## 활용 방법
HTML 태그 안에 입력되는 속성들은 생각의 흐름대로 반복돌리며 찾을 수도 있다
```
try:
    fastball_divs = driver.find_elements(By.CSS_SELECTOR, 'div.item')
    fastball_info = None

    for div in fastball_divs:
        try:
            # 이 div가 '직구평균구속'을 포함하는지 확인
            span_text = div.find_element(By.CSS_SELECTOR, 'span').text
            if '직구평균구속' in span_text:
                # 해당 div에서 tooltip 속성이 있는 span 찾기
                tooltip_span = div.find_element(By.CSS_SELECTOR, 'div.rang_info span[tooltip]')
                fastball_info = tooltip_span.get_attribute('tooltip')
                print(f"\n직구평균구속 정보: {fastball_info}")
                
                # 툴팁 값(예: "7위: 151.6")에서 숫자만 추출하고 싶은 경우
                if fastball_info:
                    speed_match = re.search(r':\s*(\d+\.\d+)', fastball_info)
                    if speed_match:
                        speed_value = speed_match.group(1)
                        print(f"직구 평균 구속: {speed_value} km/h")
                
                break  # 찾았으면 반복 종료
except:
    continue
```
