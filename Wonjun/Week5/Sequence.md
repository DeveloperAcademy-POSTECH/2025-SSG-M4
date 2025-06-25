swift에서 "값들의 연속적인 집합"을 표현하는 [[프로토콜]] 

값들의 연속적인 집합, 즉 배열(Array) ,딕셔너리(Dictionary), 범위(Range), Set 등 다양한 컬렉션 타입을 나타내는데 Sequence가 사용된다.

> 이를 위해서 Sequence는 [[makelterator()]] 메서드가 꼭 필요하다!

```swift
// 1. Iterator 정의
struct IntIterator: IteratorProtocol {  <---------------"2"   
    var current: Int
    let end: Int

    mutating func next() -> Int? {
        guard current < end else { return nil }
        defer { current += 1 }
        return current
    }
}

// 2. Sequence 정의
struct Ints: Sequence {
    let start: Int
    let end: Int

    func makeIterator() -> IntIterator {  <---------------"1"
        IntIterator(current: start, end: end)
    }
}

// 3. 사용 예시
for number in Ints(start: 0, end: 3) {  <---------------"3"
    print(number)
}
// 출력: 0
//      1
//      2
```

### 주요 메서드
1. first - 시퀀스의 첫 번째 요소를 Optional(값이 없을 때 nil)값으로 반환한다. (Set은 순서가 없어 임의의 요소를 반환한다.)
2. isEmpty - 시퀀스가 비어 있는지 여부를 Bool값으로 반환한다.
3. prefix( \_:) - 앞에서부터 지정한 개수만큼의 요소를 추출해 새로운 시퀀스로 반환한다
4. suffix( \_:) - 위에서부터 지정한 개수만큼의 요소를 추출해 새로운 시퀀스로 반환한다
5. [[고차 함수]](map, filter,reduce,contains(where:),forEach)
```swift
//주요 메서드 예시
let numbers = [2, 4, 6, 8, 10, 12]

let first = numbers.first // Optrional(2)
let isEmpty = numbers.isEmpty // false
let firstTwo = names.prefix(2) // [2, 4]
let lastThree = numbers.suffix(3) // [8, 10, 12]
```
   