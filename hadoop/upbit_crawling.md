업비트 api로 1분에 한 번씩 로그를 기록해서 원하는 정보 HDFS에 저장

## 1. `import requests`로 url 가져오기

```py
import requests

# 업비트 api 활용
upbit_url = 'https://api.upbit.com/v1/ticker?markets=KRW-BTC'

res = requests.get(upbit_url)
data = res.json()
```
## 2. 1분에 한번씩 반복하며 데이터를 리스트에 추가
```py
while time.time() - start_time < 60:
    res = requests.get(upbit_url)
    data = res.json()[0]

    bit_data = [
        data['market'],
        data['trade_date'],
        data['trade_time'],
        data['trade_price']
    ]
    bit_data_list.append(bit_data)
    time.sleep(10)
```
## 3. 저장로직
```py
local_file_path = '/Users/m2/damf2/data/bitcoin/'
now = datetime.now()
file_name = now.strftime('%H%M%S') + '.csv'

with open(local_file_path + file_name, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(bit_data_list)
```
## 4. cron 자동화
- `*/5 * * * * /Users/m2/damf2/automation/venv/bin/python /Users/m2/damf2/automation/1.upbit-api/0.upbit-data.py`
- `*/5 * * * * /Users/m2/damf2/automation/venv/bin/python /Users/m2/damf2/automation/1.upbit-api/1.upload_to_hdfs.py`
