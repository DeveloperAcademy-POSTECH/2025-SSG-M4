Protocol에 Extension을 붙이면 기본 구현을 제공할 수 있다. 
이 친구가 드디어 설계도를 벗어나서 직접적으로 영향을 끼칠 수 있는 것이다. 
(결국 그냥 Extension발사대의 역할을 하는 것이긴한데.. )
앞에서 만든 결제에 이어서 이번에는 모든 결제수단에 공통으로 들어가는 기능을 추가해보려한다..! 
영수증 출력인데, 다시 돌아와서 지곡회관에 집중해보도록하자..! 

### extension없이 구현
```swift
protocol 지곡회관결제수단 {
    func pay()
}

// Extension으로 공통 기능 추가
extension 지곡회관결제수단 {
    func payWithLog() {
        print("===결제 시작===")
        pay()  // 각 결제수단별 pay()
    }
}

struct Payco: 지곡회관결제수단 {
    func pay() {
        print("Payco 결제")
    }
}

struct CreditCard: 지곡회관결제수단 {
    func pay() {
        print("카드 결제")
    }
}

struct Pfront: 지곡회관결제수단 {
    func pay() {
        print("P.front 결제")
    }
}
```

이렇게해주면 이제 각각에 대해서 굳이 영수증 메소드를 넣어줄 필요없이 굳이 선언을 해주지않더라도 이미 구현된걸 사용할 수가 있게된다.. 

### 실전 사용 

```swift
let finn = Payco()
finn.payWithLog()
// ===결제 시작===
// Payco 결제

let card = CreditCard()
card.payWithLog()  // 똑같은 형식으로 출력가능
```

Extension으로 기본 구현을 제공하면 모든 타입에서 반복되는 코드를 한 곳에서 관리할 수 있게 되는 것이다..! 
영수증 양식이 바뀌면? Extension만 수정하면 될 것이다..!