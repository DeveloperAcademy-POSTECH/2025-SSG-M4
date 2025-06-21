# 1.Swift 함수(Functions) 심화 학습

제공된 내용은 함수의 기본적인 필요성과 정의, 매개변수(Parameter)와 인자(Argument)의 개념을 훌륭하게 설명하고 있습니다. 이 내용을 바탕으로 더 깊이 이해하고 활용할 수 있도록 다음 개념들을 추가로 학습해 보세요.

## 1. 함수(Functions)의 핵심 개념 복습 및 정리

> 제공된 내용을 바탕으로 핵심만 다시 정리한 부분입니다.

### 가. 왜 함수를 사용하는가? (The "Why")

- **재사용성 (Reusability):** 한번 작성한 코드를 여러 곳에서 이름만으로 호출하여 재사용할 수 있습니다.
- **모듈화 (Modularity):** 거대한 코드를 기능 단위로 작게 나누어 관리하기 용이합니다.
- **가독성 (Readability):** `showWelcome()`, `calculateResult()`처럼 함수의 이름만 봐도 어떤 작업을 하는지 쉽게 파악할 수 있습니다.
- **유지보수 (Maintainability):** 기능 수정이 필요할 때, 해당 함수 내부만 수정하면 되므로 전체 코드에 미치는 영향이 적고 관리가 편합니다.

### 나. 기본 구조

``` Swift
func 함수이름(매개변수이름: 타입, ...) {
    // 실행될 코드
}
```

- `func` 키워드로 함수 정의를 시작합니다.
- 함수이름과 `()`를 사용하며, 필요시 `()` 안에 매개변수를 선언합니다.
- `{}` 안에 실행할 코드를 작성합니다.

### 다. 매개변수(Parameter) vs 인자(Argument)

- **매개변수 (Parameter):** 함수를 정의할 때 사용하는 **자리표시자(Placeholder)**. `(number: Int)` 에서 `number`가 매개변수입니다.
- **인자 (Argument):** 함수를 호출할 때 전달하는 **실제 값(Actual Value)**. `printTimesTables(number: 5)` 에서 `5`가 인자입니다.

> 💡 **참고:** 설명해주신 내용처럼 많은 개발자들이 이 둘을 혼용하여 '파라미터'라고 부르는 경우가 많습니다. 'Parameter/Placeholder', 'Argument/Actual Value'로 기억하면 개념을 이해하는 데 도움이 됩니다.

---

## 2. 추가적인 핵심 개념 (Deeper Dive)

기본 개념에 더해, Swift 함수를 더욱 강력하게 만들어주는 추가적인 핵심 기능들입니다.

### 가. 값 반환하기 (Returning Values)

지금까지의 예시는 `print`문으로 어떤 동작을 수행만 할 뿐, 결과값을 되돌려주지 않았습니다. 함수가 계산한 결과를 **반환(return)**하여 다른 곳에서 활용하도록 만들 수 있습니다.

- **문법:** `->` 기호와 반환할 값의 타입을 명시합니다.
- **`return` 키워드:** 함수 내에서 값을 반환하고, 그 즉시 함수 실행을 종료합니다.

**예시 1: 두 정수를 더한 값을 반환하는 함수**

```Swift
func add(a: Int, b: Int) -> Int {
    let sum = a + b
    return sum
}

// 함수 호출 및 결과값 사용
let result = add(a: 5, b: 3) // result 에는 8이 저장됩니다.
print("5 + 3 = \(result)")
```

**예시 2: 숫자가 짝수인지 확인하여 Bool 값을 반환하는 함수**

```Swift
func isEven(number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

// 더 간결한 표현
func isEvenSimple(number: Int) -> Bool {
    return number.isMultiple(of: 2)
}


let numberToCheck = 10
if isEvenSimple(number: numberToCheck) {
    print("\(numberToCheck) is an even number.")
}
```

### 나. 매개변수 레이블 (Argument Labels and Parameter Names)

Swift 함수의 큰 특징 중 하나로, 함수를 호출할 때 사용하는 이름(레이블)과 함수 내부에서 사용하는 이름(매개변수 이름)을 다르게 지정할 수 있습니다.

- **목적:** 함수 호출부의 가독성을 높여 마치 문장을 읽는 것처럼 자연스럽게 만듭니다.
- **문법:** `func 함수이름(레이블 내부이름: 타입)`

