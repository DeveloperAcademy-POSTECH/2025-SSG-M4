Sequence의 필수 메서드이다 왜냐??
1. 반복을 가능하게 해주는 `Iterator 객체` 반환하고
2. makelterator()를 통해서 for-in 반복문, map,filter 같은 고차 함수가 동작 가능하기 때문이다.

`Iterator 객체`
- `IteratorProtocal`을 준수하고
- 내부적으로 "현재 어디까지 순회했나" 상태를 기억하고, `next() 메서드`로 값을 반환하다가 더 이상 값이 없으면 nil 반환

`IteratorProtocal`
- Swift 표준 라이브러리 프로토콜이며 값을 하나씩 순차적으로 반환하는 메커니즘을 정의한다.
	1. 반환할 타입을 지정한다.
	2. 다음 값을 반환하거나 끝나면 'nil'을 반환한다.
  
  
`next() 메서드`
- `IteratorProtocol`에서 가장 중요한 메서드로, 
	1. 호출 될 때마다 현재 인덱스의 값을 반환하고 상태 변경한다(인덱스 이동), 값이 없으면 'nil'을 반환하여 반복 종료를 알림
```swift
mutating func next() -> Element?
//Element란 Iterator가 다루는 값의 타입을 반환한다는 뜻이다.
//mutating 키워드가 붙은 이유는, 내부 상태(인덱스)를 변경하기 때문이다.
```

###  `next() 메서드` 이해를 돕는 예시 코드

```swift
struct CountdownIterator: IteratorProtocol {
    var count: Int
    mutating func next() -> Int? {
        guard count > 0 else { return nil }  // 종료 조건
        defer { count -= 1 }                 // 다음 호출을 위해 상태 변경
        return count                        // 현재 값 반환
    }
}

var iterator = CountdownIterator(count: 3)
while let number = iterator.next() {        // next() 메서드 호출
    print(number)                           // next()의 Element는 Int
}
// 출력값
// 3
// 2
// 1
```
