
### SwiftData를 공부하다가 사용하는 과정 중 그동안 그냥 넘어갔었던 친구 final에 대해서 조사하게 되었습니다. 

>[! SwiftData란?]
>SwiftData는 Apple이 만든 최신 데이터 영속성 프레임워크입니다. CoreData의 복잡함을 제거하고 SwiftUI와 완벽하게 통합된 간단한 API를 제공합니다.

### [[영속성 | 영속성이 무슨 뜻 ? ]]

### 첫번째 ! 모델 생성

```swift title="모델 정의"
import SwiftData

@Model
final class User {
    var name: String
    var age: Int
    var createdAt: Date
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        self.createdAt = Date()
    }
}
```

**핵심:**
- `@Model` 매크로 추가
- `final class`로 선언
- 기본 Swift 타입 사용 가능

> `final` 익숙하게 보던 친구인데 이번 기회에? 하는 생각으로 좀 알아보았습니다 ! 
[[final 키워드]]