**예시: 매개변수 레이블 사용하기**

```Swift
// 'to'는 레이블, 'person'은 내부에서 사용하는 매개변수 이름
func greet(to person: String) {
    print("Hello, \(person)!")
}

// 호출할 때는 레이블 'to'를 사용
greet(to: "Steve")
```

**레이블 생략하기 (`_`)** 레이블을 사용하고 싶지 않다면, `_` 를 사용합니다.

```Swift
func subtract(_ a: Int, from b: Int) -> Int {
    return b - a
}

// 첫 번째 레이블은 생략되어 더 자연스럽게 읽힘
let difference = subtract(5, from: 10) // 10 - 5
print(difference) // 5
```

### 다. 기본 매개변수 값 (Default Parameter Values)

매개변수에 기본값을 지정하여, 함수 호출 시 해당 인자를 생략할 수 있도록 만들 수 있습니다.

**예시: 구구단 예제에 기본값 적용** 기존 `printTimesTables` 함수는 항상 `end` 값을 받아야 했습니다. `end`의 기본값을 12로 설정해 보겠습니다.

```Swift
func printTimesTables(number: Int, end: Int = 12) {
    print("--- \(number) Times Table (up to \(end)) ---")
    for i in 1...end {
        print("\(i) x \(number) = \(i * number)")
    }
}

// 1. end 값을 생략 -> 기본값 12가 사용됨
printTimesTables(number: 7)

// 2. end 값을 직접 지정 -> 20이 사용됨
printTimesTables(number: 7, end: 20)
```

### 라. 가변 매개변수 (Variadic Parameters)

정해지지 않은 개수의 인자를 받아 처리하고 싶을 때 사용합니다. 타입 뒤에 `...`을 붙여 표현합니다.

- 함수 내부에서 가변 매개변수는 **배열(Array)** 로 취급됩니다.

**예시: 모든 숫자를 더하는 함수**

```Swift
func sum(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total
}

// 다양한 개수의 인자로 호출 가능
let sum1 = sum(numbers: 1.5, 2.5, 3.0) // 7.0
let sum2 = sum(numbers: 10.0, 20.0, 30.0, 40.0, 50.0) // 150.0
```

---

## 3. 연관 학습 내용 (Related Topics)

함수를 마스터했다면, 다음 개념들을 학습하여 Swift 프로그래밍 실력을 한 단계 더 높일 수 있습니다.

### 가. 클로저 (Closures)

- **개념:** 이름이 없는 코드 블록(함수)으로, 변수에 저장하거나 다른 함수의 인자로 전달할 수 있습니다. Swift에서 매우 중요하고 빈번하게 사용됩니다.
- **연관성:** 함수는 이름이 있는 클로저의 한 종류입니다. 클로저를 배우면 `map`, `filter`, `sorted` 와 같은 고차 함수(Higher-Order Functions)를 자유자재로 사용할 수 있게 됩니다.

**예시: `sorted` 함수에 클로저 사용**

```Swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reversedNames) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```

### 나. 에러 처리 (Error Handling)

- **개념:** 함수 실행 중 문제가 발생했을 때(예: 파일 읽기 실패, 네트워크 오류), 프로그램을 중단시키지 않고 오류가 발생했음을 알리고 적절히 대처하는 방법입니다.
- **연관성:** `throws` 키워드를 함수에 추가하여 "이 함수는 에러를 던질(throw) 수 있다"고 표시하고, `do-catch` 구문을 사용해 함수를 호출하고 에러를 처리합니다.

**개념 예시**

```Swift
enum MyError: Error {
    case someError
}

func functionThatCanThrow() throws {
    // ... 작업을 수행하다가
    throw MyError.someError // 에러 발생!
}

do {
    try functionThatCanThrow()
    print("Success!")
} catch {
    print("An error occurred: \(error)")
}
```

### 다. 스코프와 생명주기 (Scope & Lifecycle)

- **개념:** 변수나 상수가 코드 내에서 유효한 범위(스코프)와 언제 생성되고 소멸되는지(생명주기)를 의미합니다.
- **연관성:** 제공된 내용 마지막에 언급된 "함수 안에서 만든 데이터는 함수가 끝나면 자동으로 파괴된다"는 것이 바로 지역 스코프(Local Scope)의 개념입니다. 함수 스코프, 전역 스코프(Global Scope) 등의 차이를 이해하는 것은 버그 없는 코드를 작성하는 데 필수적입니다.


