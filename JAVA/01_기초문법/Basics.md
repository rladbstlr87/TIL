# Java 기초 - 2일차 교안
## 주제: 자료형, 변수, 연산자

---

## 1. 자료형(데이터의 종류)
프로그래밍에서 "자료형"은 **변수가 어떤 종류의 값을 저장할 수 있는지**를 나타냅니다.

### 1.1 기본형(Primitive)
- **숫자형**
  - byte: 아주 작은 정수 (-128 ~ 127)
  - short: 작은 정수
  - int: 일반 정수 (가장 많이 사용)
  - long: 큰 정수
  - float: 소수점이 있는 숫자 (작은 범위)
  - double: 소수점이 있는 숫자 (큰 범위, 많이 사용)
- **문자형**
  - char: 문자 1개 (예: 'A', '가')
- **논리형**
  - boolean: 참(true) 또는 거짓(false)

### 1.2 참조형(Reference)
- 값이 아니라 **값이 저장된 주소**를 저장
- String: 글자들의 모임 (문자열)
- 기본형을 객체로 감싸는 "래퍼 클래스"도 포함 (Integer, Double, Boolean 등)

---

## 2. 변수 선언과 초기화
- **변수**: 데이터를 저장하는 상자
- **선언**: 어떤 자료형의 상자를 만들지 결정
- **초기화**: 상자 안에 처음 값을 넣는 것

예시:
```java
int age;       // 변수 선언
age = 15;      // 값 넣기(초기화)
int year = 2025; // 선언과 초기화를 한 번에
```

---

## 3. 연산자
연산자는 값과 값 사이에서 계산이나 비교를 하는 기호입니다.

### 3.1 산술 연산자
- 더하기(+), 빼기(-), 곱하기(*), 나누기(/), 나머지(%)
```java
int a = 10, b = 3;
System.out.println(a + b); // 13
System.out.println(a - b); // 7
System.out.println(a * b); // 30
System.out.println(a / b); // 3 (정수 나눗셈)
System.out.println(a % b); // 1 (나머지)
```

### 3.2 비교 연산자
- 크다(>), 작다(<), 크거나 같다(>=), 작거나 같다(<=), 같다(==), 같지 않다(!=)
```java
int x = 5, y = 8;
System.out.println(x > y);  // false
System.out.println(x < y);  // true
System.out.println(x == y); // false
System.out.println(x != y); // true
```

### 3.3 논리 연산자
- 그리고(&&), 또는(||), 부정(!)
```java
boolean p = true;
boolean q = false;
System.out.println(p && q); // false (둘 다 참이어야 참)
System.out.println(p || q); // true  (하나라도 참이면 참)
System.out.println(!p);     // false (반대)
```

---

## 4. 오늘의 미니 실습
1. 나이, 이름, 키를 저장할 변수를 만들고 값 넣기
2. 나이를 1 더한 값을 출력
3. 키가 160cm 이상인지 비교해서 결과 출력
4. 이름이 "홍길동"인지 비교해서 결과 출력

예시 코드:
```java
public class Day2Practice {
    public static void main(String[] args) {
        int age = 15;
        String name = "홍길동";
        double height = 165.5;

        System.out.println("내년 나이: " + (age + 1));
        System.out.println("키가 160 이상인가? " + (height >= 160));
        System.out.println("이름이 홍길동인가? " + name.equals("홍길동"));
    }
}
```
