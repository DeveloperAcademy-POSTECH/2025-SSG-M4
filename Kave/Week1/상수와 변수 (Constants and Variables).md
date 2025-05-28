>[!question]
>GQ1. 상수, 변수란 무엇일까?
>GQ2. Swift에서 어떻게 사용할까?
>GQ3. 선언, 사용 시 주의해야 할 부분이 있을까?

## 상수와 변수
**상수(Constants)**
- 항상 같은 수, 사전에 값이 미리 지정되어 있으며 차후에 변경이 불가능하다.
- let을 사용하여 선언한다.

**변수(Variables)
- 변할 수 있는 수, 코드가 진행되며 값이 변경될 수 있다.
- var을 사용하여 선언한다.

**타입 지정(Type Annotations)**
상수와 변수 모두 사용하기 전에 **반드시** 선언이 되어야 한다. 

```swift
let maximumNumberOfLoginAttemps = 10
var currentLoginAttempt = 0
```

위와 같은 코드가 존재 할 때, 최대 로그인 시도 횟수는 항상 고정되어야 있어야 하므로 **상수**를 사용하여 선언되었고, 현재 로그인 시도 횟수는 로그인을 시도할때마다 바뀌기 때문에 **변수**를 사용하여 선언되었다.

상수와 변수는, '수' 가 붙어서 '숫자' 일 것이라고 생각을 할 수 있으나, **타입 명시** 를 통해서 어떤 타입의 값이 **상수**와 **변수** 에 들어갈것인지를 지정할 수 있다. 

예를 들어,

```Swift
var welcomeMessage: String
```

이러한 코드에서 welcomeMessage라는 변수(var)은 String이라고 타입이 명시되었기 때문에 String값이 해당 변수에 들어갈 수 있게 된다. 

>Swift는 상수, 변수를 선언할 때 초기값을 지정하면 자동으로 어떤 타입이 들어갈지 유추해주는 기능이 존재한다.


## 상수와 변수의 출력
```Swift
let welcomeMessage = "Hello, Swift!"
print(welcomeMessage)
// "Hellow, Swift!" 가 출력된다.
```
``print()`` 함수를 사용하여 상수, 또는 변수의 현재 값을 출력할 수 있다. 해당 값은 사용중인 IDE의 console창으로 출력된다.

## Keywords
[상수], [변수], [타입 지정], [출력]

## References
- [The Swift Programming Language]