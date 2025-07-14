
## @ViewBuilder와 Computed Property의 한계

### 재사용성 따운 ! ⬇️
- **@ViewBuilder Function**: 다른 View에서 사용하려면 public으로 노출하거나, extension으로 분리해야 함
- **Computed Property**: 파라미터를 받을 수 없어 재사용이 거의 불가능. 복사-붙여넣기만 가능

### 파라미터 전달이 빡셈
```swift
// Computed Property는 파라미터를 받을 수가 없어서 동적 변경이 힘듬 
var customButton: some View {
    Button("고정된 타이틀") { }
}

// Struct View는 당연히 잘 받아서 동적으로 변환가능 
struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
    }
}
```

### Preview도 번거로움
```swift
// Struct View는 Preview 작성이 간단함
struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(isLiked: .constant(true))
    }
}
// @ViewBuilder나 Computed Property는 해당 함수나 프로퍼티가 포함된 전체 View를 Preview해야해서 지저분한 프리뷰 코드가 됨 ! 
```
