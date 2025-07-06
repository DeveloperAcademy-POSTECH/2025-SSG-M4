## 결론
SwiftUI에서 View를 선언할 때는 Struct가 권장된다..!

## 그래서 언제 어떤 방식을 써야할까??!

### Struct View를 사용할 때
- 재사용 가능한 컴포넌트가 필요할 때
- 명확한 의존성 관리가 필요할 때  
- 다른 개발자가 사용할 수 있는 공용 컴포넌트를 만들 때
#### 걍 재사용성과 유지보수성에서 압도적인것만으로도 제일 환영받을만하다..!

### @ViewBuilder/Computed Property를 사용할 때
- 내부 코드 정리용
- 재사용 필요 없는 일회성 View할때만! 
- 급하게 프로토타입 개발할때는 쓸 수도 있다..! 

### 상황예시 
당장 급할 때 View의 body에 모든 코드를 때려박는 것보다는 `@ViewBuilder`나 `computed property`로 1차적으로 분리하는 것이 그나마 나은선택일 것입니다..! 근데, 결국에는 이전까지 봤던 이유로 임시 방편이라서,  
추후에 시간이 날 때 `Struct`로 깔끔하게 빼주는게 결국 최종 목적지구나 생각을 했다.. 
과정이 될수는 있어도 종착지는 `Struct View`구나.. 생각을 했습니다..! 
이전에는 `@ViewBuilder`가 좀 더 매력적인 선택지인줄 알았는데, 이에대한 환상을 깰 수가 있었다. 

```swift
// 급할 때 - @ViewBuilder로 일단 분리
@ViewBuilder
private func headerSection() -> some View {
    HStack {
        Text("제목")
        Spacer()
        Button("액션") { }
    }
}

// 한숨자고 일어난다음에, 여유가 생겼을때 Struct로 리팩토링
struct HeaderSection: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button("액션", action: action)
        }
    }
}
```

<img src="https://velog.velcdn.com/images/bishoe01/post/45d03567-e724-4ef0-a7ea-0a0f5722b620/image.png" width=400 /> 

## 핵심 요약
- **최종 목표는 Struct View**
- @ViewBuilder와 Computed Property는 과정일 뿐, 종착지가 아니라는 생각을 했다. 특수한 상황의 예외적인 부분에대해서는 좀 공부가 필요할 듯 ..! 
- 재사용성과 유지보수를 생각한다면 Struct View가 정답! 