# 2.함수에서 값 반환하기 (Returning Values from Functions)

지금까지 함수를 만들고 매개변수(parameter)를 추가하는 방법을 배웠습니다. 이제 함수가 특정 연산을 수행한 후, 그 결과를 함수를 호출한 곳으로 **다시 돌려주는(반환하는)** 방법에 대해 알아보겠습니다.

## 1. 값을 반환하는 함수란?

함수는 단순히 어떤 동작을 수행하고 끝나기만 하는 것이 아니라, 계산된 결과물을 만들어 "보고"할 수 있습니다.

Swift에는 이미 수많은 내장 함수들이 있고, Apple의 프레임워크에는 훨씬 더 많습니다. 예를 들어, 우리가 항상 사용하는 `import Cocoa` 안에는 숫자의 제곱근을 계산하는 `sqrt()` 와 같은 다양한 수학 함수가 포함되어 있습니다.

`sqrt()` 함수는 제곱근을 계산하고 싶은 숫자 하나를 인자로 받아, 계산을 수행한 뒤 그 결과(제곱근)를 반환합니다.

```Swift
// 169의 제곱근을 계산하고, 그 결과를 root 상수에 저장합니다.
let root = sqrt(169)

// 반환된 값(13.0)을 출력합니다.
print(root)
```

## 2. 값 반환을 위한 핵심 문법

직접 만든 함수에서 값을 반환하려면 두 가지를 해야 합니다.

1. 함수의 여는 중괄호(`{`) 앞에 화살표(`->`)와 함께 **반환될 데이터의 타입**을 명시해야 합니다.
2. 함수 내에서 `return` 키워드를 사용하여 실제로 데이터를 반환해야 합니다.

### 예시 1: 주사위 굴리기

항상 6면체 주사위를 굴리는 것이 아니라, 프로그램의 여러 부분에서 주사위 굴리기 기능이 필요하다고 가정해 봅시다. 이 기능을 함수로 만들 수 있습니다.

``` Swift
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice() // rollDice()가 반환한 값을 result 상수에 저장
print(result)
```

- `-> Int` 부분은 "이 함수는 반드시 정수(Int)를 반환합니다"라는 약속입니다.
- `return Int.random(in: 1...6)` 부분은 실제로 1에서 6 사이의 랜덤 정수를 생성하여 반환하는 코드입니다.

이렇게 함수를 만들어두면, 나중에 20면체 주사위로 바꾸고 싶을 때 `rollDice` 함수 내부의 `1...6`을 `1...20`으로 단 한 번만 수정하면, 이 함수를 사용하는 모든 코드에 변경사항이 적용됩니다.

> 💡 **중요!** 함수가 `Int`를 반환한다고 약속했다면, Swift 컴파일러는 **반드시** `Int` 값이 반환되는지 확인합니다. 만약 값을 반환하는 것을 잊으면 코드가 컴파일되지 않아 실수를 방지할 수 있습니다.

### 예시 2: 두 문자열의 구성요소가 같은지 확인하기

순서에 상관없이 두 문자열이 동일한 문자로 구성되어 있는지 확인하는 함수를 만들어 봅시다. 예를 들어, "abc"와 "cab"는 순서는 다르지만 'a', 'b', 'c'를 하나씩 포함하고 있으므로 `true`를 반환해야 합니다.

문자열의 `sorted()` 메소드를 사용하면 문자를 알파벳순으로 정렬한 새로운 문자열(정확히는 문자의 배열)을 얻을 수 있습니다. 이 원리를 이용하면 문제를 쉽게 해결할 수 있습니다.


``` Swift 
func areLettersIdentical(string1: String, string2: String) -> Bool {
    // 각 문자열을 정렬하여 새로운 상수에 저장
    let first = string1.sorted()
    let second = string2.sorted()
    
    // 정렬된 두 결과를 비교하여 같으면 true, 다르면 false를 반환
    return first == second
}

print(areLettersIdentical(string1: "abc", string2: "cab")) // true
print(areLettersIdentical(string1: "hello", string2: "world")) // false
```

### 코드 축약과 암시적 반환 (Implicit Return)

위 코드는 임시 상수 `first`, `second`를 사용했지만, 그럴 필요 없이 `sorted()`의 결과를 직접 비교하여 코드를 더 줄일 수 있습니다.

``` Swift
func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}
```

