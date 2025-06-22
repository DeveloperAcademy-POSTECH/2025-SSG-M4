
평소에 Swift관련 문서들을 좀 보다보면 자주 등장하는 단어가 있는데 그게 바로 ARC다 ! 
어디에서 나오는지 예시를 들어보자면.. 
#### 클래스 - 인스턴스
> `var person = Person(name: "John")`
1. 클래스에서 인스턴스를 만들면 ARC가 자동으로 메모리를 관리해준다.
2. 더 이상 필요없을 때 nil을 할당하면 ARC가 메모리를 해제한다.

여기까지보면 다른 언어에서의 [[Arc vs GarbageCollector| GarbageCollector]] 같은 느낌이 조금 난다. 여튼 메모리를 잘 관리시켜주는 어떠한 구조인 것까지는 오케이 ! 

#### [[강한 참조사이클(Strong Reference Cycle)]]에서..

>```swift
>class Person { var apartment: Apartment? }
>class Apartment { var tenant: Person? }
>```

#### 클로저 강한참조 사이클
`[weak self]`, ‎`[unowned self]`는 자주 보셨을 것 같은데, 이걸 캡처리스트 문법이라 합니다! [[캡처 리스트 문법]]이 ARC와 함께 자주 언급됩니다.

[[메모리 누수 예시]]

이번엔 그 ARC를 좀 파악해보려고 한다!

>[! Definition of ARC]
>ARC = 메모리를 자동으로 관리해주는 Swift의 시스템
>객체의 참조 개수를 세어서 0이 되면 자동으로 메모리에서 해제해줌
>ARC 라는게 (Automatic Reference Counting)말그대로 자동으로 참조의 카운팅을 센다는것이고
>1. 카운트가 0이되면 해제되는것이고
>2. 1이라도 남아있으면 메모리에 할당해줘서 붙잡고 있는다! 
>3. 그래서 weak으로 참조하면 얘는 참조카운팅이 안된다!


#### 그럼 왜 weak이 기본값이 아닌가?
- 아까 말햇듯이 참조카운트가 0이되야 사라진다는거는 결국 참조를 하나라도 남겨놔야 안사라진다는 이야기라서!! 원래 써먹으려고 생성한거니까 강하게 참조해야 얘를 묶어놓을 수 있는것!! 

#### 예시

```swift
class 사람 {
    weak var 핸드폰: 핸드폰? 
}
class 핸드폰 {
    let 번호: String
    init(번호: String) { self.번호 = 번호 }
}
var 철수 = 사람()
철수.핸드폰 = 핸드폰(번호: "010-1234-5678")  
// 핸드폰이 바로 사라짐! 참조카운트 0이라 바로 핸드폰 폭파
print(철수.핸드폰?.번호) // 그래서 이 철수 핸폰번호는 이제 해제돼서nil임 
```

### 그럼 weak을 언제 써야하는걸까??!
이번에는 좀 더 종속관계가 잘 드러나는 친구들을 예시로 들어보자 !  
내가 산책하는 고양이를 입양했다고 하자 이름은 노벨이  
![[Pasted image 20250621225646.png | 200]]
근데 내가 입양하자마자 산책할때 목줄을 잃어버렸다고 가정! 
```swift
import Foundation

class 인간 {
    var 펫: 반려동물?
}

class 반려동물 {
    weak var 주인: 인간?
}

var Finn: 인간? = 인간()
var 노벨이: 반려동물? = 반려동물()

func 산책() {
    목줄잃음()
}
func 목줄잃음() {
    Finn = nil
}

// 입양
Finn?.펫 = 노벨이
노벨이?.주인 = Finn

print(노벨이?.주인)  // Finn 이 출력될 것이다. Optional로 

산책() // 목줄을 여기서 잃어버리겠죠?! 목줄잃음 메소드가 안에 있어유 

print(노벨이?.주인) // nil 됨 목줄 놓고 도망가니까 바로 주인없는 상태 
//바로 사라짐 weak이어서 가능

```

### unowned  - weak 비교! 
#### 일단 둘다 참조카운트를 늘리지 않는다는게 공통점이 있음 
- unowned - 절대로 먼저 사라질일 없을거라고 확신할 때 사용 -> Nil 뜨면 터지기 때문 
- weak - 먼저 떠날 수 있음 그래도 괜찮 -> nil뜬다고 터지지 않음 

#### weak이 훨씬 자유롭고 , unowned는 확실한 종속적 관계 , 생명주기 빡세게 잘 관리해줘야됨 

### weak하면 빼놓을 수 없는게 또  [[델리게이트 패턴 ]]



### 마지막으로 
#### 그럼 클로저에서 [weak self] 쓰는거는 봤는데, 언제 쓰면되는걸까?
1. 비동기작업
2. 오래 살아있는 친구일때 
```swift
class ViewController {
    var completion: (() -> Void)?
    func setupCompletion() {
        completion = { [weak self] in
            self?.doSomething()  // completion이 언제까지 살아있을지 모르면 그냥 weak써주시죠 ! 
        }
    }
}
```

### 그래서 결론  !
1. ARC는 참조 카운트가 0이 되면 자동으로 메모리 해제되는 친구임. 그냥 그게 끝 ! 
2. 순환참조 때문에 카운트가 0이 안 되면 메모리 누수 발생
3. weak/unowned로 순환참조 해결 - weak가 더 안전함

### 실제 개발 단계에서는..
- 클로저에서 `[weak self]` 잘 써주자 ! 
- 서로의 그 관계성을 잘 파악해서 `strong`, `weak`, `unowned` 잘 고려해라! 
- 잘 모르겠으면 그냥 `weak`써라 ! 