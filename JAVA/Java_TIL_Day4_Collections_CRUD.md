# Java 기초 - 4일차 교안
## 주제: 컬렉션(List)과 CRUD 기초

---

## 1. 컬렉션(Collection)이란?
- 많은 데이터를 한 번에 다루기 위한 자료 구조
- Java에서 제공하는 여러 가지 컬렉션 중, 오늘은 `List`를 사용

### 1.1 List의 특징
- 순서가 있음 (인덱스: 0부터 시작)
- 같은 값을 중복해서 저장할 수 있음
- ArrayList는 List의 대표적인 구현체

---

## 2. ArrayList 사용하기

### 2.1 선언과 생성
```java
import java.util.ArrayList;

ArrayList<String> fruits = new ArrayList<>();
```

### 2.2 데이터 추가 (Create)
```java
fruits.add("사과");
fruits.add("바나나");
fruits.add("포도");
```

### 2.3 데이터 읽기 (Read)
```java
System.out.println(fruits.get(0)); // "사과"
System.out.println(fruits.get(1)); // "바나나"
```

### 2.4 데이터 수정 (Update)
```java
fruits.set(1, "수박"); // 1번 인덱스의 "바나나" → "수박"
```

### 2.5 데이터 삭제 (Delete)
```java
fruits.remove(0); // 0번 인덱스 값 삭제
```

### 2.6 크기 확인
```java
System.out.println(fruits.size()); // 현재 저장된 데이터 개수
```

---

## 3. CRUD 기본 개념
CRUD는 데이터를 다루는 네 가지 기본 동작을 뜻합니다.

1. **Create** - 새 데이터 만들기
2. **Read** - 데이터 읽기/검색
3. **Update** - 기존 데이터 수정
4. **Delete** - 데이터 삭제

---

## 4. ArrayList로 CRUD 실습

```java
import java.util.ArrayList;

public class Day4Practice {
    public static void main(String[] args) {
        ArrayList<String> todoList = new ArrayList<>();

        // Create
        todoList.add("숙제하기");
        todoList.add("방 청소");
        todoList.add("책 읽기");

        // Read
        System.out.println("전체 할 일 목록:");
        for (String item : todoList) {
            System.out.println("- " + item);
        }

        // Update
        todoList.set(1, "방 대청소");

        // Delete
        todoList.remove(0);

        // 변경 후 목록
        System.out.println("\n변경된 할 일 목록:");
        for (String item : todoList) {
            System.out.println("- " + item);
        }
    }
}
```

---

## 5. 오늘의 미니 실습
1. 좋아하는 음식 목록을 ArrayList로 만들고 3개 추가하기
2. 첫 번째 음식을 다른 음식으로 수정하기
3. 마지막 음식 삭제하기
4. 최종 목록 출력하기

예시 코드:
```java
import java.util.ArrayList;

public class FoodList {
    public static void main(String[] args) {
        ArrayList<String> foods = new ArrayList<>();

        foods.add("피자");
        foods.add("치킨");
        foods.add("햄버거");

        foods.set(0, "파스타");
        foods.remove(foods.size() - 1);

        for (String food : foods) {
            System.out.println(food);
        }
    }
}
```
