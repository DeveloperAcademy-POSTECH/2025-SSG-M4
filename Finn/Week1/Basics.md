### Swift는 [[Type-safe]]언어

### 상수와 변수 
이름과 특정 타입을 연결 
### [[상수 선언]]
사용하기 전에 선언되어야 한다. 


```swift title:상수와_변수_선언
var environment = "development"
let maximumNumberOfLoginAttempts: Int
// maximumNumberOfLoginAttempts has no value yet.

if environment == "development" {
    maximumNumberOfLoginAttempts = 100
} else {
    maximumNumberOfLoginAttempts = 10
}
```

### 타입 명시 (Type Annotations)
```swift
 var welcomeMessage: String
```
- _선언한 변수 -`welcomeMessage` _ 타입 -_ `String` _

#### **여러개 선언**
```swift
var red, green, blue: Double
```

### 상수와 변수 이름은 문자,이모지 다 가능 

```swift
let n = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```
### 출력하기 [[문자열 삽입]]

```swift title:문자열_삽입
let friendlyWelcome : String = "你好"
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// Prints "The current value of friendlyWelcome is Bonjour!"
```

### 주석 

>[!정의]
>코드에서 설명 또는 기록을 위해 실행되지 않는 문자들이며, 컴파일될때는 swift 컴파일러에 의해 무시됨

1. 한줄 주석
`{swift icon} // This is a comment.`
2. 여러줄 주석
	```swift
	/* This is also a comment
	but is written over multiple lines. */
	```
3. 중첩
	```swift
	/* This is the start of the first multiline comment.
	 /* This is the second, nested multiline comment. */
	This is the end of the first multiline comment. */
	```

### 세미콜론
> 여러 구문을 한줄로 작성할 경우 세미콜론은 _필수로 작성되어야 합니다_

### 정수 
> 정수는 _부호가 있는 정수 (signed) (양수, 0, 또는 음수)_ 또는 _부호가 없는 정수 (unsigned) (양수 또는 0)_ 이 있습니다.


#### 정수범위

```swift title:각_정수타입_최대값_최소값
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```


#### Int

>[!팁]
>Swift는 현재 플랫폼의 네이티브 사이즈와 같은 `Int` 인 정수 타입을 제공합니다
>
- 32-bit 플랫폼에서 Int 는 Int32 와 같은 크기
- 64-bit 플랫폼에서 Int 는 Int64 와 같은 크기
### [[Int.max 관련 문제]]

#### UInt

>[!팁]
>Swift는 현재 플랫폼의 네이티브 사이즈와 같은 `UInt` 인 정수 타입을 제공합니다
>
- 32-bit 플랫폼에서 UInt 는 UInt32 와 같은 크기
- 64-bit 플랫폼에서 UInt 는 UInt64 와 같은 크기

###  [[Int vs UInt]]

### 부동 소수점 숫자 (Floating-Point Numbers)
> [!정의]
> 부동 소수점 숫자 (Floating-point numbers) 는 3.14159, 0.1, 및 -273.15와 같은 분수 성분을 가진 숫자입니다.

- 부동 소수점은 정수 타입의 값 범위보다 더 넓은 범위의 표현이 가능 `Int` 보다 더 크거나 작은 값 저장이 가능. Swift는 2개의 부호를 가진 [[부동 소수점]] 숫자 타입을 제공함


### 타입 세이프티와 타입 추론 (Type Safety and Type Inference)
- 간단히 말하면 타입 선언 안해줬을 때 알아서 추측해서 때려넣는다는 의미

```swift title:타입추론_예시
let age : Int = 3 
let ageWithoutType = 4


print(type(of: age))
print(type(of: ageWithoutType))
```

그래서 이게 Int로 이미 추론이 된 상황이라면 String이 들어갈 수 없음
```swift title:타입추론_오류예시
var age : Int = 3 
age += "안녕하세요"
print(type(of: age))
```


### 숫자 리터럴

- 10진수 (접두사 없음)
- `0b` 접두사로 _2진수_
- `0o` 접두사로 _8진수_
- `0x` 접두사로 _16진수_

```swift title:정수_리터럴_예시
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
```


```swift title:밑줄포함_값에_영향안줌!!!
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

#### 어떻게 바꿀 수 있나? 10진수를 다른진수로 바꿔보기! 

```swift 
var v = 999999
// 2진수
print(String(v,radix:2))

// 16진수
var sixteen = String(v,radix:16)
print(sixteen)


```

#### 그러면 다른진수를 10진수로 어떻게 바꿔요 ??! 

```swift title:다른진수->10진수_변환
let v = 999

let sixteen = String(v,radix:16)

var 원본 = Int(sixteen,radix:16)!
print(원본)
```

#### 오잉 그럼 Int에는왜 !가 있어요? 왜 옵셔널인가요 ?! 

⸻


- 불변성`LET의` 의도 전달
	- let을 사용하는 건 단순히 값이 바뀌지 않는다는 의미를 넘어서 바뀌지않는 상수라는 의도를 코드에 표현하는 것에도 의의가 있음
- 불변 객체의 장점
	- 상태가 고정된 변수는 디버깅이 쉬워지고, 멀티스레드 환경에서도 안정적이야.



```swift title:불변객체_장점
struct User {
    let name: String
    let age: Int
}
```