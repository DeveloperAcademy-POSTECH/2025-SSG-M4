
## 1. WidgetKit: 홈 화면의 작은 창

**WidgetKit은 iOS 14**부터 등장
앱의 핵심 정보를 사용자의 홈 화면, 잠금 화면 등에 위젯 형태로 빠르고 간편하게 보여주는 역할
위젯은 앱 자체처럼 실시간으로 구동되는 것이 아니라, **특정 시점의 스냅샷**을 보여주는 방식으로 작동, 
제한된 수준의 상호작용을 허용. -> 프레임이 높지 않아서 자연스러운 연결은 안됨
SwiftUI를 기반으로 UI를 구성합니다.

### 주요 구성 요소

| 구성 요소                 | 역할 설명                                                                                                                                       |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `TimelineEntry`       | 위젯에 '언제' '어떤' 데이터를 보여줄지 정의하는 모델입니다.  최소한 `date` 정보를 포함해야 하며, 위젯에 표시하고 싶은 모든 데이터를 담을 수 있습니다.                                                 |
| `TimelineProvider`    | 위젯의 콘텐츠가 언제 업데이트될지, 그리고 어떤 데이터를 보여줄지를 시스템에 알려주는 핵심 구성 요소입니다. `placeholder()`, `getSnapshot()`, `getTimeline()` 세 가지 필수 메서드를 통해 이 역할을 수행합니다. |
| `WidgetView`          | 실제 위젯의 화면을 SwiftUI 코드로 그리는 부분입니다. `TimelineProvider`에서 제공된 `TimelineEntry` 데이터를 받아서 시각적으로 사용자에게 보여줍니다.                                      |
| `WidgetConfiguration` | 위젯의 종류(정보만 보여주는지, 사용자 설정이 필요한지)와 기본적인 설정을 정의합니다. `StaticConfiguration`과 `IntentConfiguration` 두 가지가 있습니다.                                   |

### 작동 원리

위젯이 화면에 나타나고 정보가 갱신되는 과정은 '타임라인'이라는 개념을 중심으로 돌아갑니다.

1. **데이터 타임라인 준비**: `TimelineProvider`가 특정 시간 간격으로 위젯에 표시될 `TimelineEntry`들의 배열, 즉 '타임라인'을 생성합니다. 이 타임라인은 미래의 특정 시점들에 위젯이 어떤 데이터를 보여줄지를 미리 정해둡니다.
    
2. **시스템으로 타임라인 전달**: `WidgetKit` 시스템은 `TimelineProvider`로부터 이 타임라인을 건네받아, 언제 어떤 데이터를 보여줄지를 자체적으로 관리하고 결정합니다.
    
3. **자동 갱신**: 타임라인에 설정된 '갱신 정책(refresh policy)'에 따라 위젯은 주기적으로 자동 업데이트됩니다.
    
4. **UI 렌더링**: 각 `TimelineEntry`의 시점이 되면, 해당 Entry에 포함된 데이터를 가지고 `WidgetView`의 `body`가 호출되어 위젯의 UI가 갱신되어 사용자에게 표시됩니다.
    
5. **성능 최적화**: 위젯은 시스템 자원을 효율적으로 사용하도록 설계되어 있습니다. 백그라운드에서 실행되는 시간이 엄격하게 제한되며, 필요할 때만 최소한의 업데이트를 수행합니다.
    
6. **App Group을 통한 데이터 공유**: 위젯과 앱은 서로 다른 독립적인 프로세스에서 실행됩니다. 따라서 데이터 공유가 필요할 때는 `App Group` 설정을 통해 `UserDefaults` 같은 공유 저장 공간을 활용해야 합니다.
    
## 2. App Intents: 앱의 행동을 시스템으로

App Intents는 iOS 16부터 도입된 프레임워크로, 앱이 제공하는 특정 기능, 즉 '액션'을 iOS 시스템 전반에 노출시키는 표준화된 방법입니다. 이를 통해 사용자는 앱을 직접 실행하지 않고도 Siri, 단축어(Shortcuts), Spotlight 검색, 그리고 위젯 등 다양한 시스템 환경에서 앱의 기능을 직접 호출하고 활용할 수 있습니다.

### 주요 구성 요소

App Intents를 정의할 때 사용되는 핵심 요소들입니다.

