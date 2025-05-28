----
>분수가 아닌 전체 숫자.
>_부호가 있는 정수 (signed) (양수, 0, 또는 음수)._
>_부호가 없는 정수 (unsigned) (양수 또는 0)._
- Swift는 8, 16, 32, 그리고 64 비트 형태의 부호가 있는 정수와 부호가 없는 정수를 지원
	- `UInt8`: 8-bit 부호가 없는 정수
	- `Int32`: 32-bit 부호가 있는 정수

## 정수 범위 (Integer Bounds)
---
```
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

## Int
---
- Swift는 현재 플랫폼의 네이티브 사이즈와 같은 `Int` 인 정수 타입 제공
	- 32-bit 플랫폼에서 `Int` 는 `Int32` 와 같은 크기 가짐
    - 64-bit 플랫폼에서 `Int` 는 `Int64` 와 같은 크기 가짐
    => 특정 크기의 정수로 작업해야 하는 경우가 아니라면 항상 코드의 정수 값을 사용할 때 `Int`  사용
	    (코드 일관성과 상호 운용성 지원)

## UInt
---
- Swift는 현재 플랫폼의 네이티브 사이즈와 같은 `UInt` 인 정수 타입 제공
	- 32-bit 플랫폼에서 `UInt` 는 `UInt32` 와 같은 크기 가짐
    - 64-bit 플랫폼에서 `UInt` 는 `UInt64` 와 같은 크기 가짐

‼️ 플랫폼의 네이티브 사이즈와 같은 크기의 부호없는 정수 타입이 필요한 경우에만 사용 ‼️
- 저장될 값이 음수가 아니어도 `Int` 를 더 선호
- 코드 상호 운용성 지원
- 다른 숫자 형식간에 변환 할 필요 없음
	[[타입 세이프티와 타입 추론 (Type Safety and Type Inference)]]