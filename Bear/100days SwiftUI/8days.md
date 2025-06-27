# 3.Swift의 튜플(Tuples): 여러 값을 반환하는 우아한 방법

함수에서 여러 개의 값을 반환해야 할 때 어떤 방법을 사용하시나요? Swift는 이 문제를 명확하고 안전하게 해결할 수 있는 **튜플(Tuple)**이라는 강력한 기능을 제공합니다. 튜플이 왜 필요하며, 배열이나 딕셔너리에 비해 어떤 장점을 갖는지 자세히 알아보겠습니다.

## ## 함수에서 여러 값을 반환해야 할 때의 문제점

하나의 값만 반환할 때는 간단합니다. 아래 코드처럼 반환 타입을 지정하면 됩니다.

``` Swift
// 문자열이 모두 대문자인지 확인하는 함수
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
```

하지만 두 개 이상의 값을 반환해야 한다면 어떨까요? 보통 배열이나 딕셔너리를 떠올릴 수 있지만, 각자 명확한 한계를 가지고 있습니다.

### ### 1. 배열(Array) 사용의 한계

배열을 사용해 사용자의 상세 정보를 반환하는 함수를 만들어 보겠습니다.

```Swift
func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print("Name: \(user[0]) \(user[1])") 
// 출력: Name: Taylor Swift
```

**문제점:**

- **가독성 부족**: `user[0]`과 `user[1]`이 각각 무엇을 의미하는지(이름인지, 성인지) 코드를 보거나 추측해야만 알 수 있습니다. 기억하기 매우 어렵습니다.
- **안전성 부족**: 만약 함수 내부 로직이 변경되어 배열에 다른 데이터가 추가되거나 순서가 바뀐다면, `user[0]`은 더 이상 이름이 아닐 수 있습니다. 최악의 경우, 해당 인덱스에 값이 존재하지 않아 앱이 충돌할 수도 있습니다.

### ### 2. 딕셔너리(Dictionary) 사용의 한계

이러한 문제를 해결하기 위해 딕셔너리를 사용할 수도 있습니다.

```Swift
func getUser() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let user = getUser()
print("Name: \(user["firstName", default: "Anonymous"]) \(user["lastName", default: "Anonymous"])")
// 출력: Name: Taylor Swift
```

**문제점:**

- **불필요한 기본값 처리**: 우리는 `firstName`과 `lastName` 키에 항상 값이 존재한다는 것을 _알고 있음에도 불구하고_, 딕셔너리의 값은 옵셔널(Optional)이기 때문에 항상 기본값(`default:`)을 제공해야 합니다. 이는 코드를 길고 복잡하게 만듭니다.
- **오타 가능성**: 키(key)가 문자열이기 때문에 `"firstName"`을 `"firstname"`으로 잘못 입력하면 컴파일러는 오류를 잡아내지 못합니다. 대신 실행 시점에 기본값인 "Anonymous"가 출력되어 버그를 찾기 어려워집니다.

## ## 튜플(Tuple): 문제의 해결책

튜플은 배열과 딕셔너리의 단점을 보완하는 완벽한 해결책입니다. 튜플은 **고정된 개수**의 값들을 하나의 단위로 묶어주며, 각 항목은 **서로 다른 타입**을 가질 수 있습니다.

튜플을 사용해 `getUser()` 함수를 다시 작성해 보겠습니다.

```Swift
// 반환 타입으로 (firstName: String, lastName: String) 튜플을 지정
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")
// 출력: Name: Taylor Swift
```

**튜플 사용법 분석:**

1. **반환 타입 선언**: 함수의 반환 타입으로 `(firstName: String, lastName: String)`을 명시했습니다. 이는 "이 함수는 `firstName`이라는 `String`과 `lastName`이라는 `String`을 포함한 튜플을 반환한다"는 의미입니다.
2. **이름 있는 원소**: 튜플의 각 항목은 `firstName`, `lastName`과 같이 고유한 이름을 가집니다. 이는 딕셔너리의 키처럼 문자열이 아니므로 오타로부터 안전합니다.
3. **값 반환**: 함수 내부에서는 선언한 튜플의 형태에 맞춰 각 이름에 값을 할당하여 반환합니다.
4. **안전한 접근**: 튜플의 값을 사용할 때는 `user.firstName`처럼 **점(.) 표기법**으로 안전하고 명확하게 접근할 수 있습니다.

