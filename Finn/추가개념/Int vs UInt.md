
> [!definition]
> **Int**는 부호가 있는 정수(signed integer)로, 양수, 0, 음수를 모두 표현할 수 있습니다.  
> **UInt**는 부호가 없는 정수(unsigned integer)로, 양수와 0만 표현할 수 있습니다.

---

## 🔍 주요 차이점 비교

| 특성       | Int                 | UInt                  |
|------------|---------------------|------------------------|
| 부호       | 있음 (±)            | 없음 (+)              |
| 범위       | -2^(n-1) ~ 2^(n-1)-1 | 0 ~ 2^n - 1           |
| 메모리 크기 | n비트               | n비트                 |

---

## 시스템별 범위 
##### UInt는 음수가 없고 그만큼 양수 양을 늘린 친구입니다.

- **32비트 시스템**
  - `Int32`: -2,147,483,648 ~ 2,147,483,647
  - `UInt32`: 0 ~ 4,294,967,295

- **64비트 시스템**
  - `Int64`: -9,223,372,036,854,775,808 ~ 9,223,372,036,854,775,807
  - `UInt64`: 0 ~ 18,446,744,073,709,551,615

---

## 🧠 고려사항

```swift title:Int,UInt_max
let minInt = Int.min    // -9,223,372,036,854,775,808 (64비트)
let maxInt = Int.max    //  9,223,372,036,854,775,807
let minUInt = UInt.min  // 항상 0
let maxUInt = UInt.max  // 18,446,744,073,709,551,615 (64비트)
```

> [!warning]
> `Int.max`를 초과하는 연산은 **오버플로우**가 발생할 수 있습니다.
>
> ```swift 
> var answer = Int.max
> answer += 1  // ❗️오버플로우!

> ```

> 대안: `var answer = Int(Int32.max)` 처럼 더 작은 정수 타입 사용

---

## 🍎 Swift에서의 권장 사항

> [!tip]
> Apple은 특별한 이유가 없다면 **항상 `Int`를 기본 정수 타입으로 사용할 것**을 권장하고 있습니다.
> *"Unless you need to work with a specific size of integer, always use Int for integer values in your code."* - [출처](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/)

- **일관성**: 전체 코드에서 정수 타입 일관 유지
- **변환 최소화**: 다른 정수 타입과의 형 변환 감소

---

## 🔄 타입 변환 시 주의사항

```swift
let intValue: Int = 42
let uintValue: UInt = UInt(intValue)  // ✅ Int → UInt

let negativeValue: Int = -10
let invalidUInt = UInt(negativeValue)  // ❌ 런타임 오류!
```

---

### 그래서 뭐 쓰면 되는데 ? Int 🆚 UInt 

- UInt는 거의 안 씀: 실제 iOS 프로젝트에선 UInt보다 Int가 압도적으로 많이 사용돼. 이유는 연산 혼합 시 타입 변환이 귀찮고 오류를 만들기 쉬움.
- Double vs Float: 대부분의 경우 Double을 사용. 
  정밀도 면에서 우수하고 Swift의 기본 부동소수점 타입도 Double.

```swift
let a = 0.1       // 추론: Double
let b: Float = 0.1 // 명시하지 않으면 안 됨
```


## 📚 관련 개념 링크

- [[부동 소수점]]
- [[Type-safe]]
- [[Int.max 관련 문제]]
