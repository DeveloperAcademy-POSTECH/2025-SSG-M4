---

---
---
>이름과 특정 타입의 값을 연결

- **상수(Constant)**: 값 최초 지정 후 변경 불가능
- **변수(Variable)**: 값 최초 지정 후 다른 값으로 변경 가능

## 상수와 변수 선언 (Declaring Constants and Variables)
---
！*사용되기 전에 반드시 선언이 되어야 함*！

- **상수** -> `let`
	- Ex) max, min
	- 선언 시 값 할당
		- 단, 처음 값을 읽기 전에 값의 존재가 보장되면 선언 이후에도 초기화 값 할당 가능
		- [[상수 선언 (Constant Declaration)]]
- **변수** -> `var`
	- Ex) currentValue
	- 선언 시, 후 언제든 값 할당 가능

+) 여러 개 선언 시 콤마로 구분하여 한줄 선언 가능
```
var x = 0.0, y = 0.0, z = 0.0
```

## 타입 명시 (Type Annotations)
---
>상수 또는 변수를 선언할 때 저장할 수 있는 값의 종류를 명확하게 함

```
var welcomeMessage: String

var red, green, blue: Double
```
-> 상수 또는 변수 이름 뒤에 콜론과 공백 한칸 뒤에 사용할 타입 이름을 적어 사용

## 상수와 변수의 이름 (Naming Constants and Variables)
---
- 가능
	- 유니코드 (Unicode) 문자를 포함하여 대부분의 문자 가능
- 불가능
	- 공백, 수학적 기호, 화살표, 내부에서 사용하는 유니코드 스칼라 값, 또는 선과 박스를 그리는 문자
		- ~~Swift 키워드와 동일한 이름의 상수 또는 변수를 제공해야 한다면 이름을 백틱 (`` ` ``)으로 묶어야 하지만, 선택의 여지가 없을때까지는 키워드를 이름으로 사용하지 말아야 함~~
	- 숫자로 시작하는 이름
	- 특정 타입으로 상수 또는 변수를 선언하면 동일한 이름으로 다시 선언하거나 다른 타입의 값을 저장하도록 변경하여 선언
	- 상수를 변수로 바꾸거나 변수를 상수로 변경

## 상수와 변수 출력 (Printing Constants and Variables)
---
`print(_:separator:terminator:)`
```
print(friendlyWelcome)
// Prints "Bonjour!"
```
- Xcode "콘솔 (console)" 창에 결과를 출력
- `separator` 와 `terminator` 파라미터는 기본 값을 가지고 있으므로 함수를 호출할 때 생략 가능
	- [[파라미터 기본값 (Default Parameter Values)]]
- 기본적으로 개행 문자 출력
	- 개행 없애려면 terminator에 ""값 지정
		`print(someValue, terminator: "")`

```
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// Prints "The current value of friendlyWelcome is Bonjour!"
```
- [[문자열 삽입(String interpolation)]]
	- 긴 문자열에 상수 또는 변수의 이름을 포함하여 Swift가 상수 또는 변수의 현재 값으로 대체