## ## 튜플 vs. 딕셔너리: 무엇이 다른가?

튜플은 딕셔너리와 비슷해 보이지만, 다음과 같은 핵심적인 차이점이 있습니다.

|특징|튜플 (Tuple)|딕셔너리 (Dictionary)|
|:--|:--|:--|
|**안전성**|**컴파일 시점 확인**: Swift는 컴파일 시점에 튜플의 모든 값이 존재하며 타입이 일치하는지 확인합니다.|**런타임 확인**: 값이 존재하지 않을 수 있으므로(옵셔널), 항상 기본값을 처리해야 합니다.|
|**접근 방식**|**점(.) 표기법**: `user.firstName`. 오타가 발생하면 컴파일 오류로 바로 알려줍니다.|**문자열 키**: `user["firstName"]`. 키를 잘못 입력해도 컴파일 오류가 발생하지 않습니다.|
|**구조**|**고정된 구조**: 선언 시 정의된 값들만 가질 수 있습니다. 추가하거나 뺄 수 없습니다.|**유연한 구조**: 키-값 쌍을 언제든지 추가하거나 삭제할 수 있습니다.|

Sheets로 내보내기

결론적으로, 튜플은 **정해진 수의 연관된 데이터를 함께 묶어 전달**할 때 딕셔너리보다 훨씬 더 안전하고 명확한 선택입니다.

## ## 튜플 활용을 위한 3가지 추가 팁

튜플을 더욱 효과적으로 사용하기 위한 세 가지 유용한 방법을 알아보세요.

### ### 1. 반환 값의 레이블 생략

함수의 반환 타입에 이미 튜플 각 항목의 이름(`firstName`, `lastName`)이 명시되어 있다면, `return` 구문에서는 이 이름을 생략하고 값만 순서대로 나열할 수 있습니다. Swift가 문맥을 파악하여 자동으로 이름을 매칭해 줍니다.

```Swift
func getUser() -> (firstName: String, lastName: String) {
    // 이름을 생략하고 값만 반환해도 동일하게 작동합니다.
    ("Taylor", "Swift")
}
```

### ### 2. 이름 없는 튜플과 숫자 인덱스 접근

튜플의 항목에 이름을 붙이지 않을 수도 있습니다. 이 경우, 배열처럼 **0부터 시작하는 숫자 인덱스**를 사용해 각 값에 접근할 수 있습니다.

```Swift
func getUser() -> (String, String) {
    ("Taylor", "Swift")
}

let user = getUser()
print("Name: \(user.0) \(user.1)") // user.firstName 대신 user.0 사용
```

> **참고**: 숫자 인덱스는 이름이 있는 튜플에서도 사용할 수 있습니다 (`user.0`는 `user.firstName`과 같습니다). 하지만 가독성을 위해 이름이 있다면 이름을 사용하는 것이 좋습니다.

### ### 3. 튜플 분해 (Decomposition)

함수가 반환한 튜플을 하나의 변수에 담은 뒤 각 값을 꺼내는 대신, 반환과 동시에 여러 개의 상수(또는 변수)로 나누어 담을 수 있습니다. 이를 **튜플 분해(Decomposition)**라고 합니다.

**기존 방식:**

```Swift
let user = getUser()
let firstName = user.firstName
let lastName = user.lastName
print("Name: \(firstName) \(lastName)")
```

**튜플 분해를 사용한 방식:**

```Swift
// getUser()가 반환한 튜플의 각 항목이 firstName과 lastName 상수로 바로 할당됩니다.
let (firstName, lastName) = getUser() 
print("Name: \(firstName) \(lastName)")
```

이 문법은 코드를 훨씬 간결하게 만들어주는 강력한 기능입니다.

만약 튜플의 일부 값만 필요하다면, **와일드카드 패턴**인 밑줄(`_`)을 사용하여 특정 값을 무시할 수 있습니다.

