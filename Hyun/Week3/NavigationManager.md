# NavigationManager란?
---
>사용자 정의 네비게이션 흐름을 관리하기 위한 객체
- `NavigationStack`이나 `NavigationLink보`다 복잡한 로직이 필요한 경우 사용
- `ObservableObject`로 상태 관리
	- [[ObservableObject]]

### 사용 방식
---
1. `ObservableObject` 상속
2. `@Published` 속성을 이용해 네비게이션 경로(`path`)나 화면 상태(`currentView`)를 바인딩 방식으로 관리
	- [[@Published]]
3. `push`, `pop`, `append`, `removeAll` 등 함수로 `View` 전환

| 메서드 이름                    | 설명                                                                 | 예시 사용 코드                                               | 실제 동작                                                                 |
|-------------------------------|----------------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------------------------|
| `push(_ route)`               | 새 화면(경로)을 스택에 추가 → **앞으로 이동**                          | `navigationManager.push(.detail("Hello"))`                   | 현재 화면에서 `DetailView("Hello")`로 전환됨                               |
| `pop()`                       | 스택의 마지막 화면을 제거 → **뒤로 이동**                              | `navigationManager.pop()`                                    | 이전 화면으로 돌아감 (예: Detail → Home)                                   |
| `popToRoot()`                 | 스택을 전부 비움 → **루트(HomeView 등)로 이동**                         | `navigationManager.popToRoot()`                               | 앱의 첫 화면으로 복귀                                                      |
| `replace(with:)` *(선택 구현)*| 현재 스택을 대체 → **화면 변경 + 히스토리 초기화**                      | `navigationManager.replace(with: [.home, .detail("New")])`   | 스택을 초기화하고 처음부터 `.home → .detail("New")`로 설정됨               |
| `replaceLast(with:)`          | 스택의 마지막 항목을 바꿈 → **현재 화면을 새로운 화면으로 교체**         | `navigationManager.replaceLast(with: .settings)`             | 현재 화면을 pop하고 `.settings` 화면으로 대체됨                            |
| `popTo(_ route)`              | 특정 경로까지 스택을 pop → **해당 화면으로 이동하고 그 뒤는 제거됨**     | `navigationManager.popTo(.home)`                             | `.home`까지 스택을 되돌림 (`.home`이 없으면 아무 작업 안 함)              |
| `contains(_ route)`           | 특정 화면이 현재 스택에 있는지 확인                                      | `if navigationManager.contains(.detail("Hello")) { ... }`    | 해당 화면이 스택에 포함되어 있는 경우 true 반환                             |
| `reset()`                     | 모든 상태 초기화 (스택 + 내부 상태 리셋) → 앱 처음 상태처럼 만듦          | `navigationManager.reset()`                                  | 전체 스택 초기화 및 상태 초기화 (예: 로그아웃 시 활용)                     |

### 사용 예시
---
- `NavigationManager` 클래스
```
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path: [Route] = []

    enum Route: Hashable { // C3 팀에서는 따로 Enum으로 분리함
        case home
        case detail(itemID: Int) // 해당 뷰에 넘겨줘야 할 데이터가 있는 경우
        case settings
    }

    func push(_ route: Route) { // 따로 선언 안하고 뷰에서 할 수도 있음
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}
```

- `View`
```
struct ContentView: View {
    @StateObject private var navigationManager = NavigationManager()

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Button("Go to Detail") {
                    navigationManager.push(.detail(itemID: 42))
                }
            }
            .navigationDestination(for: NavigationManager.Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .detail(let id):
                    DetailView(itemID: id)
                case .settings:
                    SettingsView()
                }
            }
        }
        .environmentObject(navigationManager)
    }
}
```
- [[@StateObject]]
- **NavigationStack**이 필요한 이유
	- `NavigationStack`은 SwiftUI에서 네비게이션 흐름(즉, 화면 전환)을 관리하는 컨테이너
	- `path`를 바인딩으로 연결하면, `push` 등으로 코드를 통해 화면 전환을 직접 조작 가능
	- `navigationDestination(for:)`을 통해 `enum`, `model`, `id` 등 다양한 화면 조건 분기 가능
	- 뒤로가기 시 어떤 화면으로 돌아가야 하는지 자동 관리


```
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack(spacing: 20) {
            Text("🏠 Home View")
                .font(.largeTitle)

            Button("Go to Detail 1") {
                navigationManager.push(.detail(itemID: 1)) // -> DetailView()
            }

            Button("Go to Settings") {
                navigationManager.push(.settings) // -> SettingsView()
            }
        }
        .padding()
    }
}
```