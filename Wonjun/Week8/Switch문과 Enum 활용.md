Switch문은 값에 따라 여러 case로 나누어 동작을 지정한다.
따라서 Enum과 함께 쓰면, 각 case별로 명확하게 분기할수 있다.

```swift
let now: Season = .summer

switch now {
case .spring:
    print("봄입니다.")
case .summer:
    print("여름입니다.")
case .autumn:
    print("가을입니다.")
case .winter:
    print("겨울입니다.")
}
Enum의 모든 case를 빠짐없이 선언하면 `default` case가 필요 없습니다.
```

## Switch문과 Enum의 장점
- **타입 안정성**: Enum 타입만 switch문에 들어올 수 있어, 잘못된 값이 들어오는 것을 방지한다.
- **가독성**: 각 case가 명확하게 드러나 코드가 읽기 쉽다.
- **오타 방지**: 문자열이나 숫자 대신 Enum을 사용해 오타로 인한 오류를 줄인다.
- **불필요한 default 제거**: Enum의 모든 case를 처리하면 default 분기가 필요 없어 코드가 더 명확해진다.

## [[연관값과 원시값|연관값]]이 있는 Enum과 Switch문
```swift
enum State {
    case loading(progress: Int)
    case success(message: String)
    case failure(error: String)
}

let current = State.loading(progress: 70)

switch current {
case .loading(let progress):
    print("진행률: \(progress)%")
case .success(let message):
    print("성공: \(message)")
case .failure(let error):
    print("실패: \(error)")
}
```

## 여러 Enum 케이스를 묶어서 처리하기
코드가 짧아지고 비슷한 케이스를 한 번에 처리할 수 있다.
```swift
enum Weekday {
    case mon, tue, wed, thu, fri, sat, sun
}

let day: Weekday = .sat

switch day {
case .mon, .tue, .wed, .thu, .fri:
    print("평일")
case .sat, .sun:
    print("주말")
}
```

## Enum의 확장성과 Switch문의 결합
```swift
enum Device {
    case iPhone, iPad

    var year: Int {
        switch self {
        case .iPhone: return 2007
        case .iPad: return 2010
        }
    }
}

let myDevice = Device.iPad
print(myDevice.year) // 2010
Enum 내부에서 `switch self`를 사용해 각 case별로 다른 값을 반환한다.
```