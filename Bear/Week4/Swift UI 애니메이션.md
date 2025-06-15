## 1. SwiftUI 애니메이션의 정의

SwiftUI의 애니메이션은 복잡한 만화 영상보다는 발표 자료의 **화면 전환 효과**와 비슷합니다. 컴포넌트의 크기, 위치, 색상 등 **상태(State)가 변할 때, 그 시각적 변화를 부드럽게 이어주는 것**을 의미합니다.

- **핵심:** 상태 변화를 부드럽게 시각화하는 것.
- **구현:** 뷰(View)에 `.animation()` 모디파이어를 추가하면 SwiftUI가 변화를 감지하고 자동으로 전환 효과를 적용해 줍니다.
- **복잡한 효과:** Lottie, GIF 등 _외부 라이브러리_ 사용이 일반적입니다.

---
## 2. 애니메이션 사용법: 암묵적 vs 명시적

애니메이션을 적용하는 방법은 크게 두 가지로 나뉩니다.

### 암묵적(Implicit) 애니메이션

- **사용법:** 애니메이션을 적용할 뷰에 `.animation()` 모디파이어를 직접 붙입니다.
- **특징:** 해당 뷰에 일어나는 **모든 상태 변화**에 동일한 애니메이션이 적용됩니다. 사용이 매우 간단합니다.
- **한계:** 상태 변화별로 다른 애니메이션을 적용하거나, 특정 변화만 애니메이션을 주고 싶을 때 유연성이 떨어집니다.

### 암묵적 애니메이션 예시

`Circle`의 크기(`scaleEffect`)와 위치(`position`)가 버튼을 누를 때마다 변하며, 두 변화 모두 0.5초의 `linear` 애니메이션이 적용됩니다.

``` Swift
import SwiftUI

struct ImplicitAnimationExample: View {
    @State var circlePos: CGPoint = CGPoint(x: 150, y: 150)
    @State var isSmall: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .position(circlePos)
                .scaleEffect(isSmall ? 1 : 2)
                .animation(.linear(duration: 0.5), value: circlePos)
                .animation(.linear(duration: 0.5), value: isSmall)

            Button("Animate") {
                isSmall.toggle()
                circlePos = CGPoint(x: Int.random(in: 100...300), y: Int.random(in: 100...300))
            }
        }
    }
}
```

### 명시적(Explicit) 애니메이션

- **사용법:** 애니메이션을 적용하고 싶은 **상태 변경 코드**를 `withAnimation { ... }` 클로저로 감싸줍니다.
- **특징:** **특정 상태 변화에만** 애니메이션을 적용할 수 있어 세밀한 제어가 가능합니다.
- **예시:** 버튼을 눌렀을 때 위치는 애니메이션으로 바꾸고, 색상은 즉시 바꾸는 등의 제어가 가능합니다.

|종류|암묵적 애니메이션|명시적 애니메이션|
|:--|:--|:--|
|**사용성**|간단함|비교적 복잡함|
|**형태**|모디파이어 (`.animation`)|클로저 (`withAnimation`)|
### 명시적 애니메이션 예시

버튼을 누르면 `withAnimation` 블록으로 감싸진 `heartPosition`의 변화에만 1초의 애니메이션이 적용됩니다. `heartColor`는 즉시 변경됩니다.

``` Swift
import SwiftUI

struct ExplicitAnimationExample: View {
    @State var heartPosition: CGPoint = CGPoint(x: 150, y: 100)
    @State var heartColor: Color = .black

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(heartColor)
                .position(heartPosition)
            
            Button("Animate Heart") {
                withAnimation(.linear(duration: 1)) {
                    heartPosition = CGPoint(x: Int.random(in: 50...300), y: Int.random(in: 50...200))
                }
                heartColor = heartColor == .black ? .red : .black
            }
        }
    }
}
```
---

## 3. 애니메이션 오버라이딩과 중첩

### 애니메이션 오버라이딩 (Overriding)

만약 하나의 뷰에 명시적 애니메이션과 암묵적 애니메이션을 모두 적용하면 어떻게 될까요?

- **결론:** **암묵적 애니메이션이 명시적 애니메이션을 덮어씁니다(Override).**
- **주의점:** 의도치 않은 동작이나 "돌발성 애니메이션"의 원인이 될 수 있으며, 코드 가독성을 크게 해칠 수 있습니다.

### 애니메이션 오버라이딩 예시

`withAnimation`으로 1초짜리 명시적 애니메이션을 줬지만, 뷰에 `.animation`으로 0.3초짜리 암묵적 애니메이션이 적용되어 있어 **최종적으로 0.3초 애니메이션이 실행**됩니다.

``` Swift
import SwiftUI

struct OverrideAnimationExample: View {
    @State var heartPosition: CGPoint = CGPoint(x: 150, y: 100)

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .position(heartPosition)
                .animation(.linear(duration: 0.3), value: heartPosition) // 암묵적 애니메이션

            Button("Animate Heart") {
                withAnimation(.linear(duration: 1)) { // 명시적 애니메이션
                    heartPosition = CGPoint(x: Int.random(in: 50...300), y: Int.random(in: 50...200))
                }
            }
        }
    }
}
```

---
### 중첩 애니메이션 (Nested)

오버라이딩의 문제를 피하고, **하나의 뷰에서 여러 속성에 각기 다른 애니메이션을 적용**하고 싶을 때 권장되는 방식입니다.

- **형태 1:** 효과 모디파이어 바로 아래에 `.animation`을 각각 적용합니다.
- **형태 2 (애플 권장):** `.animation` 모디파이어의 후행 클로저를 사용하여 특정 효과에만 애니메이션을 적용합니다.
### 중첩 애니메이션 예시 (후행 클로저)

`.animation`의 후행 클로저를 사용하여 `shadow`와 `scaleEffect`에 각각 다른 타이밍 커브의 애니메이션을 적용합니다.

```  Swift
import SwiftUI

struct NestedAnimationExample: View {
    @State private var selected = false

    var body: some View {
        Image(systemName: "swift")
            .font(.system(size: 100))
            .foregroundStyle(.orange)
            .animation(.easeOut, value: selected) {
                $0.shadow(radius: selected ? 12 : 8)
            }
            .animation(.bouncy, value: selected) {
                $0.scaleEffect(selected ? 1.5 : 1.0)
            }
            .onTapGesture {
                selected.toggle()
            }
    }
}
```

---
## 4. 애니메이션 옵션

애니메이션의 동작을 세밀하게 조절할 수 있는 3가지 주요 옵션입니다.

- **`Duration` (실행 시간):** 애니메이션이 끝날 때까지 걸리는 시간. 값이 작을수록 빠릅니다.
- **`Repeat` (반복):** 애니메이션 반복 횟수를 지정합니다.
- **`Timing Curve` (타이밍 커브):** 애니메이션 진행 속도의 변화를 조절하는 곡선입니다.
    - `linear`: 처음부터 끝까지 등속으로 움직입니다.
    - `easeIn`: 천천히 시작해서 점점 빨라집니다.
    - `easeOut`: 빠르게 시작해서 점점 느려집니다.
    - `easeInOut`: 천천히 시작해서 중간에 빨라졌다가 다시 천천히 끝납니다. **(가장 자연스러움)**

---
## 5. 트랜지션 (Transition)

트랜지션은 애니메이션 효과 그 자체를 의미하며, 주로 3가지 변화로 나눌 수 있습니다.

1. **형태/크기 변화:** `scaleEffect`, `rotationEffect` 등
2. **위치 변화:** `offset`, `position` 등
3. **색/배경 변화:** `opacity`, `foregroundColor`, `background` 등





