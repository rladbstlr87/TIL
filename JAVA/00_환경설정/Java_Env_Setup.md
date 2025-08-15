# TIL - Java 환경 설정 및 실행 점검

## 1. JDK 설치 확인
- 설치 버전 확인
  ```bash
  java -version
  javac -version
  ```
- 결과:  
  - Java 1.8.0_292 (AdoptOpenJDK)  
  - javac 1.8.0_292

## 2. JAVA_HOME 설정 (macOS)
- 일시 적용
  ```bash
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  echo $JAVA_HOME
  ```
- 영구 적용 (`~/.zshrc`)
  ```bash
  echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)' >> ~/.zshrc
  echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
  exec $SHELL -l
  ```

## 3. IntelliJ IDEA 프로젝트 설정
- **프로젝트 SDK**: JDK 1.8 선택
- **언어 수준**: 8 – 람다, 타입 애노테이션 등
- **모듈 설정**  
  - 소스 루트(`src`) 지정 (파란색 표시)
  - 모듈 SDK = 프로젝트 SDK(1.8)
- **플랫폼 설정 → SDK**  
  - 경로: `/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home`
  - Classpath에 `rt.jar` 포함 확인

## 4. 실행 구성 설정
- 실행 → 구성 편집…
  - 메인 클래스: 실행할 클래스 지정
  - JRE: 프로젝트 SDK (1.8)
  - 클래스 경로: 해당 모듈 지정

## 5. 기본 실행 테스트
### HelloWorld.java 작성
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
    }
}
```

### 터미널에서 실행
```bash
cd src
javac HelloWorld.java   # 컴파일 → HelloWorld.class 생성
java HelloWorld         # 실행
```
- 출력: `Hello, Java!`

## 6. 자주 쓰는 명령어
- 컴파일 + 실행 한 줄로:
  ```bash
  javac HelloWorld.java && java HelloWorld
  ```
- 실행 후 클래스 삭제까지:
  ```bash
  javac HelloWorld.java && java HelloWorld && rm HelloWorld.class
  ```

## 7. 문제 해결 경험
- `String`, `System` 빨간줄 오류: 모듈 SDK를 JDK로 재지정 후 해결
- `메인 클래스 선택` 비활성화: main 메서드 시그니처 점검 → `public static void main(String[] args)`
- `javac` 실행 시 파일 없음 오류: 터미널에서 해당 .java 파일이 있는 디렉터리로 이동 후 실행
