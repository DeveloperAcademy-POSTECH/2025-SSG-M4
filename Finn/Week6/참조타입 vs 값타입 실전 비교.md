### 참조타입 예시
아래에서 볼 수 있듯이 나는 도서관 유령만 때렸는데 애꿎은 C5유령까지 아파하는 상황이다! 
이거는 인스턴스가 생성될때 Heap에 주소가 생성이 되고, 복사할때는 이 주소값만 복사해오는거지 진짜 유령이 2개로 늘어난게 아니다. 사실 C5유령은 도서관 유령이랑 같은 놈인 것이다. 그러니까 둘다 아파함 
```swift
import Foundation

class ghost {
    var hp : Int
    
    init(hp: Int) {
        self.hp = hp
    }
    func attacked(){
        self.hp -= 5
    }
}
var 도서관유령 = ghost(hp: 20)
var C5유령 = 도서관유령
var 효자동유령 = ghost(hp: 20)

도서관유령.attacked()
print(도서관유령.hp) //??
print(C5유령.hp)  // ??
print(효자동유령.hp)//?? 그럼 얜 뭐가 나올까요 ?!

```

![[Pasted image 20250629220112.png]]
#### 값타입으로 변경했을 때
```swift
import Foundation

struct ghost {
    var hp : Int
    
    
    mutating func attacked(){
        self.hp -= 5
    }
}
var 도서관유령 = ghost(hp: 20)
var C5유령 = 도서관유령
var 효자동유령 = ghost(hp: 20)

도서관유령.attacked()
print(도서관유령.hp) //??
print(C5유령.hp)  // ??
print(효자동유령.hp)//??

```

![[Pasted image 20250629222638.png]]