# Java 기본 예제

## 1. HelloWorld

### 기본구조
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

- 가장 기본적인 Java 프로그램
- JVM이 실행하는 진입점 main 메서드 포함

- args: 프로그램 실행 시 전달되는 문자열 배열

### For example
#### ex.1-1
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```
#### ex.1-2
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("안녕하세요, 자바!");
    }
}
```
#### ex.1-3
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("첫 번째 Java 실행 예제");
    }
}
```

### What it can do?
#### ex.level.2
- 다양한 문자열 출력
```java
System.out.println("Hello, Java!");
System.out.println("Hello, World!");
System.out.println("Java 기초 배우기");
```
#### ex.level.3
- 연속 출력 및 줄바꿈/줄합치기
```java
System.out.print("Hello");
System.out.print(" ");
System.out.println("Java!");
```

---

## 2. DataTypePrinter

### 기본구조
```java
public class DataTypePrinter {
    public static void main(String[] args) {
        int i = 42;
        double d = 3.14;
        char c = 'A';
        boolean b = true;
        String s = "hello";

        printWithType(i);
        printWithType(d);
        printWithType(c);
        printWithType(b);
        printWithType(s);
    }

    public static void printWithType(Object obj) {
        System.out.println("값: " + obj + " | 타입: " + obj.getClass().getSimpleName());
    }

    public static void printWithType(int value) {
        printWithType(Integer.valueOf(value));
    }
}
```

- 다양한 자료형의 값과 해당 타입을 출력하는 예제
- Object 타입으로 받아 getClass().getSimpleName()으로 클래스명 확인
- 기본형은 래퍼 클래스(Integer, Double 등)로 박싱하여 타입 확인

- i: 정수형(int)
- d: 실수형(double)
- c: 문자형(char)
- b: 불리언(boolean)
- s: 문자열(String)

### For example
#### ex.1-1
```java
printWithType(100);
printWithType(5.5);
printWithType('Z');
printWithType(false);
printWithType("Test");
```
#### ex.1-2
```java
int age = 25;
double height = 175.5;
char grade = 'A';
boolean pass = true;
String name = "Alice";
printWithType(age);
printWithType(height);
printWithType(grade);
printWithType(pass);
printWithType(name);
```
#### ex.1-3
```java
char symbol = '#';
printWithType(symbol);
```

### What it can do?
#### ex.level.2
- 배열의 각 요소의 값과 타입 출력
```java
Object[] arr = {1, 2.5, 'X', false, "Array"};
for (Object o : arr) {
    printWithType(o);
}
```
#### ex.level.3
- 제네릭 메서드로 타입별 출력 확장
```java
public static <T> void printGeneric(T value) {
    System.out.println("값: " + value + " | 타입: " + value.getClass().getSimpleName());
}
```

---

# 작성 규칙
- 강조 표시(`**`)는 사용하지 않음
- 모든 내용은 개조식으로 작성
- 문장은 명사형으로 종결하며, 불필요한 서술어('~함', '~임')는 생략
