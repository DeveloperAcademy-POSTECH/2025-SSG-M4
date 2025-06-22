>[! 정의]
>클래스 인스턴스끼리 서로를 참조할 때, 서로를 참조하고 있다보니까 이때 ARC가 계속 쓰는지 알고 해제를 못해줘서 메모리를 물고있다, 메모리 누수가 일어난다는 소리 

#### 간단한 예시
```swift
class Person {
    var friend: Person?
}
var a: Person? = Person()
var b: Person? = Person()

a?.friend = b
b?.friend = a

a = nil
b = nil
```
// 둘 다 메모리에서 해제되지 않음 (강한 참조 사이클)

### 여기서 만약 weak로 바꾸면 해결이 될까요????!!! 
```swift
class Person {
    weak var friend: Person?
}
```

#### 땡입니다... 
이러면 서로가 서로에게 약한참조가 걸려있어서 ARC가 0이라 유지가 안됩니다.
```swift
import Foundation
class Person {
    weak var friend: Person?
    deinit {
        print("\(friend) 해제됨")
    }
}

var a: Person? = Person()
var b: Person? = Person()

a?.friend = b
b?.friend = a

a = nil
print("HHi")
b = nil
print("HHi")
sleep(5)


///출력

//Optional(leetcode.Person) 해제됨
//HHi
//nil 해제됨
//HHi
```

### 다른 예시

```swift
import Foundation

class Dog {
    var name: String
    weak var owner: Person? // 강아지는 주인이 없어도 잘 살던 스트릿 출신

    init(_ name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 강아지 해제됨")
    }
}

class Person {
    var name: String
    var dog: Dog? // 주인은 강아지를 죽을때까지 키울것임

    init(_ name: String) {
        self.name = name
    }

    deinit {
        print("\(name) 해제됨")
    }
}

var 철수: Person? = Person("철수")
var 멍멍이: Dog? = Dog("멍멍이")

철수?.dog = 멍멍이
멍멍이?.owner = 철수
```
![[Pasted image 20250622153154.png | 400]]

### QUIZ 
1. 멍멍이 = nil 이 실행되면 어떻게 굴러갈까? 
2. 철수 = nil 이 실행되면 ? 
3. 이 설계는 강아지 와 인간  둘중에 누가먼저 nil 이 될걸 예상하고 설계한것일까??