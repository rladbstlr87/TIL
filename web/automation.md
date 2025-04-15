# automation
## NewBT 문제은행에서 문제들 수집
html에서 한 문제씩 감질나게 풀기싫고, 문제들을 한 번에 뽑아서 종이로 인쇄해서 풀고싶으면 이거 쓰세요. 근데 파일로 저장하는 코드는 없습니다
- 정적 html 정보를 가져올 수 있는 BeautifulSoup4와 웹 조작 자동화 할 수 있는 Selenium으로 기출문제들을 수집하는 코드
- newbt_url은 원하는 과목으로 들어가서 나오는 첫번째 url을 선택
- `webdriver.Chrome()`를 통해 다음문제로 넘어가는 작동구현

```python
import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import re

driver = webdriver.Chrome() # 크롬드라이버

newbt_url = 'https://newbt.kr/문제/62306/' # `/문제/`의 다음 숫자들만 문제에 따라 바뀌는 url 구조
driver.get(newbt_url)

res = requests.get(newbt_url)

next_question = driver.find_element(By.CSS_SELECTOR, 'a.btn.btn-info') # a태그의 btn btn-info가 다음문제로 넘어가는 버튼의 클래스로 지정되어 있었다

for i in range(5): # range의 인수를 통해 가져오고 싶은 문제 수를 지정
    soup = BeautifulSoup(driver.page_source, 'html.parser') # `.page_source`는 현재 브라우저에 로드된 웹 페이지의 HTML 소스 코드 전체를 문자열로 가져옴
    
    # 문제부분
    h5 = soup.select_one('#main > div > div.col-sm-8.blog-main > div.blog-post.question > h5')
    for span in h5.find_all('span', class_='number'):
        span.extract()
    question = h5.get_text()

    # 보기부분
    li_list = soup.select('#main > div > div.col-sm-8.blog-main > div.blog-post.question > ul > li')
    options = [
        re.sub(r'^(①|②|③|④)', r'\1 ', li.get_text(strip=True)) # 원형 숫자 ①, ②, ③, ④ 그룹화. 첫 번째 그룹(원형 숫자)을 참조하여 그 다음에 나오는 보기의 본문 사이에 띄어쓰기 한 칸.
        for li in li_list
    ]

    print('\n' + f'{i+1}. {question}\n' + '\n'.join(options))

    try:
        # 윗줄에서 print로 출력하고 다음문제 버튼 클릭 및 5초 대기. 대기 초가 너무 빠르면 다음페이지 넘어가기전에 문제를 먼저 수집해버림
        next_question = driver.find_element(By.CSS_SELECTOR, 'a.btn.btn-info')
        next_question.click()
        time.sleep(5)
    except:
        break
```
