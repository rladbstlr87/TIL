# 집합
## 메소드 종류
- `union()`
![합집합](https://mblogthumb-phinf.pstatic.net/MjAyMTA0MDZfMjc2/MDAxNjE3NzAyODg3MTgy.mlHx87TcMEK1QiW8RVWoBpBa_UXEEUFHHY_0a7XdgvEg.v0shvfXya9-33NTSRBal3HFMPUNNST1B5rup8jBteJwg.PNG.nicholasdw/image.png?type=w800)
- `intersection()`
![교집합](https://mblogthumb-phinf.pstatic.net/MjAyMTA0MDZfMTYg/MDAxNjE3NzAyOTEzNTE3.gqIHNsSXvBPlEcIPQM9cBCuR1_FRa5kJNK9Bs5HTRm4g.WLOFnPkJPhmfU9UXy1HqLzFRIkGDHOxpK_SEl32dp_Mg.PNG.nicholasdw/image.png?type=w800)
- `difference()`
![차집합](https://mblogthumb-phinf.pstatic.net/MjAyMTA0MDZfMjM2/MDAxNjE3NzAzMDExOTU1.x-31KlqBJko39ZKve4Fgsg5JZq200zdzVcEgdf0p_yAg.ZbDLg49VAvgY37vFqxwjRKg22bHrz9fmGltb3cq5JsIg.PNG.nicholasdw/image.png?type=w800)
- `symmetric_difference()`
![대칭차집합](https://mblogthumb-phinf.pstatic.net/MjAyMTA0MDZfMTU4/MDAxNjE3NzAzMDkwOTQ0.zk-M4PLjhLbyiE7z5vHHO4lfJCOmc7svXc-pd3wd0qgg.m6uec-pq7GVzQZ-qlSyFj0HqRmwYT2e6ZPsxS7YImeUg.PNG.nicholasdw/image.png?type=w800)
....
- `set.메소드종류()`은 두 집합의 집합계산 결과를 반환하는 메소드다.
- 이 메소드는 **인자**로 전달된 다른 집합과 집합계산에 따른 원소들을 반환한다.

### 기본구조
```py
set1.union(set2)
set1.intersection(set2)
set1.difference(set2)
set1.symmetric_difference(set2)
```

### **예시**  
#### **Stage 1**: 기본 사용법
```python
s1 = set([1, 2, 3, 4, 5, 6])
s2 = set([4, 5, 6, 7, 8, 9])

print('s1 | s2', s1 | s2)           # s1 | s2 {1, 2, 3, 4, 5, 6, 7, 8, 9}
print('s1 | s2', s1.union(s2))      # s1 | s2 {1, 2, 3, 4, 5, 6, 7, 8, 9}
```

#### **Stage 2**: 여러 집합과의 교집합
```python
set1 = {1, 2, 3}
set2 = {2, 3, 4}
set3 = {3, 5, 6}
result = set1.intersection(set2, set3)
print(result)  # {3}
```

#### **Stage 3**: 교집합을 다른 자료형에 적용
```python
set1 = {'apple', 'banana', 'cherry'}
set2 = {'banana', 'cherry', 'date'}
result = set1.intersection(set2)
print(result)  # {'banana', 'cherry'}
```

### **What it can do**
- 여러 집합과 교집합을 계산할 수 있다.
- 교집합이 비어있을 경우 빈 집합을 반환한다.
- 리스트나 튜플과 같은 다른 자료형에 대해서도 `set()`을 사용하여 교집합을 구할 수 있다.

### **주요 특징**
- `intersection()`은 원본 집합을 변경하지 않으며, 새로운 집합을 반환한다.
- `&` 연산자와 동일한 결과를 얻을 수 있다.

### **Stage 2 예시 (연산자 활용)**  
```python
result = set1 & set2 & set3  # {3}
print(result)
```