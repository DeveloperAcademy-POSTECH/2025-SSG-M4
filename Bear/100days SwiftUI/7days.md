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

