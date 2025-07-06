AI가 생성할 수 있는 구조화된 데이터 타입임을 명시하는 데 사용하는 매크로입니다.
> "이 타입을 LLM이 직접 생성할 수 있다"는 선언

**@Generable**을 struct 또는 enum에 붙이면,
struct와 enum의 인스턴스를 언어 모델(LLM)이 직접 생성할 수 있게 됩니다.
즉, 프롬프트와 함께 타입을 지정하면, 모델이 타입 구조에 딱 맞는 데이터를 자동으로 만들어줍니다. 이를 통해 타입 안전성 또한 보장할 수 있다.


```swift
Ex) 쇼핑 리스트 아이템을 생성하고 싶다면 

@Generable
struct ShoppingItem: Identifiable {
    let id: String
    let value: String
}
//이렇게 하면, LLM이 `ShoppingItem` 타입의 데이터를 직접 만들어낼 수 있습니다.

프롬프트: "쇼핑 리스트5개 만들어줘"

[
	ShoppingItem(id: "1", value: "우유"),
    ShoppingItem(id: "2", value: "달걀"),
    ShoppingItem(id: "3", value: "식빵"),
    ShoppingItem(id: "4", value: "사과"),
    ShoppingItem(id: "5", value: "치즈")
]
```
