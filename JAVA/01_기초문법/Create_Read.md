# Java 기초 - 5일차 교안
## 주제: CRUD 구현 ① Create & Read

---

## 1. CRUD 복습
- Create: 데이터 생성
- Read: 데이터 조회
- Update: 데이터 수정
- Delete: 데이터 삭제

오늘은 **Create**와 **Read**를 직접 구현해 봅니다.

---

## 2. Scanner로 입력받기
사용자에게 데이터를 입력받아 ArrayList에 저장합니다.

```java
import java.util.ArrayList;
import java.util.Scanner;

public class Day5Practice {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<String> todoList = new ArrayList<>();

        // Create - 사용자 입력 받기
        System.out.println("할 일을 3개 입력하세요:");
        for (int i = 0; i < 3; i++) {
            System.out.print((i+1) + "번째 할 일: ");
            String task = sc.nextLine();
            todoList.add(task);
        }

        // Read - 전체 목록 출력
        System.out.println("\n=== 전체 할 일 목록 ===");
        for (String task : todoList) {
            System.out.println("- " + task);
        }

        sc.close();
    }
}
```

---

## 3. Create (데이터 생성)
- `add()` 메서드로 ArrayList에 데이터 추가
- 사용자 입력이나 코드로 직접 값 넣기 가능

예시:
```java
todoList.add("운동하기");
todoList.add("책 읽기");
```

---

## 4. Read (데이터 조회)
- 전체 목록 출력
- 특정 인덱스 조회
- 조건 검색

예시:
```java
// 전체 출력
for (String task : todoList) {
    System.out.println(task);
}

// 인덱스로 특정 값 출력
System.out.println(todoList.get(0));

// 조건 검색
for (String task : todoList) {
    if (task.contains("운동")) {
        System.out.println("운동 관련 할 일: " + task);
    }
}
```

---

## 5. 오늘의 미니 실습
1. Scanner로 이름 5개를 입력받아 ArrayList에 저장
2. 전체 이름 출력
3. 이름 중 '김'으로 시작하는 사람만 출력

예시 코드:
```java
import java.util.ArrayList;
import java.util.Scanner;

public class NameList {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<String> names = new ArrayList<>();

        for (int i = 0; i < 5; i++) {
            System.out.print("이름 입력: ");
            names.add(sc.nextLine());
        }

        System.out.println("\n전체 이름 목록:");
        for (String name : names) {
            System.out.println(name);
        }

        System.out.println("\n'김'으로 시작하는 이름:");
        for (String name : names) {
            if (name.startsWith("김")) {
                System.out.println(name);
            }
        }

        sc.close();
    }
}
```