|구성 요소|역할 설명|
|---|---|
|`AppIntent`|앱의 특정 행동(예: '할 일 추가하기', '노래 재생하기')을 정의하는 구조체 또는 클래스입니다. `title`(이름)과 실제로 동작하는 `perform()` 비동기 메서드를 반드시 포함해야 합니다.|
|`AppEnum`|특정 인텐트의 파라미터로 사용될 수 있는 제한된 값의 집합(예: '높음', '중간', '낮음'과 같은 우선순위)을 정의할 때 사용합니다.|
|`AppEntity`|앱 내의 동적인 데이터(예: 특정 사용자, 장소, 음악 앨범)를 시스템에 노출하고 관리할 때 사용합니다. `EntityQuery`를 함께 정의하여 특정 엔티티를 검색하거나 선택할 수 있게 합니다.|
|`Parameter`|인텐트가 실행될 때 외부로부터 받을 입력 값을 정의합니다. `@Parameter` 프로퍼티 래퍼를 사용하여 선언하며, String, Int와 같은 기본 타입뿐만 아니라 `AppEnum`, `AppEntity`와 같은 사용자 정의 타입도 가능합니다.|
|`IntentResult`|`perform()` 메서드의 실행 결과를 반환할 때 사용합니다. Siri와의 대화 흐름을 제어하거나, 앱 내의 특정 화면으로 이동하거나, 데이터를 변경하는 등 다양한 종류의 결과를 정의할 수 있습니다.|

### 작동 원리

App Intents가 시스템에 통합되어 작동하는 과정은 다음과 같습니다.

1. **Intent 정의**: 개발자는 `AppIntent` 프로토콜을 채택한 구조체/클래스를 정의하여 앱의 특정 액션과 그에 필요한 파라미터, 실행 로직(`perform()` 메서드) 등을 명확하게 작성합니다.
    
2. **시스템 등록**: 앱이 빌드될 때, 정의된 `AppIntent`에 대한 정보가 시스템에 자동으로 등록됩니다. 이를 통해 iOS는 해당 앱이 어떤 기능을 제공하는지 인식하게 됩니다.
    
3. **실행**: 사용자가 Siri에게 음성으로 명령하거나, Spotlight에서 검색하거나, 단축어를 실행하거나, 위젯 내의 버튼을 탭하는 등 `AppIntent`가 연결된 곳에서 액션을 호출하면, 시스템은 앱을 직접 실행하지 않고 해당 `perform()` 메서드를 실행합니다.
    
4. **결과 반환**: `perform()` 메서드는 작업을 완료한 후 `IntentResult`를 반환합니다. 이 결과는 Siri의 응답으로 이어지거나, 앱 내의 특정 화면으로 사용자 인터페이스(UI)를 전환하거나, 단순히 백그라운드에서 데이터를 변경하는 등의 다양한 방식으로 처리될 수 있습니다.
    
 

## 3. WidgetKit과 App Intents의 상호작용 원리

### 상호작용 흐름
우리가 만든 DotEdge 게임 위젯을 예로 들면, 다음과 같은 순서로 상호작용이 일어납니다.

1. **사용자 상호작용 발생**: 사용자가 홈 화면에 있는 위젯(`DotWidgetEntryView`) 내의 점 부분을 탭하거나, 'Reset' 버튼을 탭합니다.
    
2. **`AppIntent` 실행 트리거**: 위젯 UI의 버튼은 특정 `AppIntent`(예: 점을 탭했을 때 `TapDotIntent`, 리셋 버튼을 눌렀을 때 `ResetGameIntent`)와 연결되어 있습니다. 사용자의 탭 이벤트가 발생하면, 연결된 `AppIntent`가 시스템에 의해 실행됩니다.
    
3. **위젯 상태 업데이트**: 실행된 `AppIntent`의 `perform()` 메서드 내부 로직이 동작합니다. 이 로직은 `App Group`을 통해 공유되는 `UserDefaults`에서 현재 위젯의 게임 상태(`DotState`)를 불러오고, 점의 방향 변경, 클릭 수 증가, 게임 오버 여부 판정 등 게임 규칙에 따라 상태 데이터를 업데이트한 후, 다시 `UserDefaults`에 저장합니다.
    
