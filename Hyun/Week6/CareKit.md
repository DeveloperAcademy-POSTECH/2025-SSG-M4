> 사용자가 자신의 **건강 상태를 추적하고 관리**할 수 있도록 돕는 iOS 프레임워크,
> CareKitUI와 CareKitStore를 하나로 묶을 수 있는 뷰 컨트롤러를 제공하는 포괄적인 패키지
- CareKitUI와 CareKitStore를 연결하는 뷰 컨트롤러를 제공
- **CareKitUI:** 프레임워크 전체에서 사용되는 보기를 제공
	- 뷰는 UIView의 개방적이고 확장 가능한 하위 클래스
	- 뷰 내의 속성은 공개되어 있어 콘텐츠를 완전히 제어 가능
- **CareKitStore:** 환자 데이터를 저장하기 위한 Core Data 솔루션을 제공
	- 타사 데이터베이스 또는 API와 같은 사용자 지정 저장소를 사용할 수 있는 기능을 제공

- 환자가 매일 해야 하는 일들(약 복용, 운동 등)을 체크
- 증상이나 기분을 기록
- 의료진이나 보호자와 그 데이터를 공유할 수 있게 하는 도구를 제공
---
## 코드 관련
### 목록 보기 컨트롤러
> 저장소의 데이터를 쿼리하고 표시하며 데이터와 동기화 상태를 유지
- `OCKDailyTasksPageViewController`: 날짜에 대한 페이지별 캘린더와 함께 각 날짜의 작업을 표시
- `OCKContactsListViewController`: 매장의 연락처 목록을 표시
### 동기화된 뷰 컨트롤러
> 표준 뷰 컨트롤러 컨테이너를 사용하여 어디에나 배치할 수 있는 자체 모듈
- 각 카드의 뷰 컨트롤러는 뷰와 스토어 간의 동기화를 제공
```swift
// Create a store to hold your data.
let store = OCKStore(named: "my-store", type: .onDisk)

// Create a view controller that queries for and displays data. The view will update automatically whenever the data in the store changes.
let viewController = OCKSimpleTaskViewController(taskID: "doxylamine", eventQuery: OCKEventQuery(for: Date()), store: store)
```
- 모든 동기화된 뷰 컨트롤러에는 뷰 동기화기 존재
	- 뷰 동기화기는 표시할 뷰를 인스턴스화하는 방법과 스토어의 데이터가 변경될 때 뷰를 업데이트하는 방법을 정의
	- 뷰 동기화를 사용자 지정하고 뷰 컨트롤러에 삽입하여 사용자 지정 동작을 수행
```swift
// Define a custom view synchronizer.
class CustomSimpleTaskViewSynchronizer: OCKSimpleTaskViewSynchronizer {

    override func makeView() -> OCKSimpleTaskView {
        let view = super.makeView()
        // Customize the view when it's instantiated here.
        return view
    }

    override func updateView(_ view: OCKSimpleTaskView, context: OCKSynchronizationContext<OCKTaskEvents>) {
        super.updateView(view, context: context)
        // Update the view when the data changes in the store here.
    }
}

// Instantiate the view controller with the custom classes, then fetch and observe data in the store.
var query = OCKEventQuery(for: Date())
query.taskIDs = ["Doxylamine"]

let viewController = OCKSimpleTaskViewController(query: query, store: store, viewSynchronizer: CustomSimpleTaskViewSynchronizer())
```
### 사용자 지정 동기화 뷰 컨트롤러
> 동기화된 뷰 컨트롤러와 페어링할 수 있는 사용자 지정 뷰 생성을 지원
- 사용자 지정 보기와 스토어의 데이터 간의 동기화가 가능
```swift
// Define a view synchronizer for the custom view.
class TaskButtonViewSynchronizer: ViewSynchronizing {

    // Instantiate the custom view.
    func makeView() -> UIButton {
        return UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    }

    // Update the custom view when the data in the store changes.
    func updateView(
        _ view: UIButton,
        context: OCKSynchronizationContext<OCKAnyEvent?>
    ) {
        let event = context.viewModel
        view.titleLabel?.text = event?.task.title
        view.isSelected = event?.outcome != nil
    }
}

var query = OCKEventQuery(for: Date())
query.taskIDs = ["Doxylamine"]

let events = store
    .anyEvents(matching: query)
    .map { $0.first }

let viewController = SynchronizedViewController(
    initialViewModel: nil,
    viewModels: events,
    viewSynchronizer: TaskButtonViewSynchronizer()
)
```
---
## 구성 모듈
### CareKitStore
- CareKit 앱 내 모든 데이터는 CareKitStore에 저장됨    
- OCKStore라고도 불리며, 작업(Task), 결과(Outcome), 환자(Patient), 이벤트(Event) 등의 정보를 구조화하여 저장
- CoreData 기반으로 작동하지만, 사용자 정의 저장소도 구현 가능
### **OCKTask**
- 사용자가 해야 하는 일
	- 예: 약 복용, 운동, 명상 등
- 반복 주기 설정 가능
	- 매일, 특정 요일, 특정 주기 등
- 체크박스 형태로 완료 여부 추적 가능
```swift
let task = OCKTask(id: "medication", title: "복약하기", carePlanID: nil, schedule: ...)
```
### **OCKOutcome**
- OCKTask에 대한 실제 수행 결과
	- 예: 복약 여부, 통증 수치, 기분 상태 등.
### **UI 컴포넌트**
- OCKInstructionsTaskViewController: 설명과 함께 작업을 보여주는 UI
- OCKSimpleTaskViewController: 간단한 체크형 작업 UI
- OCKChecklistTaskViewController: 여러 하위 작업이 있는 체크리스트 UI
- OCKSymptomTrackerViewController: 증상이나 기분을 추적하는 UI