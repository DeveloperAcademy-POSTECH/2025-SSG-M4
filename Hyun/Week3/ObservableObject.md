>데이터 상태를 여러 뷰에서 공유하고 변경 사항을 자동으로 UI에 반영하게 해주는 핵심 프로토콜
- `@Published` 속성의 변경을 감지하고 SwiftUI 뷰에 알려주는 역할
	- [[@Published]]
- 앱의 공유 데이터 상태를 관리하는 컨트롤타워 같은 존재

### 작동 흐름
1. `ClassName: ObservableObject`로 데이터 변경 감지 가능한 모델 클래스 생성
```
import SwiftUI

class CounterModel: ObservableObject {
    @Published var count = 0

    func increase() {
        count += 1
    }
}
```
1. 속성에 `@Published` 붙여 상태 변경 감지 대상 지정
2. 뷰에서 `@ObservedObject` 또는 `@EnvironmentObject`로 참조
```
struct CounterView: View {
    @ObservedObject var counter = CounterModel()

    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            Button("증가") {
                counter.increase()
            }
        }
    }
}
```
1. 값이 바뀌면 자동으로 뷰가 다시 그려짐