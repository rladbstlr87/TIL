# Java 기초 - 7일차 교안
## 주제: 구조 정리 및 확장

---

## 1. 실행 흐름 설계
CRUD 프로그램을 깔끔하게 만들기 위해 실행 흐름을 설계합니다.

### 1.1 메뉴 반복
- `while(true)`로 프로그램이 계속 실행되도록 함
- `switch`문으로 사용자가 선택한 메뉴에 따라 다른 동작 실행

```java
while (true) {
    System.out.println("=== 메뉴 ===");
    System.out.println("1. 추가");
    System.out.println("2. 조회");
    System.out.println("3. 수정");
    System.out.println("4. 삭제");
    System.out.println("5. 종료");
    System.out.print("선택: ");
    
    int choice = sc.nextInt();
    sc.nextLine(); // 줄바꿈 제거
    
    switch (choice) {
        case 1: // 추가
            break;
        case 2: // 조회
            break;
        case 3: // 수정
            break;
        case 4: // 삭제
            break;
        case 5:
            System.out.println("프로그램 종료");
            return;
        default:
            System.out.println("잘못된 선택");
    }
}
```

---

## 2. DTO 클래스 만들기
DTO(Data Transfer Object)는 데이터를 담는 전용 클래스입니다.

```java
public class Todo {
    String task;
    boolean done;
}
```

- 나중에 기능이 늘어나도 구조가 깔끔하게 유지됨

---

## 3. Service 클래스 만들기
실제 기능(추가, 조회, 수정, 삭제)을 모아 놓는 클래스입니다.

```java
import java.util.ArrayList;

public class TodoService {
    ArrayList<Todo> list = new ArrayList<>();
    
    public void addTask(String task) {
        Todo t = new Todo();
        t.task = task;
        t.done = false;
        list.add(t);
    }
    
    public void showTasks() {
        for (int i = 0; i < list.size(); i++) {
            System.out.println(i + ": " + list.get(i).task + " (완료: " + list.get(i).done + ")");
        }
    }
    
    public void updateTask(int idx, String newTask) {
        list.get(idx).task = newTask;
    }
    
    public void deleteTask(int idx) {
        list.remove(idx);
    }
}
```

---

## 4. Main 클래스에서 실행
```java
import java.util.Scanner;

public class MainApp {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        TodoService service = new TodoService();
        
        while (true) {
            System.out.println("\n=== 메뉴 ===");
            System.out.println("1. 추가");
            System.out.println("2. 조회");
            System.out.println("3. 수정");
            System.out.println("4. 삭제");
            System.out.println("5. 종료");
            System.out.print("선택: ");
            
            int choice = sc.nextInt();
            sc.nextLine();
            
            switch (choice) {
                case 1:
                    System.out.print("할 일 입력: ");
                    service.addTask(sc.nextLine());
                    break;
                case 2:
                    service.showTasks();
                    break;
                case 3:
                    System.out.print("수정할 인덱스: ");
                    int uIdx = sc.nextInt();
                    sc.nextLine();
                    System.out.print("새 내용: ");
                    service.updateTask(uIdx, sc.nextLine());
                    break;
                case 4:
                    System.out.print("삭제할 인덱스: ");
                    int dIdx = sc.nextInt();
                    service.deleteTask(dIdx);
                    break;
                case 5:
                    System.out.println("프로그램 종료");
                    sc.close();
                    return;
                default:
                    System.out.println("잘못된 선택");
            }
        }
    }
}
```

---

## 5. 오늘의 미니 실습
1. `Book` 클래스 만들기 (제목, 저자)
2. `BookService` 클래스에서 추가, 조회, 수정, 삭제 기능 구현
3. `MainApp`에서 메뉴 방식으로 동작하게 만들기

예시 DTO:
```java
public class Book {
    String title;
    String author;
}
```

예시 Service:
```java
import java.util.ArrayList;

public class BookService {
    ArrayList<Book> list = new ArrayList<>();
    
    public void addBook(String title, String author) {
        Book b = new Book();
        b.title = title;
        b.author = author;
        list.add(b);
    }
    
    public void showBooks() {
        for (int i = 0; i < list.size(); i++) {
            System.out.println(i + ": " + list.get(i).title + " - " + list.get(i).author);
        }
    }
    
    public void updateBook(int idx, String title, String author) {
        list.get(idx).title = title;
        list.get(idx).author = author;
    }
    
    public void deleteBook(int idx) {
        list.remove(idx);
    }
}
```