4. **위젯 업데이트 요청**: `AppIntent`의 `perform()` 메서드 마지막에는 `WidgetCenter.shared.reloadTimelines(ofKind: "WidgetKind")` 또는 `reloadAllTimelines()`와 같은 호출이 포함됩니다. 이는 WidgetKit 시스템에 "현재 위젯의 데이터가 업데이트되었으니, 새로운 타임라인을 생성하여 위젯 UI를 갱신해달라"는 요청을 보냅니다.
    
5. **`TimelineProvider` 재실행**: WidgetKit 시스템은 이 업데이트 요청을 받아, 해당 위젯에 연결된 `TimelineProvider`(`DotTimelineProvider`)의 `getTimeline()` 메서드를 다시 호출합니다.
    
6. **새로운 타임라인 제공**: `getTimeline()` 메서드는 `UserDefaults`에 저장된 최신 게임 상태 데이터를 다시 로드하고, 이를 바탕으로 새로운 `TimelineEntry`를 생성합니다. 이 `TimelineEntry`를 포함하는 `Timeline`을 WidgetKit 시스템에 제공합니다.
    
7. **UI 갱신**: WidgetKit은 새로 받은 `TimelineEntry`의 데이터를 가지고 `DotWidgetEntryView`를 다시 렌더링합니다. 이로써 사용자에게 업데이트된 점의 위치, 클릭 횟수, 게임 오버 상태(점의 색깔 변화) 등이 위젯 UI에 반영되어 보입니다.
    

## 4. 핵심 작동 원리 요약
- **분리된 프로세스**: 위젯은 앱과 독립적인 프로세스에서 실행되기 때문에, 각자가 서로에게 영향을 주지 않으면서 안정적으로 작동합니다.
    
- **데이터 공유 필수**: 독립적인 프로세스 간에 데이터를 주고받으려면 `App Group`과 같은 공유 컨테이너를 통해 `UserDefaults` 등을 사용해야 합니다.
    
- **상태 주도 UI**: 위젯의 UI는 `TimelineEntry`에 담긴 데이터('상태')에 전적으로 의존하여 그려집니다. 데이터가 변하면 UI도 변합니다.
    
- **인텐트 기반 상호작용**: 위젯 내에서 사용자가 특정 행동을 하면, 이를 처리하기 위해 `App Intent`가 호출됩니다. 이 인텐트가 위젯의 '상태'를 변경하고, 그 변경된 상태를 바탕으로 WidgetKit에게 UI 업데이트를 '요청'합니다.
    
- **시스템 제어 업데이트**: 위젯의 실제 UI 업데이트 주기는 개발자가 직접 제어하기보다는 WidgetKit 시스템이 관리합니다. `reloadTimelines()` 같은 호출은 시스템에 업데이트를 요청하는 신호일 뿐, 즉각적인 업데이트를 보장하지는 않습니다 (물론 빠르게 반영되도록 노력합니다).
    

# WidgetKit + AppIntent 클릭 스피드 게임

## 📱 게임 개요

100번의 클릭을 얼마나 빨리 할 수 있는지 측정하는 스피드 게임으로, 홈 화면 위젯에서 직접 플레이할 수 있습니다.
### 1. 데이터 모델 (`SharedGameModel.swift`)

```swift
// 게임 데이터 구조체
struct WidgetGameData: Codable {
    var clickCount: Int = 0
    var targetClicks: Int = 100
    var startTime: Date?
    var endTime: Date?
    var isGameActive: Bool = false
    var gameCompleted: Bool = false
}

// 앱과 위젯 간 데이터 공유
class SharedGameModel: ObservableObject {
    static let shared = SharedGameModel()
    private let userDefaults = UserDefaults(suiteName: "group.com.bear.dotwidget")
}
```

**핵심 기능:**
- App Groups를 통한 앱-위젯 간 데이터 공유
- 게임 진행률, CPS(초당 클릭 수), 경과 시간 자동 계산
- WidgetCenter를 통한 위젯 자동 업데이트

### 2. AppIntent 구현 (`DotWidgetIntents.swift`)

