>C++,Java,C# 도 VMT 사용

#### Swift는 어떻게 override 된 친구를 찾고 실행할까 ? 
- 자연스럽게 활용할 수 있는 대신에, Runtime Performance를 잃었다..!
- 이때 사용되는 방법은 VMT -> Virtual Method Table 


#### Static Dispatch (정적 디스패치)
- **결정**: 컴파일 타임
- **방식**: 메서드 실제 주소로 직접 점프
- **성능**: 빠름 (메모리 접근 1번)
- **제약**: 오버라이딩 불가

#### Dynamic Dispatch (동적 디스패치)  
- **결정**: 런타임
- **방식**: VMT를 통해 간접 점프
- **성능**: 상대적으로 느림 (메모리 접근 2번)
- **장점**: 다형성, 오버라이딩 지원



### 비유하자면...
#### Static = 미리 정한 약속
```
"내일 오후 2시 강남역 스타벅스에서 만나자"
→ 시간, 장소 미리 확정
→ 바로 해당 장소로 이동
```

#### Dynamic = 당일 연락 후 결정
```
"내일 만나자! 장소는 철수한테 물어봐"
→ 철수에게 연락 필요
→ 장소 확인 후 이동
```



#### 그럼 여기서 철수란 ? -> VMT

>[! 정의]
>Swift의 Dynamic Dispatch 를 통해 override와 상속을 할 수 있다.
>이를 위해 method 들과 property 들은 vtable에 배열로 저장됩니다.
>런타임에 Method Table에서 해당 method 들과 property를 찾고 간접 호출(indirect call) 방식으로 호출.
![[Pasted image 20250615203136.png | 400]]


#### VMT 구조와 생성
```swift
class Animal {
    func makeSound() { }  // VMT[0]
    func eat() {   // VMT[1]
	    print("개처럼먹기")
    }       
}
class Dog: Animal {
    override func eat() { }  // VMT[1] 오버라이드
    // makeSound()는 상속받음
}
```

#### 컴파일 타임 VMT 생성
```
Dog VMT
[0] : makeSound() 오버라이드 안 함 -> Animal.makeSound() 주소 복사
[1] : eat() 오버라이드 함 -> Dog.eat() 주소 사용

Dog VMT
[0] → 0x1111 (Animal.makeSound)
[1] → 0x9999 (Dog.eat)
```

### 실행 과정 비교

#### Static Dispatch 실행
```
컴파일 타임: 메서드 주소 확정
런타임: call 0x12345678 (직접 점프)
```

#### Dynamic Dispatch 실행
```
컴파일 타임: VMT 생성 및 주소 매핑 완료
런타임: 
1. 객체 → VMT 주소 찾기
2. VMT[index] → 메서드 주소 조회  
3. 해당 주소로 점프
```

```swift
let animal: Animal = Dog()
animal.eat()

// Dynamic Dispatch 과정:
// 1. animal 객체 확인 → Dog 발견
// 2. Dog VMT 접근
// 3. Dog VMT[1] → 0x9999 조회
// 4. 0x9999로 점프하여 Dog.eat() 실행
```

### VMT 의 구조는 ? 메소드 주소를 갖고 있는 배열
- 각 클래스는 하나의 VMT를 가짐 
- 클래스의 가상 메서드들에 대한 주소를 순서대로 저장한다.
- 인스턴스는 해당 클래스의 테이블에 대한 주소값을 가지고, 런타임에 올바른 메서드를 찾아 호출할 수 있다. (정확히는 TypeMeta 데이터 안에 VMT 주소가 있음 ! )

![[스크린샷 2025-06-15 오후 8.31.56.png | 400]]

>final 키워드를 통해 더 이상 상속이 없을거에요!! 라고 정의해주면 컴파일단계에서 Swift가 이제 최적화하여 VMT참조할 필요 없이 Static Dispatch가 가능하다.

#### Dynamic Dispatch는 왜 사용할까?
다형성을 지원하기 위해서 이렇게 함! 대신 프로그램이 훨씬 유연해지고 확장성이 좋음 ! 

### Dynamic Dispatch (메모리 접근 2번 (TypeMeta 데이터까지 포함하면 3번))
```
컴파일 타임: VMT 생성 및 배치
런타임: VMT 활용해서 주소 찾기
```
### Static Dispatch 
```
컴파일 타임: 주소 확정 및 코드에 직접 삽입
런타임: 바로 실행
```

### 그럼 단순 Class만인가 ? 

| 타입            | Dispatch 방식 | 이유                        |
| ------------- | ----------- | ------------------------- |
| `final class` | Static      | 상속 불가                     |
| `class`       | Dynamic     | 상속/오버라이딩 가능               |
| `struct`      | Static      | 상속 불가                     |
| `protocol`    | Dynamic     | Protocol Witness Table 사용 |
| `extension`   | Static      | 오버라이딩 불가                  |

### 그럼 Class내부에서 일부만 final로 선언해주면?
- 그럼 컴파일 단계에서 그 부분만 빠지고 실제 주소가 매핑되는것이고
- final아닌애들만 모아서 VMT가 생성됨

>그럼 컴파일때 VMT만들고 주소가 매핑되어있긴한데, 그게 실제 사용하는 메소드랑 연결되어있다기보다 그냥 그렇게해서 컴파일을 하게 되면 그때 매핑이 다 되어있는 VMT에 접근해서 주소로 접근한다는거네

``` title="Dynamic 컴파일타임"
class Animal { func sound() }
class Dog: Animal { override func sound() }
class Cat: Animal { override func sound() }

↓ 컴파일러 작업

VMT 생성:
┌─────────────┐
│ Animal VMT  │ [0] → 0x1111 (Animal.sound)
├─────────────┤
│ Dog VMT     │ [0] → 0x2222 (Dog.sound)  
├─────────────┤
│ Cat VMT     │ [0] → 0x3333 (Cat.sound)
└─────────────┘

실행 파일 완성 ✅
```

### SwiftData에서 final을 권장하는 이유
```swift
@Model
final class User {
    var name: String  // 얘가 변수라고해서 메서드가 아닌게 아님 ! 다  getter/setter가 필요한 친구들임 !!
}
```


### 최종 정리

### 컴파일 vs 런타임 작업
```
컴파일 타임
- Static: 메서드 주소 확정
- Dynamic: VMT 생성 및 주소 매핑

런타임:
- Static: 바로 실행
- Dynamic: VMT 조회 후 실행
```


[[테스트돌려보기]]

- 참조
	- https://medium.com/delightroom/swift-performance-%ED%96%A5%EC%83%81-%EC%8B%9C%ED%82%A4%EA%B8%B0-feat-method-dispatch-493ac4fc7782
	- https://github.com/swiftlang/swift/blob/main/docs/OptimizationTips.rst#dynamic-dispatch
	- https://velog.io/@go90js/methodedispatch




