# string methods and functions
## 1. slpit
```python
'str'.split()
'str'.split('sep')
'str'.split(sep='sep', 'maximum split')
'str'.split(sep='sep', maxsplit='maximum split')
```

- 인터넷창을 스플릿뷰 즉, 나누어 보는것처럼 문자열을 잘라준다. 그러면서 리스트가 됨
- str을 sep(separation)의 구분자를 기준으로 maxsplit 횟수만큼 잘라서 list로 반환함

```python
'str'.split('sep') # sep은 띄어쓰기나 ',' '.' 등이 들어갈 수 있음
'str'.split(sep='sep', 'maximum split') # maxsplit자리는 생략할 수 있고 입력하면 숫자만큼 칼질한다. 그럼 나눠진 문자열은 칼질횟수+1이 됨
'str'.split('sep', 'maximum split') # 쓰기 편한 방식
```

### For example
#### ex.1-1
```py
sentence = "Python is fun to learn!"
words = sentence.split()  
print(words)  # ['Python', 'is', 'fun', 'to', 'learn!']
```
#### ex.1-2
```py
emoji_text = "🍕Pizza🍔Burger🌭Hotdog"
foods_name = emoji_text.split("🍕🍔🌭")  
print(foods_name)  # ['', 'Pizza', 'Burger', 'Hotdog']
```
#### ex.1-3
```py
sentence = "apple,banana,cherry,orange,grape"
split_sentence = sentence.split(",", maxsplit=2)
print(split_sentence)  # ['apple', 'banana', 'cherry,orange,grape']
```
### What can it do?
- CSV 파일처럼 구분자로 구분된 데이터를 처리하는 경우에 유용합니다. 데이터를 분할한 후, int() 함수를 사용하여 숫자를 처리하거나, join() 메서드를 이용해 다시 합칠 수 있습니다.
#### ex.2
```py
data = "John,Doe,30,New York"
fields = data.split(",")  

# 나이를 정수로 변환하고, 나머지는 출력
age = int(fields[2])  # '30'을 정수로 변환
location = fields[3]  # 'New York'

print(f"Name: {fields[0]} {fields[1]}, Age: {age}, Location: {location}")
# Output: Name: John Doe, Age: 30, Location: New York
```
- 활용 : split()으로 나눈 후, 나이를 숫자로 변환하거나, 다른 작업을 할 수 있습니다. 예를 들어, 나이를 기준으로 어떤 조건을 추가하거나, 다른 데이터를 변형할 수 있습니다.
#### ex.3
- 심지어이런것까지할수있다
```py
poem = "Roses are red;Violets are blue;Sugar is sweet;And so are you"
lines = poem.split(";", maxsplit=2)  

# 첫 번째와 두 번째 구절을 이어붙여서 새로운 시를 만든다
new_poem = " - ".join(lines[:2])  # 'Roses are red - Violets are blue'
print(new_poem)  # Output: Roses are red - Violets are blue
```
- 활용 : split()과 maxsplit을 활용해 
---
## 2. strip
## 3. upper / lower / swapcase
## 4. startswith / endswith