```Swift
// lastName 값은 필요 없으므로 _ 로 무시합니다.
let (firstName, _) = getUser()
print("Name: \(firstName)")
```

## ## 요약 및 정리

- **튜플**은 **고정된 개수**의 서로 연관된 값들을 그룹으로 묶는 데 사용됩니다.
- 함수에서 **여러 개의 값을 반환**할 때, 타입 안전성과 명확성을 보장하므로 배열이나 딕셔너리보다 훨씬 좋은 선택입니다.
- **이름 있는 튜플**은 `user.firstName`과 같이 **점 표기법**으로 값에 접근하여 코드의 가독성과 안전성을 높입니다.
- **튜플 분해(Decomposition)** `let (a, b) = ...`는 튜플의 값을 여러 변수/상수로 한 번에 나누어 담는 간결하고 효율적인 방법입니다.

## ## 연관 학습 내용: 더 깊이 알아보기

### ### 튜플(Tuple)과 구조체(Struct)의 차이점

튜플과 구조체는 여러 값을 하나로 묶는다는 점에서 비슷하지만, 사용 목적이 다릅니다.

- **튜플**: **일시적인 데이터 그룹**에 적합합니다. 함수의 반환 값처럼, 한 곳에서 생성되어 바로 분해되어 사용될 간단한 데이터 묶음에 이상적입니다.
- **구조체(Struct)**: **더 복잡하고 영구적인 데이터 모델**을 만들 때 사용합니다. 앱 전반에 걸쳐 재사용될 데이터 형식(예: `User`, `Product`)이라면 구조체를 정의하는 것이 좋습니다. 구조체는 메서드나 계산 프로퍼티 등을 추가하여 더 많은 기능을 가질 수 있습니다.

> **간단한 규칙**: "이 데이터 묶음을 다른 곳에서도 계속 사용할까?" 라는 질문에 "아니오"라면 튜플을, "예"라면 구조체를 사용하는 것을 고려해 보세요.

### ### 옵셔널 튜플 (Optional Tuples)

함수가 튜플 자체를 반환할 수도, 아예 아무것도 반환하지 않을 수도 있는 경우(예: 사용자를 찾지 못한 경우)가 있습니다. 이럴 때는 튜플 전체를 옵셔널로 만들 수 있습니다.

```Swift
func findUser(id: Int) -> (name: String, age: Int)? {
    if id == 1 {
        return ("김철수", 30)
    }
    return nil // 사용자를 찾지 못하면 nil 반환
}

if let user = findUser(id: 1) {
    print("찾은 사용자: \(user.name), \(user.age)세")
} else {
    print("사용자를 찾을 수 없습니다.")
}
```

### ### 튜플의 타입 별칭 (Type Alias)

복잡한 튜플을 여러 곳에서 반복적으로 사용해야 한다면, **타입 별칭(Type Alias)**을 사용해 가독성을 높일 수 있습니다.

```Swift
// HTTP 상태를 나타내는 튜플에 별칭 부여
typealias HTTPStatus = (code: Int, description: String)

func getStatus() -> HTTPStatus {
    // ... 네트워크 요청 로직 ...
    return (404, "Not Found")
}

let status: HTTPStatus = getStatus()
print("Status: \(status.code) - \(status.description)")
```


# 4.Swift 함수의 매개변수 레이블: 가독성을 높이는 기술

Swift는 함수를 호출할 때 각 매개변수가 어떤 역할을 하는지 명확하게 알 수 있도록 **매개변수 이름(레이블)**을 붙이는 것을 중요하게 생각합니다. 이 기능은 코드의 가독성을 극적으로 향상시키며, 다른 언어와 차별화되는 Swift의 강력한 특징 중 하나입니다.

## ## 매개변수 이름의 중요성

예를 들어, 특정 면 수를 가진 주사위를 여러 번 굴리는 함수를 작성한다고 가정해 봅시다.

```Swift
func rollDice(sides: Int, count: Int) -> [Int] {
    // 빈 배열로 시작
    var rolls = [Int]()

    // 필요한 횟수만큼 주사위 굴리기
    for _ in 1...count {
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }

    // 결과 배열 반환
    return rolls
}

let rolls = rollDice(sides: 6, count: 4)
```

