# function

## 양꼬치 문제
- 머쓱이네 양꼬치 가게는 10인분을 먹으면 음료수 하나를 서비스로 줍니다. 양꼬치는 1인분에 12,000원, 음료수는 2,000원입니다. 정수 n과 k가 매개변수로 주어졌을 때, 양꼬치 n인분과 음료수 k개를 먹었다면 총얼마를 지불해야 하는지 return 하도록 solution 함수를 완성해보세요.
- 0 < n < 1,000
- n / 10 ≤ k < 1,000
- 서비스로 받은 음료수는 모두 마십니다.

### 나의 풀이
```python
def solution(n, k):
    yang = 12000
    drink = 2000
    answer = yang * n + drink * k
    if n // 10 >= 1: # 몫을 구하면 (몫 * k)를 빼면 해결됨
        answer = answer - n // 10 * drink
    else:
        answer = answer
    return answer

print(solution(10, 3))
print(solution(64, 6))
```
### 더 좋은 풀이 1
```python
def solution(n, k):

    if n >= 10:
        service = n // 10
        answer = n * 12000 + (k - service) * 2000
    else:
        answer = n * 12000 + k * 2000

    return answer

print(solution(10, 3))
print(solution(64, 6))
```
### 더 좋은 풀이 2
```python
def solution(n, k):

#            양꼬치총액   음료수총액  서비스음료수가격
    answer = n * 12000 + k * 2000 - n // 10 * 2000

    return answer

print(solution(10, 3))
print(solution(64, 6))
```

### 재도전
- 스스로 다시 생각해보고 식을 먼저 작성하고 대입해보자
- answer = 양꼬치 총액 + 음료수 총액에서 양꼬치 인분수에 따라 - 음료수값 인거다
- 양꼬치 총액 = n * 12000
- 음료수 총액 = k * 2000
- 서비스 음료수값 = n // 10 * 2000

answer에 각 식을 대입하고 잊지말고 return answer하자

---
## 배열의 평균값

### 나의 풀이
- 처음엔 못풀었다
```python
def solution(numbers):
    # numbers가 list로 선언되야함<<필요없었음
    numbers = [*number]
    # list에 어떤 원소가 몇개 있는지 파악하고 각 원소의 값을 가져와야함
    # numbers의 list[*] / n개
    sum(numbers)
    
    return answer

print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
print(solution([89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99]))
```

### 더 좋은 풀이
```python
def solution(numbers):
    answer = sum(numbers) / len(numbers)

    return answer

print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
print(solution([89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99]))
```

### 재도전
```python
def solution(numbers):
# list의 모든 인수를 더해주는 sum(numbers)를 쓴다
# list의 갯수를 반환하는 len(numbers)로 나눈다
    answer = sum(numbers) / len(numbers)

    return answer
    
print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
print(solution([89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99]))
```

---
## 짝수의 합
- 정수 n이 주어질 때, n이하의 짝수를 모두 더한 값을 return 하도록 solution 함수를 작성해주세요.

### 나의 풀이
```python
def solution(n):
    n = 0
    # n은 for i in range(0: (n + 1) % 2): 의 합 근데 for 안에 if들어가야될거같음
    # 아닌가 if 안에 for 들어가야되나
    # n을 어떻게 리스트로 풀어서 반환해야 하는가
    for n in range(n + 1): # << n이 아니라 i를 입력했어야햇다
    # 반환한 리스트를 어떻게 합산하는가
        n = sum(range((n + 1) % 2))

    return answer
```
- 너무 어렵게 생각했다

### 더 좋은 풀이
```python
def solution(n):
    answer = 0

    for i in range(n+1):
        if i % 2 == 0:
            answer += i

    return answer

print(solution(10))
print(solution(4))
```

### 더 좋은 풀이2
```python
def solution(n):
    answer = 0

    for i in range(2, n+1, 2):
        answer += i

    return answer

print(solution(10))
print(solution(4))
```
### 재도전
