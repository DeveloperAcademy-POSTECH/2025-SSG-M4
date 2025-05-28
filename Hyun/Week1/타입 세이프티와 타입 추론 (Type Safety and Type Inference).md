>**Swift는 _타입-세이프 (type-safe)_ 언어**
- 코드가 사용할 수 있는 값의 타입을 명확하게 알 수 있음
- 값 타입 실수 방지
- 코드를 컴파일 할 때 타입 검사를 수행하고 일치하지 않는 타입을 오류로 표시

‼️ 선언하는 모든 상수와 변수의 타입을 지정해야 한다는 것은 아님 ‼️
- 필요한 값의 특정 타입을 지정하지 않으면 Swift는 적절한 타입으로 **_타입 추론 (Type Inference)_** 사용
- 선언하는 시점에 상수 또는 변수에 리터럴 값 (literal value) 또는 리터럴 (literal)을 지정하여 수행
	- [[리터럴 값(Literal Value)와 리터럴(Literal)]]
	- `Int` -> `Int`
	- `Float`, `Double` -> `Double`
	- `Int` + `Double` -> `Double`
	