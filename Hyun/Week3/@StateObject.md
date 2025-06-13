>클래스 기반의 상태 객체를 뷰 내부에서 직접 소유하고 초기화할 때 사용하는 속성
- `ObservableObject`와 연결되는 핵심 속성 중 하나
- SwiftUI 뷰 안에서 `ObservableObject`를 직접 생성하고, 그 생명주기를 관리

### 사용 예시
------
```
class Counter: ObservableObject {
    @Published var count = 0
}

struct CounterView: View {
    @StateObject private var counter = Counter()

    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            Button("증가") {
                counter.count += 1
            }
        }
    }
}
```

### 사용 상황
---
- 뷰에서 `ObservableObject`를 처음 생성할 때
	- 뷰가 해당 객체의 소유자 역할
- 해당 뷰의 생명주기와 함께 상태가 초기화되면서 사라져야 할 때
	- 뷰가 사라질 때 함께 메모리에서 해제
- 객체 초기화가 한 번만 되어야 할 때
	- SwiftUI가 body를 여러 번 그려도 재생성되지 않음
		- SwiftUI는 body가 자주 다시 그려지기 때문에 그대로 재생성될 경우 상태 유지 불가
```
// ✅ 뷰 내부에서 직접 객체를 생성해서 관리하고 싶을 때
@StateObject var model = MyModel()

// ✅ 부모 뷰에서 이미 만들어진 객체를 넘겨줄 때
@ObservedObject var model: MyModel
```

### 주의
---
- 한 번만 초기화돼야 하므로, body 안에서 쓰면 안 됨
```
// ❌ 잘못된 사용
var body: some View {
    let model = MyModel() // 매번 새로 만들어짐
    ...
}
```
- 반드시 `ObservableObject`와 함께 사용