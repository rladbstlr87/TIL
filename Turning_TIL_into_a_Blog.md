# TIL 블로그화
github 레포지토리를 블로그화 하는걸 지인을 통해 알게 되었습니다. 여러 장점이 있는 것으로 보여서 진행해보고자 하는데 우선 설치해야할 것이 많다는 것을 알았습니다.

# install
1. Node.js 설치
```
brew install node
```
- 설치 확인
```
node -v
npm -v
```
- 버전 권장 사항
    - Node.js : LTS(16.x 이상 권장)
    - npm : 8.x 이상 권장

2. lerna, yarn 설치
```
brew install lerna yarn
```
- 설치 확인
```
lerna -v
yarn -v
```

3. React와 TypeScript 설치
관리할 워크스페이스(폴더)로 경로를 이동한 후 진행
```
yarn add react react-dom typescript @types/react @types/react-dom
yarn add gatsby
```

4. launch
    1. 첫번째 터미널에서 `yarn run:playground`를 실행한다
    2. 두번째 터미널을 만들어서 `yarn run:core`를 실행한다