```swift
// 게임 시작
struct StartClickGameIntent: AppIntent {
    func perform() async throws -> some IntentResult {
        SharedGameModel.shared.startGame()
        return .result()
    }
}

// 클릭 액션
struct ClickButtonIntent: AppIntent {
    func perform() async throws -> some IntentResult {
        SharedGameModel.shared.addClick()
        return .result()
    }
}

// 게임 리셋
struct ResetClickGameIntent: AppIntent {
    func perform() async throws -> some IntentResult {
        SharedGameModel.shared.resetGame()
        return .result()
    }
}
```

**핵심 기능:**
- 위젯에서 직접 실행 가능한 인터랙티브 액션
- async/await를 활용한 비동기 처리
- 앱 실행 없이 위젯에서 독립적 동작

### 3. 위젯 구현 (`DotWidgetExtension.swift`)

```swift
// Timeline Provider
struct Provider: TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // 게임 상태에 따른 동적 업데이트 주기 조정
        let refreshInterval: TimeInterval = sharedModel.gameData.isGameActive ? 0.1 : 1.0
    }
}

// 위젯 뷰
struct DotWidgetExtensionEntryView: View {
    var body: some View {
        VStack {
            // 동적 UI 상태 관리
            if gameData.gameCompleted {
                // 완료 화면
            } else if gameData.isGameActive {
                // 게임 진행 화면
            } else {
                // 시작 화면
            }
        }
    }
}
```

**핵심 기능:**
- TimelineProvider를 통한 실시간 게임 상태 반영
- 게임 상태별 동적 UI 렌더링
- 진행률 바, 통계 정보 실시간 표시
### 1. App Groups 설정
```swift
private let userDefaults = UserDefaults(suiteName: "group.com.bear.dotwidget")
```
- 앱과 위젯 익스텐션 간 데이터 공유를 위한 설정
- Xcode에서 Capabilities → App Groups 추가 필요

### 2. WidgetCenter 자동 업데이트
```swift
@Published var gameData = WidgetGameData() {
    didSet {
        saveGameData()
        WidgetCenter.shared.reloadAllTimelines()
    }
}
```
- 데이터 변경 시 위젯 자동 새로고침
- 실시간 게임 상태 반영

### 3. 동적 Timeline 관리
```swift
let refreshInterval: TimeInterval = sharedModel.gameData.isGameActive ? 0.1 : 1.0
```
- 게임 활성 상태에 따른 업데이트 주기 조정
- 성능과 배터리 효율성 균형

### 4. AppIntent 버튼 연동
```swift
Button(intent: ClickButtonIntent()) {
    // 버튼 UI
}
```
- 위젯에서 직접 실행 가능한 인터랙티브 요소
- 앱 실행 없이 독립적 기능 수행

---
## 실제 코드 예제 (위젯 게임)

