/**
 * Variable 선언하기
 * 
 * 1) var - 더이상 쓰지 않는다
 * 2) let
 * 3) const
 */

var name = '코드팩토리';
console.log(name);

var age = 32;
console.log(age);

let ive = '아이브';
console.log(ive);

/**
 * let과 var로 선언하면
 * 값을 추후 변경할 수 있다.
 * const는 고정
 */
ive = '안유진';
console.log(ive);

const newJeans = '뉴진스';
console.log(newJeans);

// newJeans = '돌아옴';

/**
 * 선언과 할당
 * 
 * 1) 선언 : 변수를 선언하는 것
 * 2) 할당 : 값을 넣는 것
 * 
 * 선언만 하고 할당 안하면 undefined
 */

let girlFriend;
console.log(girlFriend);

/**
 * const girlFriend2;
 * 안됨
 */
