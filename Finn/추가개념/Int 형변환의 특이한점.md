### 문제 상황

Swift에서 문자열의 각 문자를 숫자로 변환할 때의 코드 흐름 

```swift title:Int->String->Char->String->Int
let num = 12345
for char in String(num) {
    print(type(of: char)) // Character
    let digit = Int(String(char))! // Character → String → Int
}
```

**왜 `Character`를 바로 `Int`로 변환할 수 없는가???**

## Character vs Int의 본질적 차이

### 1. Character의 정체성

Swift에서 `Character`는 **단일 Unicode 스칼라 값!** ([공식문서 - Character](https://developer.apple.com/documentation/swift/character))
`{swift icon title=String정의}@frozen public struct String {`

>[! 정리]
>`Character`: 단일 유니코드 스칼라 값 (하나의 문자).
>`String`: `Character`들의 sequence로 모인 컬렉션 
>`Int`: 정수 값을 나타내는 숫자 타입 그자체
>

```swift title:Character저장방식
let char: Character = "5"
print(char) // "5" (문자)
// Character자체는 Unicode U+0035로 저장
```

`Character` `"5"`는 숫자 5가 아닌 **문자 "5"** (Unicode U+0035)로 취급.
생긴게 똑같아도 내부적으로는 완전히 다른 데이터임을 명심!!

```swift title:Character-String비교_불가❌
let char: Character = "5"
let k: String = "5"

print(char == k)
```

### 2. Int 초기화의 한계

Swift의 `Int` 초기화 메서드를 살펴보면 다음과 같은데... 

```swift
// String, UInt,Float16, Float32,Double ..등등 존재하는데,
init?(_ description: String)

// Character넣는거는 없다 ! 
init?(_ character: Character) // ❌
```

Swift는 `Character`, `String` 둘 중에서 `Int`로의 변환은 `String`만 제공하고 있어서 
`Character`에서 직접 변환하는건 안됩니다 ! 

### 왜 이렇게?  그냥 되게해주면 되는거 아닌가요 ?

```swift
let validChars: [Character] = ["1", "2", "3"]
let invalidChars: [Character] = ["a", "가", "🎉"]

// 모든 Character가 숫자는 아니라서, 결국 안전한 변환을 위해서 String을 거치게 설계됨. 이유는 뭐 찾아보니까 엄청 다양하던데, 결론은 혼란을 줄이기 위함
```

## 1. 기존에 활용하던 방식

```swift
let number = 12345

for char in String(number) {
    let digit = Int(String(char))!
    print("문자 '\(char)'는 숫자 \(digit)")
}

// 출력:
// 문자 '1'는 숫자 1
// 문자 '2'는 숫자 2
// ...
```

## 2. 새로 발견한 wholeNumberValue

더 효율적인 방법으로 `Character`에 `wholeNumberValue` 프로퍼티라는게 있더라구요 ?! 
`Int`로 안바뀌는 친구를 집어넣으면 `nil`이 나오는 프로퍼티입니다.

```swift
let number = 12345

for char in String(number) {
    if let digit = char.wholeNumberValue {
        print("문자 '\(char)'는 숫자 \(digit)")
    } else {
        print("'\(char)'는 숫자가 아닙니다")
    }
}
```
- wholeNumberValue사용하면 String쓰는거처럼 형변환이 가능하다 
```swift
let testChars: [Character] = ["0", "5", "9", "a", "가", "🎉"]

for char in testChars {
    if let value = char.wholeNumberValue {
        print("'\(char)' → \(value)")
    } else {
        print("'\(char)' → nil (숫자 아님)")
    }
}
// '0' → 0
// '5' → 5
// '9' → 9
// 'a' → nil (숫자 아님)
// '가' → nil (숫자 아님)
// '🎉' → nil (숫자 아님)
```

>[! wholeNumberValue 동작방식]
>**Unicode 기반 변환**
>1. **Unicode 값 확인**: Character의 Unicode 스칼라 값을 가져옴
>2. **범위 검증**: U+0030("0")부터 U+0039("9") 사이인지 확인
>3. **숫자 계산**: `Unicode값 - 48`로 실제 숫자 계산 (0이 `ascii 48` ~  9가 `ascii 57`)
>4. **결과 반환**: 유효하면 `Int` 아니면 `nil` 반환 

[[Ascii VS Unicode]]

```swift
// 내부 동작 예시입니다! 그냥 감만 보시면 될 듯 ! 실제는 좀 다름 
extension Character {
    var wholeNumberValue: Int? {
        let unicodeValue = self.unicodeScalars.first?.value
        if let value = unicodeValue,
           value >= 48 && value <= 57 {
            return Int(value - 48)
        }
        return nil
    }
}
//var b : Character = "a"
//print(b.wholeNumberValue)
```


```swift title:사용예시
let char: Character = "7"
// 55 - 48 = 7
print(char.wholeNumberValue) // Optional(7)
```

## 실제 활용 예시

```swift title:wholeNumberValue+reduce
func sumOfNumArray(_ number: Int) -> Int {
    return String(number)
        .compactMap { $0.wholeNumberValue }
        .reduce(0, +)
}

print(sumOfNumArray(12345)) // 15
```

```swift title:안전_숫자_파싱
func parsing(from input: String) -> [Int] {
    return input.compactMap { char in
        char.wholeNumberValue
    }
}

let mixed = "a1b2c3d"
print(parsing(from: mixed)) // [1, 2, 3]
```
