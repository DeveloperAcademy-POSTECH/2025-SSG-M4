>변수를 감시하다가 값이 바뀌면 자동으로 알림을 보내주는 속성 wrapper
- 변수 값이 바뀔 때 해당 객체를 참조하고 있는 뷰들에게 자동으로 알려줌

### 사용 상황
- `ObservableObject` 클래스에서 값이 바뀔 때 뷰를 갱신하고 싶을 경우
	- 뷰에 실시간 반영 필요
- 뷰 간에 상태를 공유하면서 자동 반응하게 만들고 싶을 때
	- 앱 전체의 UI 흐름을 통일감 있게 유지

### 주의 사항
- 클래스 내에서만 사용 가능
	- `struct`, `enum` 등에서 사용 불가
- `@State`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject` 등의 SwiftUI 속성과 함께 써야만 UI가 반응
- `@Published` 자체는 UI 갱신하지 않음
	- 이를 바라보는 뷰(`ObservableObject` 기반)가 있어야 작동