```swift
//
//  SharedGameModel.swift
//  DotWidget
//
import Foundation
import WidgetKit

// 위젯 게임 데이터 구조체 (클릭 스피드 게임용)
struct WidgetGameData: Codable {
    var clickCount: Int = 0
    var targetClicks: Int = 100
    var startTime: Date?
    var endTime: Date?
    var isGameActive: Bool = false
    var gameCompleted: Bool = false
    
    // 게임 진행률 계산
    var progress: Double {
        return min(Double(clickCount) / Double(targetClicks), 1.0)
    }
    
    // 게임 소요 시간 계산
    var elapsedTime: TimeInterval? {
        guard let start = startTime else { return nil }
        let end = endTime ?? Date()
        return end.timeIntervalSince(start)
    }
    
    // CPS (초당 클릭 수) 계산
    var clicksPerSecond: Double {
        guard let elapsed = elapsedTime, elapsed > 0 else { return 0 }
        return Double(clickCount) / elapsed
    }
    
    // 게임 상태 텍스트
    var statusText: String {
        if gameCompleted {
            if let elapsed = elapsedTime {
                return String(format: "완료! %.2f초", elapsed)
            }
            return "게임 완료!"
        } else if isGameActive {
            return "\(clickCount)/\(targetClicks) 클릭"
        } else {
            return "시작하려면 탭하세요"
        }
    }
}

// 앱 그룹을 통한 데이터 공유 관리자
class SharedGameModel: ObservableObject {
    static let shared = SharedGameModel()
    
    // "group.com.bear.dotwidget"은 사용자 앱 그룹 ID에 맞춰 변경해야 합니다.
    private let userDefaults = UserDefaults(suiteName: "group.com.bear.dotwidget") ?? UserDefaults.standard
    private let gameDataKey = "WidgetGameData"
    
    // @Published를 통해 gameData가 변경될 때마다 뷰를 업데이트하고 위젯을 새로고침합니다.
    @Published var gameData = WidgetGameData() {
        didSet {
            saveGameData() // 데이터 변경 시 UserDefaults에 저장
            WidgetCenter.shared.reloadAllTimelines() // 모든 위젯 타임라인 새로고침
        }
    }
    
    // 싱글톤 패턴: 외부에서 직접 인스턴스 생성을 막고, loadGameData()를 호출하여 초기화합니다.
    private init() {
        loadGameData()
    }
    
    // 현재 게임 데이터를 UserDefaults에 저장합니다.
    private func saveGameData() {
        if let encoded = try? JSONEncoder().encode(gameData) {
            userDefaults.set(encoded, forKey: gameDataKey)
        }
    }
    
    // UserDefaults에서 게임 데이터를 로드합니다.
    private func loadGameData() {
        if let data = userDefaults.data(forKey: gameDataKey),
            let decoded = try? JSONDecoder().decode(WidgetGameData.self, from: data) {
            gameData = decoded
        }
    }
    
    // 게임을 시작 상태로 설정하고 초기화합니다.
    func startGame() {
        gameData = WidgetGameData(
            clickCount: 0,
            targetClicks: 100, // 목표 클릭 수 설정
            startTime: Date(),
            endTime: nil,
            isGameActive: true,
            gameCompleted: false
        )
    }
    
    // 클릭 수를 증가시키고 게임 완료 여부를 확인합니다.
    func addClick() {
        guard gameData.isGameActive && !gameData.gameCompleted else { return } // 게임이 활성 상태일 때만 클릭 처리
            
        gameData.clickCount += 1
            
        // 목표 클릭 수에 도달하면 게임 완료 처리
        if gameData.clickCount >= gameData.targetClicks {
            gameData.endTime = Date() // 종료 시간 기록
            gameData.isGameActive = false // 게임 비활성화
            gameData.gameCompleted = true // 게임 완료 상태
        }
    }
    
    // 게임 데이터를 초기 상태로 리셋합니다.
    func resetGame() {
        gameData = WidgetGameData() // WidgetGameData의 기본값으로 초기화
    }
}

```

```swift
//  DotWidgetExtension.swift
//  DotWidgetExtension

import WidgetKit
import SwiftUI

// 위젯의 TimelineEntry
// 위젯에 표시될 데이터를 담는 구조체입니다.
struct SimpleEntry: TimelineEntry {
    let date: Date // 타임라인 엔트리의 시간
    let gameData: WidgetGameData // 게임 상태 데이터
}

// 위젯의 TimelineProvider
// 위젯에 데이터를 언제, 어떻게 제공할지 결정합니다.
struct Provider: TimelineProvider {
    // 위젯이 처음 추가될 때나 미리보기 등에 사용되는 플레이스홀더 엔트리입니다.
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), gameData: WidgetGameData())
    }

    // 위젯 갤러리 등에 빠르게 표시될 스냅샷 엔트리입니다.
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let sharedModel = SharedGameModel.shared // 공유 모델 인스턴스 접근
        let entry = SimpleEntry(date: Date(), gameData: sharedModel.gameData) // 현재 게임 데이터로 엔트리 생성
        completion(entry)
    }

    // 위젯이 주기적으로 업데이트될 타임라인을 제공합니다.
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let sharedModel = SharedGameModel.shared // 공유 모델 인스턴스 접근
        let currentDate = Date() // 현재 시간
        let entry = SimpleEntry(date: currentDate, gameData: sharedModel.gameData) // 현재 게임 데이터로 엔트리 생성
        
        // 게임이 활성화되어 있으면 (진행 중이면) 더 자주 업데이트 (0.1초마다)
        // 비활성 상태면 (시작 전 또는 완료 후) 덜 자주 업데이트 (1초마다)
        let refreshInterval: TimeInterval = sharedModel.gameData.isGameActive ? 0.1 : 1.0
        // 다음 업데이트될 시간을 계산합니다.
        let nextUpdateDate = Calendar.current.date(byAdding: .second, value: Int(refreshInterval), to: currentDate)!
        
        // 타임라인을 생성하고 완료 핸들러를 호출합니다. .after 정책은 nextUpdateDate 이후에 새로운 타임라인을 요청합니다.
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))


# DotWidgetExtensionBundle.swift

```

