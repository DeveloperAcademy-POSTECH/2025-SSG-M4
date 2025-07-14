## Enum이란?
연관된 값들을 하나의 그룹으로 묶어서, 새로운 자료형(타입)으로 만드는 기능

**장점**: 
1. 계절을 문자열로 관리한다면 오타가 발생할수 있지만 enum을 사용하면 오타나 잘못된 값 입력을 막을 수 있다. 
2. 각 `case`에 [[연관값과 원시값|연관값]], 메서드, 프로퍼티도 추가할 수 있다.

	```swift
'연관값': 각 case에 추가 정보 저장.
enum Season1 {
    case spring(averageTemp: Int)
    case summer(averageTemp: Int)
    case autumn(averageTemp: Int)
    case winter(averageTemp: Int)
}
let now = Season.summer(averageTemp: 30)
```

	```swift
'메서드': 각 case에 따라 동작 추가.
enum Season2 {
    case spring
    case summer
    case autumn
    case winter

    func description() -> String {
        switch self {
        case .spring:
            return "봄"
        case .summer:
            return "여름"
        case .autumn:
            return "가을"
        case .winter:
            return "겨울"
        }
    }
}
let now = Season.autumn
print(now.description()) // "가을"
```

	```swift
'프로퍼티': 각 case별 값 반환.
enum Season3 {
    case spring
    case summer
    case autumn
    case winter

    var emoji: String {
        switch self {
        case .spring: return "🌸"
        case .summer: return "☀️"
        case .autumn: return "🍁"
        case .winter: return "❄️"
        }
    }
}
```
## Enum의 특징
- 타입 안정성
- 가독성 향상
- 확장성 (연관값, 메서드, 프로퍼티등)
## 열거형 선언 방법
'enum' 키워드를 사용해 선언
```swift
enum Season {
    case spring
    case summer
    case autumn
    case winter
}
```
## Enum 변수 선언 및 값 할당
enum타입인 변수나 상수를 선언하고 값(case)을 할당할 수 있다.
enum 타입이 명확하다면 이름을 생략하고 `.`만으로도 케이스를 지정할 수 있다.
```swift
enum Season {...}
var currentSeason: Season = .summer
'Season'을 선언함으로 명확한 enum 타임
```
