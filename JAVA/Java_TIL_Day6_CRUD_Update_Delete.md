# Java 기초 - 6일차 교안
## 주제: CRUD 구현 ② Update & Delete

---

## 1. CRUD 복습
- Create: 데이터 생성
- Read: 데이터 조회
- Update: 데이터 수정
- Delete: 데이터 삭제

오늘은 **Update**와 **Delete**를 직접 구현합니다.

---

## 2. Update (데이터 수정)
ArrayList에서 특정 위치의 값을 변경하려면 `set()` 메서드를 사용합니다.

```java
ArrayList<String> todoList = new ArrayList<>();
todoList.add("운동하기");
todoList.add("책 읽기");

// 1번 인덱스 값을 "코딩하기"로 변경
todoList.set(1, "코딩하기");
```

- `set(인덱스, 새로운값)` : 지정한 위치의 데이터를 새로운 값으로 바꿈
- 인덱스 범위를 벗어나면 오류 발생

---

## 3. Delete (데이터 삭제)
ArrayList에서 데이터를 삭제하려면 `remove()` 메서드를 사용합니다.

```java
// 인덱스로 삭제
todoList.remove(0); // 0번 인덱스 삭제

// 값으로 삭제
todoList.remove("코딩하기"); // 해당 값 삭제
```

- 값으로 삭제 시, 첫 번째로 일치하는 값만 제거

---

## 4. Scanner로 Update & Delete 구현

```java
import java.util.ArrayList;
import java.util.Scanner;

public class Day6Practice {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<String> todoList = new ArrayList<>();

        // 초기 데이터
        todoList.add("운동하기");
        todoList.add("책 읽기");
        todoList.add("청소하기");

        System.out.println("현재 할 일 목록: " + todoList);

        // Update
        System.out.print("수정할 항목 번호(0부터 시작): ");
        int idx = sc.nextInt();
        sc.nextLine(); // 줄바꿈 제거
        System.out.print("새로운 내용: ");
        String newTask = sc.nextLine();
        todoList.set(idx, newTask);

        // Delete
        System.out.print("삭제할 항목 번호(0부터 시작): ");
        int delIdx = sc.nextInt();
        todoList.remove(delIdx);

        System.out.println("\n변경된 할 일 목록: " + todoList);
        sc.close();
    }
}
```

---

## 5. 오늘의 미니 실습
1. 친구 이름 5개를 ArrayList에 추가
2. Scanner로 수정할 친구의 인덱스와 새 이름을 입력받아 변경
3. Scanner로 삭제할 친구의 인덱스를 입력받아 삭제
4. 최종 친구 목록 출력

예시 코드:
```java
import java.util.ArrayList;
import java.util.Scanner;

public class FriendList {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<String> friends = new ArrayList<>();

        // 친구 이름 입력
        for (int i = 0; i < 5; i++) {
            System.out.print("친구 이름 입력: ");
            friends.add(sc.nextLine());
        }

        // 수정
        System.out.print("수정할 인덱스: ");
        int idx = sc.nextInt();
        sc.nextLine();
        System.out.print("새 이름: ");
        String newName = sc.nextLine();
        friends.set(idx, newName);

        // 삭제
        System.out.print("삭제할 인덱스: ");
        int delIdx = sc.nextInt();
        friends.remove(delIdx);

        // 최종 목록 출력
        System.out.println("\n최종 친구 목록:");
        for (String friend : friends) {
            System.out.println(friend);
        }

        sc.close();
    }
}
```
