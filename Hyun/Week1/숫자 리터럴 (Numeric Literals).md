----
- 정수 리터럴
	- 접두사 없는 _10진수_
    - `0b-`: _2진수_
    - `0o-`: _8진수_
    - `0x-`: _16진수_
```
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
```

- 부동소수 리터럴
	- 10진수
		- 접두사 없음
		- 소수점 양쪽에 항상 숫자가 있어야 함
		- 대문자 또는 소문자 e로 표시되는 _지수_ 를 가질 수도 있음
			- 지수가 `x` -> 기본 숫자에 10ˣ 가 곱해짐
			- `1.25e2` 는 1.25 x 10², 또는 `125.0`
			- `1.25e-2` 는 1.25 x 10⁻² , 또는 `0.0125`
	- 16진수
		- 접두사 `0x`
		- 소수점 양쪽에 항상 16진수가 있어야 함
		- 대문자 또는 소문자 p로 표시되는 _지수_ 를 가질 수도 있음
			- 지수가 `x` -> 16진수는 기본 숫자에 2ˣ 가 곱해짐
			- `0xFp2` 는 15 x 2² , 또는 `60.0`
			- `0xFp-2` 는 15 x 2⁻² , 또는 `3.75`
```
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1 // == 12.1875
let hexadecimalDouble = 0xC.3p0 // == 12.1875
```

---
- 읽기 쉽게 만드는 추가 포맷 포함 가능
	- 정수와 부동 소수점 모두 추가 0으로 채워질 수 있음
	- 가독성을 돕기 위해 밑줄 포함 가능
	- 어떤 형식도 리터럴의 기본 값에 영향을 주지 않음
```
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```