```swift
//  DotWidgetExtensionBundle.swift
//  DotWidgetExtension

import WidgetKit
import SwiftUI

// @main 어트리뷰트는 이 구조체가 앱 또는 위젯 익스텐션의 주요 진입점임을 나타냅니다.
// WidgetBundle 프로토콜은 하나 이상의 위젯을 포함할 수 있는 컨테이너 역할을 합니다.
@main
struct DotWidgetExtensionBundle: WidgetBundle {
    // body 프로퍼티는 이 번들이 제공하는 위젯들을 정의합니다.
    // 여기서는 단일 위젯인 DotWidgetExtension()을 포함하고 있습니다.
    var body: some Widget {
        DotWidgetExtension() // 이 번들에 포함될 위젯 인스턴스
    }
}

```

```swift
//  DotWidgetIntents.swift
//  DotWidgetExtension

import AppIntents
import Foundation

// 클릭 게임 시작 Intent
// 위젯에서 '게임 시작' 버튼을 탭했을 때 실행되는 인텐트입니다.
struct StartClickGameIntent: AppIntent {
    // 위젯 갤러리나 단축어 등에서 보여질 인텐트의 이름입니다.
    static var title: LocalizedStringResource = "클릭 게임 시작"
    // 인텐트의 기능에 대한 설명입니다.
    static var description = IntentDescription("100번 클릭 스피드 게임을 시작합니다.")
    
    // 인텐트가 실행될 때 수행되는 비동기 작업입니다.
    func perform() async throws -> some IntentResult {
        let sharedModel = SharedGameModel.shared // SharedGameModel의 공유 인스턴스를 가져옵니다.
        await MainActor.run { // UI 관련 작업은 메인 액터에서 실행되도록 보장합니다.
            sharedModel.startGame() // 게임 시작 로직을 호출합니다. (SharedGameModel 내에서 UserDefaults 저장 및 위젯 새로고침 트리거)
        }
        return .result() // 인텐트 실행 결과를 반환합니다. (성공)
    }
}

// 클릭 버튼 Intent
// 위젯에서 게임 진행 중 '클릭!' 버튼을 탭했을 때 실행되는 인텐트입니다.
struct ClickButtonIntent: AppIntent {
    // 인텐트의 이름입니다.
    static var title: LocalizedStringResource = "클릭"
    // 인텐트의 기능에 대한 설명입니다.
    static var description = IntentDescription("클릭 카운트를 증가시킵니다.")
    
    // 인텐트가 실행될 때 수행되는 비동기 작업입니다.
    func perform() async throws -> some IntentResult {
        let sharedModel = SharedGameModel.shared // SharedGameModel의 공유 인스턴스를 가져옵니다.
        await MainActor.run { // UI 관련 작업은 메인 액터에서 실행되도록 보장합니다.
            sharedModel.addClick() // 클릭 횟수 증가 로직을 호출합니다. (SharedGameModel 내에서 UserDefaults 저장 및 위젯 새로고침 트리거)
        }
        return .result() // 인텐트 실행 결과를 반환합니다. (성공)
    }
}

// 게임 리셋 Intent
// 위젯에서 '리셋' 버튼을 탭했을 때 실행되는 인텐트입니다.
struct ResetClickGameIntent: AppIntent {
    // 인텐트의 이름입니다.
    static var title: LocalizedStringResource = "게임 리셋"
    // 인텐트의 기능에 대한 설명입니다.
    static var description = IntentDescription("클릭 게임을 초기화합니다.")
    
    // 인텐트가 실행될 때 수행되는 비동기 작업입니다.
    func perform() async throws -> some IntentResult {
        let sharedModel = SharedGameModel.shared // SharedGameModel의 공유 인스턴스를 가져옵니다.
        await MainActor.run { // UI 관련 작업은 메인 액터에서 실행되도록 보장합니다.
            sharedModel.resetGame() // 게임 리셋 로직을 호출합니다. (SharedGameModel 내에서 UserDefaults 저장 및 위젯 새로고침 트리거)
        }
        return .result() // 인텐트 실행 결과를 반환합니다. (성공)
    }
}