`rollDice(sides: 6, count: 4)`라는 코드만 봐도 "6면체 주사위를 4번 굴린다"는 의미를 누구나 명확하게 이해할 수 있습니다. 6개월 뒤에 이 코드를 다시 보더라도 혼동할 여지가 거의 없습니다.

### ### 매개변수 레이블로 함수를 구별하기 (Function Overloading)

Swift는 이 외부 매개변수 레이블을 단순히 설명을 위한 용도를 넘어, **어떤 함수를 호출할지 결정하는 기준**으로 사용합니다. 따라서 함수 이름이 같더라도 매개변수 레이블이 다르면 완전히 다른 함수로 인식됩니다. 이를 **함수 오버로딩(Function Overloading)** 이라고 합니다.

```Swift
func hireEmployee(name: String) { /* ... */ }
func hireEmployee(title: String) { /* ... */ }
func hireEmployee(location: String) { /* ... */ }

// 호출 시점에 레이블로 구분하여 정확한 함수가 실행됨
hireEmployee(name: "John Doe")
hireEmployee(title: "Software Engineer")
```

> 공식 문서 등에서는 특정 함수를 지칭할 때 `hireEmployee(name:)` 또는 `hireEmployee(title:)`처럼 매개변수 레이블을 함께 표기하는 경우가 많습니다.

## ## 매개변수 레이블 사용자 정의하기

하지만 때로는 이 매개변수 레이블이 불필하거나, 함수 호출 부분을 더 자연스럽게 만들고 싶을 때가 있습니다. Swift는 이를 위해 두 가지 유용한 방법을 제공합니다.

### ### 1. 외부 매개변수 레이블 생략하기: `_` (언더스코어)

함수 이름만으로도 매개변수의 역할이 명확할 때, 레이블은 오히려 거추장스러울 수 있습니다. 예를 들어 문자열이 특정 문자로 시작하는지 확인하는 `hasPrefix()` 함수를 생각해 보세요.

```Swift
let lyric = "I see a red door and I want it painted black"
print(lyric.hasPrefix("I see"))
```

우리는 `hasPrefix(prefix: "I see")` 와 같이 레이블을 쓰지 않습니다. 그 이유는 `hasPrefix()` 함수가 외부 레이블을 **언더스코어(`_`)**로 지정했기 때문입니다. `_`는 Swift에서 "이 부분은 무시하라"는 의미로 사용되며, 함수 호출 시 해당 매개변수의 레이블을 생략하도록 만듭니다.

우리도 직접 만든 함수에 이 기법을 적용할 수 있습니다.

**기존 코드:**

```Swift
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
let string = "HELLO, WORLD"
let result = isUppercase(string: string) // string: string 중복이 어색하게 느껴질 수 있음
```

**`_`를 사용한 개선 코드:** 매개변수 이름 앞에 `_`를 추가하면 외부 레이블을 제거할 수 있습니다.

```Swift
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
let string = "HELLO, WORLD"
let result = isUppercase(string) // 훨씬 간결하고 자연스러움
```

이 방식은 배열에 요소를 추가하는 `append()`나, 특정 요소를 포함하는지 확인하는 `contains()` 등 Swift 표준 라이브러리 전반에 걸쳐 널리 사용됩니다.

### ### 2. 외부 레이블과 내부 이름 다르게 지정하기

외부 레이블을 사용하고 싶지만, 그 레이블이 함수 내부에서 변수명으로 사용하기에 적합하지 않은 경우가 있습니다. 예를 들어 구구단을 출력하는 함수를 생각해 봅시다.

```Swift
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)
```

코드는 문제없이 동작하지만, `printTimesTables(number: 5)` 라는 호출 구문은 다소 부자연스럽습니다. "5의 구구단을 출력해줘" 라는 자연스러운 문장처럼 `printTimesTables(for: 5)`로 만들 수 있다면 더 좋을 것입니다.

하지만 `for`는 Swift의 예약어(반복문)이므로 함수 내부에서 변수명으로 사용할 수 없습니다.

