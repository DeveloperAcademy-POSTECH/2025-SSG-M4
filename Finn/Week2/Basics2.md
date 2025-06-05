## 숫자 타입 변환
- 상수와 변수가 정수로 사용이 되면 `Int`
>[!특이사항]
>외부 소스에서 명시적으로 크기가 지정된 데이터 또는 성능, 메모리 사용, 또는 다른 성능 최적화를 위해 특별히 필요한 경우에만 다른 정수 타입을 사용하십시오. 이러한 상황에서 [[명시적 정수 표현|명시적으로 크기의 타입을 사용]]하면 실수로 인한 값 초과를 포착하고 사용중인 데이터의 특성을 알 수 있습니다.

### 정수 변환
```swift title:정수타입_값초과
let cannotBeNegative: UInt8 = -1  // (0~255)니까 안됨!
// UInt8 cannot store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max + 1  // 255 + 1 하니까 범위 밖이라 터짐
// Int8 cannot store a number larger than its maximum value,
// and so this will also report an error

```
[[Int.max 관련 문제|컴파일 오류 실제경험한 사례]]

```swift title:변환후_연산
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
print(UInt16.max)
print(type(of:twoThousandAndOne))  // UInt16
```

### 정수와 부동 소수점 변환 
둘이 더해줄때는 무조건 형변환으로 맞춰줘야함 `Float + Double`도 불가
```swift error:3
let three = 3
let pointOneFourOneFiveNine = 0.14159
//print(three+pointOneFourOneFiveNine)// Error
let pi = Double(three) + pointOneFourOneFiveNine
//print(pi)
// pi equals 3.14159, and is inferred to be of type Double
```


```swift title:Optional여부
var pi = 3.14
var s = "99"
print(Int(s))
print(String(pi))
```
[[Int 형변환의 특이한점 | Deepdive Int 형변환]]

### [[TypeAliases ]]
>![Definition]
>타입 별칭은 외부 소스에서 특정 크기의 데이터로 작업할 때와 같이 **상황에 맞는 이름으로 기존 타입을 참조**하려는 경우에 유용합니다:

`typealias 거북이나이 = UInt8`

```swift title:거북이승천
typealias 거북이나이 = UInt8

var 거북이승천나이 = 거북이나이.max

print(거북이승천나이)
```

### Booleans
>[! Definition]
>`true` or `false` 이면서 타입은 `Bool`
>조건문에서 주로 사용 

[[라벨문|흐름제어 간단팁]]

