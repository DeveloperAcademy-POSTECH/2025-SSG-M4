
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