이 문제를 해결하기 위해 Swift는 **외부에서 사용할 이름**과 **내부에서 사용할 이름**을 모두 지정할 수 있도록 허용합니다.

```Swift
// 외부 레이블은 for, 내부에서 사용할 이름은 number
func printTimesTables(for number: Int) {
    for i in 1...12 {
        // 내부에서는 number를 사용
        print("\(i) x \(number) is \(i * number)")
    }
}

// 호출할 때는 외부 레이블인 for를 사용
printTimesTables(for: 5) 
```

세 가지 핵심 요소를 자세히 살펴보세요.

1. **`for number: Int`**: **외부 레이블**은 `for`이고, **내부 매개변수 이름**은 `number`이며, 타입은 `Int`입니다.
2. **함수 호출 시**: `printTimesTables(for: 5)`처럼 **외부 레이블**을 사용합니다.
3. **함수 내부에서**: `print("\(i) x \(number)...")`처럼 **내부 이름**을 사용합니다.

## ## 요약 및 정리

- **기본**: Swift는 기본적으로 함수 매개변수의 이름을 외부 레이블로 사용합니다. `func myFunc(name: String)`
- **레이블 생략**: 함수 호출 시 레이블을 없애고 싶다면, 매개변수 이름 앞에 `_`를 붙입니다.
    - `func myFunc(_ name: String)` → `myFunc("value")`
- **외부/내부 이름 분리**: 함수 호출 시의 가독성과 내부 로직의 편의성을 모두 잡고 싶다면, 외부 레이블과 내부 이름을 모두 지정합니다.
    - `func myFunc(for name: String)` → `myFunc(for: "value")` (내부에서는 `name` 사용)

> ### 용어 정리: Argument Label vs. Parameter Name
> 
> 엄밀히 말해, 함수를 **호출할 때** 전달하는 값의 레이블을 **인자 레이블(Argument Label)**, 함수 **내부에서** 사용하는 변수 이름을 **매개변수 이름(Parameter Name)**이라고 합니다. 하지만 종종 혼용되기도 합니다. 이 문서의 설명처럼 "외부 레이블"과 "내부 이름"으로 구분하여 이해하는 것이 가장 명확합니다.

## ## 연관 학습 내용: 더 깊이 알아보기

### ### 1. 매개변수 기본값 (Default Parameter Values)

매개변수에 기본값을 지정하면, 함수 호출 시 해당 인자를 생략할 수 있습니다. 생략된 경우 지정된 기본값이 사용됩니다.

```Swift
// count 매개변수에 기본값 1을 지정
func rollDice(sides: Int, count: Int = 1) -> [Int] {
    // ... 함수 본문은 동일 ...
}

// count를 생략하고 호출하면, count는 자동으로 1이 됨
let singleRoll = rollDice(sides: 6) 
// 물론 값을 직접 지정할 수도 있음
let fourRolls = rollDice(sides: 6, count: 4)
```

### ### 2. 가변 매개변수 (Variadic Parameters)

정해지지 않은 개수의 매개변수를 받고 싶을 때는 타입 뒤에 `...`을 붙여 **가변 매개변수**로 선언할 수 있습니다. 함수 내부에서는 이 값들을 배열처럼 사용할 수 있습니다.

```Swift
// numbers는 0개 이상의 Int 값을 받을 수 있는 가변 매개변수
func sum(of numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

sum(of: 1, 2, 3, 4, 5) // 결과: 15
sum(of: 10, 20)      // 결과: 30
```

### ### 3. 인-아웃 매개변수 (In-Out Parameters)

기본적으로 함수의 매개변수는 상수(let)로 취급되어 함수 내에서 수정할 수 없습니다. 만약 함수가 전달받은 변수의 값을 직접 수정하고, 그 변경사항이 함수 외부까지 영향을 미치게 하려면 **인-아웃 매개변수**를 사용해야 합니다.

```Swift
// number는 함수 안에서 값이 바뀌고, 그 결과가 함수 밖의 변수에도 반영됨
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNumber = 10
// 호출 시 변수 이름 앞에 &를 붙여야 함
doubleInPlace(number: &myNumber) 

print(myNumber) // 출력: 20
```

