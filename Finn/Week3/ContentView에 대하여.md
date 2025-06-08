

## 의도한 플로우
1. 회원가입 (OnboardingView)
2. 회원가입 완료 -> MainView로 이동
3. 다시 돌아올 수 X 

```swift title:"기존 코드"
private func completeOnboarding() {
    // ... 사용자 데이터 생성 로직 ...
    do {
        try modelContext.save()
        router.navigate(to: .mainView)
    } catch {
        print("Error saving user: \(error)")
    }
}
```
[[Router.swift]]
다음과 같이`router.navigate(to: .mainView)` 를 사용하면
이동 전 페이지인 `OnboardingView`까지도 `navigationStack`에 남게된다..!
그래서 결국 아래 영상처럼 어렵게  회원가입을 하고도 naviagationheader에 back버튼이 남고, 실제로 뒤로 돌아갈 수가 있다..(회원가입 두번하게하면 안되는데..)

![[Kapture 2025-06-05 at 21.16.40.gif]]

---

### 1차 개선안 navigate(to: ) -> navigateToRoot()

```swift
func navigateToRoot() {
        path.removeLast(path.count)
    }
```

```swift title:"문제가 있던 코드"
private func completeOnboarding() {
    // ... 사용자 데이터 생성 로직 ...
    do {
        try modelContext.save()
        router.navigateToRoot()      // 동작 X
    } catch {
        print("Error saving user: \(error)")
    }
}
```

###  Trouble
이렇게해주면 될줄?!! 이번엔 아예 이동을 안한다..!  

> RootView로 이동하는건데, 그럼 NavigationStack은 루트뷰가 어디인지 어떻게 규정하지??
> [How can i replace rootView in swiftui navigationStack?](https://stackoverflow.com/questions/72973181/how-can-i-replace-the-root-view-in-swiftui-using-the-navigationstack)

여기 나온대로 이게 임의로 조정할 수도 없는 것이고 `NavigationStack`을 선언해줬을 때 가장 처음으로 보여지는 view가 `RootView`로 정의 됨! [[NavigationStackRoot.excalidraw]]

![[스크린샷 2025-06-08 오후 9.14.28.png | 500]]

그니까 여기에서는 유저가 있냐 없냐에따라 RootView가 갈림
- `OnboardingView()`
- `MainView()`
```swift title:"ContentView.swift - 핵심 로직" hl:6-12
struct ContentView: View {
    @State private var router = Router()
    @Query var users: [User]  // SwiftData로 사용자 상태 관찰
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if users.isEmpty {
                    OnboardingView()  // 첫 방문자
                } else {
                    MainView()        // 기존 사용자
                }
            }
            ...etc
        }
    }
}
```

#### 근데 그러면 `Onboarding`이 끝난 시점에서는 당연히 되어야하는거 아닌가 ?? 
그때는 `user.isEmpty`에 걸리지 않을텐데...?
그럼에도 여전히 `OnboardingView()`가 `rootView`로 잡혀있었음 ! 

---

### 해결과정

#### 원인  - 숨어있던 삭제로직

[[데이터삭제로직 | SwiftDataManger deleteAllData로직]]
```swift title:mainView_더미데이터_관리로직
 .onAppear {
	//  MARK: 한번만 실행시키고 주석처리해주시면 됩니다 !
	//  DummyDataManager.createDummyData(context: modelContext, projects: allProjects)
	//
	// 이거는 테스트할때만! swiftData초기화를 위해서 사용합니다.
	SwiftDataManager.deleteAllData(context: modelContext)
                }
```

여기에서 모든 데이터를 삭제해주고 있기때문에 
- `MainView`를 렌더링하려하면..
- 바로 삭제가 되어서 `rootView`가 `MainView`가 되고..! 
- 관측되는 순간에 데이터가 지워져서 `user.isEmpty`에 걸리고..!
- 바로 `rootView`는 `OnboardingView`가 되어서 이동이 안되는 것처럼 보인것
	- (그래서 깜빡이고 이동을 안함)


---

### 그럼 RootView로 돌아가는게 필요한가?
- `contentView`가 바로 바로 user.isEmpty`를 즉각적으로 판단하는 친구라면..! 이미 `ContentView`는 렌더링중이었나..? 
- 렌더링중이라면 `user.isEmpty`를 인지하면 Rootview가 바뀌기도하고, 보여주고있는 View자체를 rootView로 바꿔주는거아닌가? 굳이 한 번더 루트로가 ! 라고 말할 필요도 없는거 아닌가?

### 정답 ! 
#### ContentView는 루트 컨테이너다 
- 내가 `WindowGroup`에서 `contentView`를 [[WindowGroup-ContentView | 루트로 지정]]을 했기 때문에, ContentView는 앱이 실행되는한 꺼지지 않는 TV다 ! 
- ContentView는 TV 본체이고, 그 안에 보여지는 OnboardingView/MainView는 채널과 같다.

>[[active, inactive, background]]상태를 오갈 때도 메모리상에 남아있고, 실제로 앱이 종료되거나 scene이 파괴될 때만 사라짐 ! 
```swift
// TV 본체 (항상 존재)
ContentView {
    // 채널 1: 온보딩
    if users.isEmpty { OnboardingView() }
    // 채널 2: 메인 화면  
    else { MainView() }
}
```

#### 그래서 결론 !
`ContentView`가 민감하게 반응하고 있기때문에, 그냥 `navigate`같은거 없어도 애초에 `ContentView`에서 보여주고 있는 화면 자체가 바뀐다 ! 

```swift title:"최종 개선 코드 "
private func completeOnboarding() {
    // ... 사용자 데이터 생성 로직 ...
    do {
        try modelContext.save()
        // router.navigateToRoot() 없어도됨 !
    } catch {
        print("Error saving user: \(error)")
    }
}
```


### `user.isEmpty`는 24시간 감시당하고 있나? 어떻게 바로알지?

#### SwiftData의 @Query -> reactive state observation
> [!@Query정의]
> A property wrapper that fetches a set of models and keeps those models in sync with the underlying data.

쉽게 말하면 얘도 @State처럼 값이 바뀔 때마다 SwiftUI뷰를 최신상태로 업그레이드합니다! 
SwiftData로 가져오는 @State라고 보시면 될 것 같아요! 
이것도 결국엔 `ContentView`가 항상 존재하기 때문에 가능한 로직입니다 !! 

### Tags
#SwiftUI #Navigation #Router 

