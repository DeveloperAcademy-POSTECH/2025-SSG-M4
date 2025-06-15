
>[! 정의]
>`final`선언하면 상속이 불가능하다. 
>기존에 생성된 형태 그대로만을 고수해야하는 것인데, 데이터 모델은 상속할 일이 없기때문에 웬만하면 final로 선언해주는게 또 이상적인 방식! (Apple 문서에서도 final 로 선언중 )

### 성능에도 좋다는 풍문이... ?!
- final이 안붙어있는 경우에는 이게 하위클래스에서 오버라이드 될 수 있어서, 그 부분을 다 체크한뒤에 지금 실행 조건에 맞는 메서드를 실행하는 구조인데,
- final 로 생성된 친구는 그런거 고려할 거 없이 그냥 바로 찾아서 실행할 수가 있다. 

```
일반 클래스 메서드 호출:
메서드 호출 → 타입 체크 → 오버라이드 체크 → 실제 메서드 찾기 → 호출
   (느림)        (시간)        (시간)          (시간)        (실행)

final 클래스 메서드 호출:
메서드 호출 → 바로 실행
   (빠름)       (실행)
```

### Data는 메서드가 없지않나? 그러면 Final로 굳이 해줄 필요가 없을 것 같은데 ?

## 땡! 

#### @Model은 결국 Observable,Identifiable 
```swift
@Model
final class User {
    var name: String
}

/// 실제로 컴파일러가 이해하는 것 
final class User: Observable, Identifiable {
    var name: String
    
    var id: UUID = UUID()
    
    // Observable 자동 구현 (변경 감지)
    private var observers: [Observer] = []
    func addObserver(_ observer: Observer) { /* ... */ }
    func notifyChange() { /* ... */ }
}
```

```swift
@Model final class User {
		var name: String // 이것도 사실 getter/setter 메서드 
	}
let user = User() 
user.name = "홍길동" // setter 메서드 호출 
print(user.name)   // getter 메서드 호출
```

그러면 이걸 Swift는 어떻게 내부적으로 override된 친구를 판단하는지? 

### [[Method Dispatch Type]]