여기서 한 걸음 더 나아갈 수 있습니다. 이 함수는 `Bool`을 반환하기로 약속했고, 함수 내부에 **코드가 단 한 줄**만 있습니다. Swift는 이 한 줄의 코드가 바로 반환될 값이라는 것을 알기 때문에, `return` 키워드를 생략할 수 있습니다. 이를 **암시적 반환(Implicit Return)** 이라고 합니다.

``` Swift
func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted()
}
```

``` Swift
// rollDice 함수도 마찬가지로 축약 가능합니다.
func rollDice() -> Int {
    Int.random(in: 1...6)
}
```

### 예시 3: 피타고라스의 정리

직각삼각형에서 빗변의 길이는 다른 두 변을 각각 제곱하여 더한 값의 제곱근과 같다는 피타고라스의 정리를 함수로 구현해 봅시다.

```Swift
// 두 개의 Double 값을 받아 Double 값을 반환하는 함수
func pythagoras(a: Double, b: Double) -> Double {
    let input = a * a + b * b
    let root = sqrt(input)
    return root
}

let c = pythagoras(a: 3, b: 4) // 3*3 + 4*4 = 9 + 16 = 25 -> sqrt(25) = 5.0
print(c) // 5.0
```

이 함수 역시 코드가 한 줄로 축약될 수 있으므로, `return`을 생략할 수 있습니다.

```Swift
func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}
```

## 3. 값을 반환하지 않는 함수에서 `return` 사용하기 (조기 종료)

만약 함수가 값을 반환하지 않더라도(`->` 선언이 없더라도), `return` 키워드를 단독으로 사용하여 **함수를 즉시 종료**시킬 수 있습니다. 입력값이 유효한지 먼저 확인하고, 유효하지 않으면 나머지 코드를 실행하지 않고 바로 함수를 빠져나오고 싶을 때 유용합니다.

``` Swift
func sayHello(to name: String) {
    // 이름이 비어있으면 인사하지 않고 함수를 바로 종료
    if name.isEmpty {
        print("Please provide a name.")
        return 
    }

    // 이름이 비어있지 않은 경우에만 아래 코드가 실행됨
    print("Hello, \(name)!")
}

sayHello(to: "Taylor") // "Hello, Taylor!"
sayHello(to: "")       // "Please provide a name."
```

## 4. 연관 학습 내용 (Related Topics)

함수의 값 반환을 이해했다면, 다음 개념들로 확장하여 더 유연하고 안전한 코드를 작성할 수 있습니다.

### 가. 여러 값 반환하기: 튜플 (Tuples)

함수는 오직 하나의 값만 반환할 수 있지만, 여러 값을 하나로 묶은 **튜플(Tuple)**을 사용하면 여러 값을 동시에 반환하는 것처럼 만들 수 있습니다.

``` Swift
func getUser() -> (firstName: String, lastName: String) {
    // 실제로는 데이터베이스나 네트워크에서 가져오는 로직이 들어감
    return (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)") // "Name: Taylor Swift"
```

### 나. 반환값이 없을 수도 있을 때: 옵셔널 (Optionals)

함수가 항상 유효한 값을 반환할 수 없는 경우가 있습니다. 예를 들어, 문자열 "123"은 정수로 변환 가능하지만, "abc"는 불가능합니다. 이럴 때 **옵셔널(Optional)**을 사용하여 "값을 반환할 수도 있고, 안 할 수도(nil) 있다"고 표현합니다. 반환 타입 뒤에 `?`를 붙입니다.

```Swift
func convertToInt(from string: String) -> Int? {
    return Int(string)
}

let number = convertToInt(from: "123") // Optional(123)
let notANumber = convertToInt(from: "abc") // nil

print(number)
print(notANumber)
```

### 다. 성공 또는 실패 상세히 반환하기: `Result` 타입

옵셔널보다 더 발전된 형태로, 함수가 성공했을 때의 값(`Success`)과 실패했을 때의 원인(`Failure`, 즉 에러)을 함께 담을 수 있는 타입입니다. 복잡한 에러 처리가 필요할 때 유용합니다.

```Swift
enum NameError: Error {
    case empty
    case tooShort
}

func validate(name: String) -> Result<String, NameError> {
    if name.isEmpty {
        return .failure(.empty)
    }
    if name.count < 2 {
        return .failure(.tooShort)
    }
    return .success("Name is valid")
}
```

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

