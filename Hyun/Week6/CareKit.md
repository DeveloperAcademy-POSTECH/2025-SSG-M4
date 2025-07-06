> 사용자가 자신의 **건강 상태를 추적하고 관리**할 수 있도록 돕는 iOS 프레임워크,
> CareKitUI와 CareKitStore를 하나로 묶을 수 있는 뷰 컨트롤러를 제공하는 포괄적인 패키지
- 환자가 매일 해야 하는 일들(약 복용, 운동 등)을 체크
- 증상이나 기분을 기록
- 의료진이나 보호자와 그 데이터를 공유할 수 있게 하는 도구를 제공

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