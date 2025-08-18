# Java 기초 - 3일차 교안
## 주제: 제어문, 메서드, 클래스 기본

---

## 1. 제어문(Control Statement)
제어문은 프로그램의 흐름(순서)을 바꾸는 명령입니다.

### 1.1 if / else
조건이 참일 때만 특정 코드를 실행하거나, 참/거짓에 따라 다른 코드를 실행합니다.
```java
int score = 85;
if (score >= 90) {
    System.out.println("A등급");
} else if (score >= 80) {
    System.out.println("B등급");
} else {
    System.out.println("C등급");
}
```

### 1.2 switch
여러 경우(case) 중 하나를 선택해 실행합니다.
```java
int month = 3;
switch (month) {
    case 3:
    case 4:
    case 5:
        System.out.println("봄");
        break;
    case 6:
    case 7:
    case 8:
        System.out.println("여름");
        break;
    default:
        System.out.println("기타 계절");
}
```

### 1.3 반복문
같은 코드를 여러 번 실행할 때 사용합니다.

- for: 횟수가 정해진 반복
```java
for (int i = 1; i <= 5; i++) {
    System.out.println(i + "번째 반복");
}
```

- while: 조건이 참일 때 계속 반복
```java
int n = 1;
while (n <= 5) {
    System.out.println(n + "번째 반복");
    n++;
}
```

- do-while: 조건을 나중에 검사 (최소 1번 실행)
```java
int m = 1;
do {
    System.out.println(m + "번째 반복");
    m++;
} while (m <= 5);
```

---

## 2. 메서드(Method)
메서드는 코드 묶음(기능)입니다.

### 2.1 메서드 구조
```java
리턴타입 메서드이름(매개변수들) {
    실행할 코드
    return 값; // 리턴타입이 void면 return 필요 없음
}
```

### 2.2 예시
```java
public static int add(int a, int b) {
    return a + b;
}

public static void main(String[] args) {
    int sum = add(3, 5);
    System.out.println("합: " + sum);
}
```

### 2.3 특징
- 매개변수: 메서드가 입력으로 받는 값
- 리턴값: 메서드가 실행 후 돌려주는 값
- `void`: 리턴값이 없는 경우 사용

---

## 3. 클래스와 객체
클래스는 설계도, 객체는 설계도로 만든 물건입니다.

### 3.1 클래스 만들기
```java
public class Car {
    String color;
    int speed;

    void drive() {
        System.out.println(color + " 자동차가 달립니다.");
    }
}
```

### 3.2 객체 만들기
```java
public static void main(String[] args) {
    Car myCar = new Car();
    myCar.color = "빨간색";
    myCar.speed = 100;
    myCar.drive();
}
```

---

## 4. 오늘의 미니 실습
1. `multiply` 메서드 만들어 두 숫자의 곱을 반환하기
2. if문으로 양수/음수/0 판별하기
3. for문으로 1부터 10까지 합 구하기
4. `Person` 클래스 만들고 이름, 나이 출력 메서드 작성

예시 코드:
```java
public class Day3Practice {
    public static int multiply(int a, int b) {
        return a * b;
    }

    public static void main(String[] args) {
        // 1
        System.out.println("곱: " + multiply(4, 5));

        // 2
        int num = -3;
        if (num > 0) System.out.println("양수");
        else if (num < 0) System.out.println("음수");
        else System.out.println("0");

        // 3
        int sum = 0;
        for (int i = 1; i <= 10; i++) {
            sum += i;
        }
        System.out.println("1~10 합: " + sum);

        // 4
        Person p = new Person();
        p.name = "홍길동";
        p.age = 15;
        p.introduce();
    }
}

class Person {
    String name;
    int age;

    void introduce() {
        System.out.println("이름: " + name + ", 나이: " + age);
    }
}
```
