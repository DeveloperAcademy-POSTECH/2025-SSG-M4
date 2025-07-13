이제 좀 더 시야를 확장해서...! 
학교에는 지곡회관만 있는게 아니니까 nearmy랑 GS25를 살펴보자
이번에는 좀 더 구분이 되게 로그도 찍어볼 수 있게 설계하였다. 
### 이제 각 장소마다 다른 결제 조건도 정의하기가 간단하다. 

```swift
import Foundation

protocol 지곡회관결제수단 {
    func pay()
}

protocol nearme결제수단 {
    func coffeeOrder()
}

protocol 편의점결제수단 {
    func checkout()
}

// payco결제는 nearme에서 불가 
struct Payco: 지곡회관결제수단, 편의점결제수단 {
    func pay() {
        print("지곡회관에서 Payco 결제")
    }

    func checkout() {
        print("편의점에서 Payco 결제")
    }
}

// 신용카드는 다 됨 ! 
struct CreditCard: 지곡회관결제수단, nearme결제수단, 편의점결제수단 {
    func pay() {
        print("지곡회관에서 카드 결제")
    }

    func coffeeOrder() {
        print("nearme에서 카드 결제")
    }

    func checkout() {
        print("편의점에서 카드 결제")
    }
}

let Finn = Payco()

func 지곡회관결제(method: 지곡회관결제수단) {
    method.pay()
}

func nearme결제(method: nearme결제수단) {
    method.coffeeOrder()
}

func gs결제(method: 편의점결제수단) {
    method.checkout()
}
```

### 실제 사용
#### payco는 nearme빼고 다 되는 것을 확인했으니...
```swift
지곡회관결제(method: Finn) 
gs결제(method: Finn) 
```
### 에러 상황
#### 아래 처럼 이제 nearme결제수단 프로토콜을 따르지않는데 내가 payco를 집어넣으면 에러가 뜨는것이다. 
```swift
nearme결제(method: Finn) // payco는 nearme결제수단 protocol을 따르지 않음
```
>#### Argument type 'Payco' does not conform to expected type 'nearme결제수단'

이렇게 하나의 타입이 여러 Protocol을 동시에 따를 수 있다. 
신용카드 하나로 학식도 먹고, 카페도 가고, 편의점도 가는 것처럼 코드에서도 하나의 타입이 여러 역할을 수행할 수 있게 되는 거다.