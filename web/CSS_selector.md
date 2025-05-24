# CSS 선택자
CSS에서 마크업 언어의 요소를 선택하는 문자
## 선택 방법
종류는 이거 말고 더 있음
1. ID 선택자
`#ID` : 해당 ID의 요소를 선택. ID는 하나의 요소에 무조건 고유값을 가지기 때문에 골라오기 가장 편함
2. 클래스 선택자
`.클래스` : 해당 클래스의 요소를 선택한다. 클래스 여러 개가 모두 있는 요소를 선택할 경우 `.foo.bar`처럼 해당 클래스명을 붙여서 씀

## 활용 방법
HTML 태그 안에 입력되는 속성들은 반복돌리며 찾을 수도 있다
```
speed = ''
try:
    target_item = driver.find_elements(By.CLASS_NAME, 'item')
    for div in target_item:
        # div가 '직구평균구속'을 포함하는지 확인
        label = div.find_element(By.TAG_NAME, 'span').text
        if '직구평균구속' in label:
            tooltip = div.find_element(By.CSS_SELECTOR, 'div.rang_info > span').get_attribute('tooltip')
            if '위' in tooltip:
                speed_raw = tooltip.split(' ')[1]
                speed = round(float(speed_raw), 1)
            else:
                speed = round(float(tooltip), 1)
except:
    speed = '-'
```
