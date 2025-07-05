AI 모델이 단순한 텍스트가 아닌 정확하게 구조화된 Swift 데이터 타입(예: struct, enum 등) 인스턴스를 직접 생성하도록 유도하는 기술
> 즉 변환할 필요없이 앱에서 바로 쓸 수 있는 Swift 데이터 타입으로 정확하게 결과를 만들어준다.

왜 Guided Generation이 필요한가?
- 기존 LLM은 자연어 텍스트, JSON 등 비정형 데이터를 생성한다. 
	-> 이로인해 앱 상에서 데이터를 파싱하고 검증할 때 오류 또는 예측하지 못한 구조가 나올 수 있다.

## Guided Generation의 장점
- AI 모델이 지정한 데이터 구조로 결과를 반환한다.
- Swift 코드와 자연스럽게 연동되어, 타입 안전성(Type Safety)이 보장된다.
- 프롬프트에 출력 포맷을 명시하지 않아도 되며, 파싱/검증 코드가 필요 없다.
  
## 작동 방식
1. Swift 타입 정의
	-  `@Generable` 매크로를 사용해 모델이 생성할 타입(struct, enum)을 정의합니다.
	-  각 프로퍼티에 `@Guide`를 붙여 모델에게 필드에 대한 설명이나 제약 조건을 추가할 수 있습니다.
```swift
@Generable
struct Recipe {
    @Guide(description: "The name of the recipe.")
    let name: String
    @Guide(description: "A short description of the recipe.")//제약
    let description: String
    @Guide(description: "A list of main ingredients.")
    let ingredients: [String]
}
```

2. 프롬프트와 함께 모델에 요청
	- 프롬프트(사용자의 요청)와 함께 위에서 정의한 타입을 모델에 전달합니다.
	- 프롬프트 예시: “피자 레시피를 알려줘”
	- 프레임워크는 프롬프트와 Swift 타입(struct, enum)의 구조 정보를 이용해 모델이 이해할 수 있도록 자동 변환하며, 결과 값도 자동으로 해당 타입의 인스턴스로 반환된다.

3. 모델이 구조화 데이터 반환
	- 모델은 Recipe 타입에 맞는 정확한 구조의 데이터를 생성해 반환합니다.
```swift
[예시 결과]
name: “마르게리타 피자”
description: “토마토와 모짜렐라 치즈, 바질이 어우러진 전통 이탈리아 피자”
ingredients: “토마토”, “모짜렐라 치즈”, “바질”, “올리브 오일
```
## 추가 특징
- 중첩/복합 타입도 지원: struct 안에 struct, enum 등 복잡한 타입도 생성 가능합니다.
- 부분 생성(Streaming): 결과를 점진적으로 생성해, 중간 결과를 UI에 실시간 반영함으로 저 좋은 UX를 제공합니다.
- 정규 표현식, 값 제약 조건 등도 @Guide에 추가해, 생성값을 더욱 세밀하게 통제할 수 있습니다.
```swift
@Generable
struct User {
    @Guide(description: "사용자 ID", regex: #"^[a-z0-9]{6,12}$"#)
    let userID: String

    @Guide(description: "나이", min: 18, max: 99)
    let age: Int

    @Guide(description: "관심사", count: 3)
    let interests: [String]
}
```

- 오류 방지: 모델이 타입 정의에 맞지 않는 데이터를 생성하면, 프레임워크가 자동으로 예외를 발생시켜 앱의 안정성을 보장합니다.