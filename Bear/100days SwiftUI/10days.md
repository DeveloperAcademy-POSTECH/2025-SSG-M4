## 🚀 Swift 조건문 (Conditional Statements) 심층 학습

제공해주신 내용을 바탕으로 Swift의 `if` 문과 조건부 로직에 대한 추가적인 개념, 구체적인 예시, 그리고 연관된 학습 내용을 명확하고 구분하기 쉽게 Obsidian 마크다운 형식으로 정리해 드리겠습니다.

---

### 1. `if` 문 기본 개념 복습 및 심화 🧐

프로그램은 종종 특정 **조건**에 따라 다른 동작을 수행해야 합니다. Swift에서는 `if` 문을 사용하여 이러한 조건부 로직을 구현합니다.

- **기본 구조**:
    
    ```Swift
    if 조건식 {
        // 조건식이 참(true)일 경우 실행될 코드
    }
    ```
    
- **구성 요소**:
    
    - `if`: 조건문의 시작을 알립니다.
    - `조건식 (someCondition)`: **Boolean (`true` 또는 `false`)** 값으로 평가되는 표현식입니다.
    - `{ }` (중괄호, Braces): 조건이 참일 때 실행될 코드 블록을 감쌉니다.
- **비교 연산자 (Comparison Operators)**: 조건식에서 자주 사용됩니다.
    
    | 연산자 | 의미 | 예시 (`a = 5`, `b = 10`) | | :----- | :----------------------- | :----------------------- | | `>` | 크다 (Greater than) | `b > a` (true) | | `<` | 작다 (Less than) | `a < b` (true) | | `>=` | 크거나 같다 (Greater than or equal to) | `a >= 5` (true) | | `<=` | 작거나 같다 (Less than or equal to) | `b <= 10` (true) | | `==` | 같다 (Equal to) | `a == 5` (true) | | `!=` | 같지 않다 (Not equal to) | `a != b` (true) |
    
- **문자열 비교**: 숫자뿐만 아니라 문자열도 비교 연산자를 사용하여 알파벳 순서(사전식 순서)를 비교할 수 있습니다.
    
    ```Swift
    let name1 = "Alice"
    let name2 = "Bob"
    if name1 < name2 { // "Alice"가 "Bob"보다 알파벳 순서상 앞서므로 true
        print("\(name1) comes before \(name2)")
    }
    ```
    
- **`isEmpty` 프로퍼티**: 문자열, 배열, 딕셔너리, 세트 등이 비어있는지 확인할 때 유용하며, `count == 0`보다 효율적일 수 있습니다 (특히 문자열의 경우). `isEmpty`는 Boolean 값을 직접 반환하므로 `if someCollection.isEmpty == true` 대신 `if someCollection.isEmpty`로 사용하는 것이 더 간결합니다.
    
    ```Swift
    var myString = ""
    if myString.isEmpty { // myString.isEmpty 자체가 true 또는 false를 반환
        print("String is empty.")
    }
    
    var list: [Int] = []
    if list.isEmpty {
        print("Array is empty.")
    }
    ```
    

---

### 2. `if` 문의 확장: `else` 와 `else if` 🌟

단순히 조건이 참일 때만 코드를 실행하는 것 외에, 조건이 거짓일 경우 또는 여러 조건을 순차적으로 검사해야 할 때 `else`와 `else if`를 사용합니다.

#### 가. `else` 절

- `if` 문의 조건식이 **거짓(false)**일 경우 실행될 코드 블록을 정의합니다.
    
    ```Swift
    let temperature = 25
    if temperature > 30 {
        print("It's a hot day!")
    } else {
        print("It's not a hot day.") // 이 코드가 실행됨
    }
    ```
    

#### 나. `else if` 절

- 첫 번째 `if` 문의 조건이 거짓일 경우, **또 다른 조건을 검사**하고 싶을 때 사용합니다. 여러 개의 `else if`를 연속적으로 사용할 수 있습니다.
    
    ```Swift
    let score = 75
    if score >= 90 {
        print("Grade: A")
    } else if score >= 80 {
        print("Grade: B")
    } else if score >= 70 {
        print("Grade: C") // 이 코드가 실행됨
    } else {
        print("Grade: D or F")
    }
    ```
    
    - **주의**: `if`, `else if`, `else` 구조에서는 위에서부터 순서대로 조건을 확인하며, **하나의 조건이라도 참이 되어 해당 코드 블록이 실행되면 나머지 `else if`나 `else` 블록은 실행되지 않습니다.**

---

### 3. 논리 연산자 (Logical Operators) 🔗

복잡한 조건을 만들기 위해 여러 개의 Boolean 표현식을 결합할 때 사용합니다.

|연산자|이름|의미|예시|
|:--|:--|:--|:--|
|`&&`|AND|양쪽 조건이 모두 참(true)일 때만 참|`age >= 18 && hasLicense == true`|
|`|`|OR|양쪽 조건 중 하나라도 참(true)이면 참|
|`!`|NOT|Boolean 값의 결과를 반전 (true -> false, false -> true)|`!userIsBlocked` (userIsBlocked가 false면 true)|

Sheets로 내보내기

- **예시**:
    
    ```Swift
    let age = 20
    let hasDrivingLicense = true
    let isWeekend = false
    
    // AND 연산자
    if age >= 18 && hasDrivingLicense {
        print("You can drive a car.")
    } else {
        print("You cannot drive a car yet or don't have a license.")
    }
    
    // OR 연산자
    if age < 18 || isWeekend {
        print("You might get a student discount or it's the weekend!")
    }
    
    // NOT 연산자
    var isLoggedIn = false
    if !isLoggedIn { // isLoggedIn이 false이므로 !isLoggedIn은 true
        print("Please log in.")
    }
    
    // isEmpty와 NOT 연산자 조합
    let name = "Jane"
    if !name.isEmpty { // 이름이 비어있지 않다면
        print("Hello, \(name)!")
    }
    ```
    

---

### 4. 삼항 조건 연산자 (Ternary Conditional Operator) ❓:

간단한 `if-else` 문을 한 줄로 축약해서 표현할 수 있는 방법입니다.

- **구조**: `조건 ? 값_A : 값_B`
    
    - `조건`이 참이면 `값_A`가 사용되고, 거짓이면 `값_B`가 사용됩니다.
- **예시**:
    
    ```Swift
    let currentHour = 14
    let greeting = currentHour < 12 ? "Good morning!" : "Good afternoon!"
    print(greeting) // 출력: Good afternoon!
    
    let a = 5
    let b = 10
    let maxVal = a > b ? a : b
    print("Maximum value is \(maxVal)") // 출력: Maximum value is 10
    ```
    
    - 가독성을 위해 복잡한 로직보다는 단순한 값 할당에 사용하는 것이 좋습니다.

---

### 5. `switch` 문 (Switch Statements) 🔀

특정 값이나 표현식의 다양한 가능한 경우(case)에 따라 다른 코드를 실행하고 싶을 때 `if-else if` 체인보다 더 명확하고 강력한 대안이 될 수 있습니다. (특히 열거형(Enum)과 함께 사용할 때 유용합니다.)

- **기본 구조**:
    
    ```Swift
    switch 검사할_값 {
    case 값1:
        // 값1일 때 실행될 코드
    case 값2, 값3: // 여러 값을 한 case에서 처리 가능
        // 값2 또는 값3일 때 실행될 코드
    where 조건: // 추가적인 where 절로 조건 명시 가능
        // 값에 해당하고 where 조건도 만족할 때
    default:
        // 위의 어떤 case에도 해당하지 않을 때 실행될 코드
    }
    ```
    
- Swift의 `switch` 문은 각 `case` 블록의 끝에 자동으로 `break`가 있는 것처럼 동작합니다 (C나 Java와 다름). 따라서 명시적으로 `break`를 쓸 필요가 없습니다.
    
- 모든 가능한 경우를 다루어야 하며(exhaustiveness), 그렇지 않으면 `default` 케이스가 필수입니다.
    
- **예시**:
    
    ```Swift
    let httpStatusCode = 200
    
    switch httpStatusCode {
    case 200:
        print("OK")
    case 400:
        print("Bad Request")
    case 404:
        print("Not Found")
    case 500:
        print("Internal Server Error")
    default:
        print("Unknown status code: \(httpStatusCode)")
    }
    // 출력: OK
    
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    var naturalCount: String
    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5: // 범위(Range) 사용 가능
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")
    // 출력: There are dozens of moons orbiting Saturn.
    ```
    

---

### 6. 연관 학습 내용 📚

조건문은 프로그래밍의 핵심 제어 흐름 도구입니다. 다음 개념들과 함께 학습하면 시너지를 낼 수 있습니다.

1. **반복문 (Loops: `for-in`, `while`, `repeat-while`)**:
    
    - 조건에 따라 코드 블록을 반복적으로 실행합니다. `while` 루프는 그 자체로 조건식을 포함합니다.
2. **`guard` 문**:
    
    - 특정 조건이 반드시 참이어야 다음 코드를 실행할 수 있도록 하는 데 사용됩니다. 조건이 거짓이면 현재 스코프(함수, 메서드 등)를 즉시 빠져나갑니다. `if`문과 반대로 "빠른 탈출(early exit)"을 위한 가독성 높은 방법입니다.
3. **옵셔널 (Optionals)과 조건부 바인딩 (`if let`, `guard let`)**:
    
    - 옵셔널 변수가 값을 가지고 있는지(nil이 아닌지) 안전하게 확인하고, 값이 있다면 임시 상수에 할당하여 사용하는 패턴입니다.
        
        ```Swift
        var optionalName: String? = "John Doe"
        // var optionalName: String? = nil // 이 경우 else 블록 실행
        
        if let name = optionalName {
            print("Hello, \(name)") // optionalName이 nil이 아닐 때 실행
        } else {
            print("No name provided.")
        }
        ```
        
4. **오류 처리 (Error Handling: `do-catch`, `try?`, `try!`)**:
    
    - 오류가 발생할 수 있는 코드(throwing functions)를 호출하고, 발생한 오류에 따라 조건적으로 다른 처리를 할 수 있습니다.
5. **함수 (Functions)**:
    
    - 함수 내에서 조건문을 사용하여 입력값이나 내부 상태에 따라 다른 결과를 반환하거나 다른 동작을 수행하도록 로직을 구성합니다.


---

## 🚀 Swift 조건문 심층 탐구: `if`, `else if`, `else` 및 논리 연산자

제공해주신 내용을 통해 Swift의 `if`, `else if`, `else` 구조와 논리 연산자 `&&`(AND) 및 `||`(OR)의 기본을 잘 이해하셨습니다. 여기에 몇 가지 추가 개념과 심화 내용을 더해드리겠습니다.

---

### 1. 핵심 개념 복습 및 심화 🧐

- **`if`, `else if`, `else`**: 조건에 따라 코드 실행 흐름을 분기합니다. `if`는 기본 조건을, `else if`는 이전 조건이 거짓일 경우 추가 조건을, `else`는 모든 선행 조건이 거짓일 경우 실행될 코드를 정의합니다.
- **논리 연산자**:
    - `&&` (AND): **양쪽 조건이 모두 참**이어야 전체 조건이 참입니다.
    - `||` (OR): **양쪽 조건 중 하나라도 참**이면 전체 조건이 참입니다.
- **열거형(Enum)과 조건문**: 열거형의 특정 케이스에 따라 다른 로직을 실행할 때 `if` 문을 사용할 수 있으며, 이때 타입 추론을 활용해 `.caseName` 형태로 간결하게 표현 가능합니다.

Swift

```
enum WeatherCondition {
    case sunny, cloudy, rainy, snowy
}

let currentWeather = WeatherCondition.rainy
let temperature = 5 // Celsius

if currentWeather == .rainy && temperature < 10 {
    print("It's cold and rainy. Bring an umbrella and a warm jacket!")
} else if currentWeather == .sunny && temperature > 25 {
    print("It's hot and sunny! Don't forget sunscreen.")
} else {
    print("Check the weather forecast for details.")
}
```

---

### 2. 추가 핵심 개념 🌟

#### 가. 논리 연산자의 단축 평가 (Short-circuit Evaluation) ⚡

논리 연산자 `&&`와 `||`는 **단축 평가**를 수행합니다. 이는 전체 조건의 참/거짓이 결정되는 즉시 평가를 중단하여 불필요한 연산을 줄이는 효율적인 방식입니다.

- **`&&` (AND)**: 왼쪽 조건이 `false`이면, 오른쪽 조건은 평가하지 않고 전체 결과를 `false`로 확정합니다. (어차피 둘 다 참이어야 하므로)
    
- **`||` (OR)**: 왼쪽 조건이 `true`이면, 오른쪽 조건은 평가하지 않고 전체 결과를 `true`로 확정합니다. (어차피 하나만 참이면 되므로)
    
- **예시**:
    
    Swift
    
    ```
    func isUserLoggedIn() -> Bool {
        print("Checking login status...")
        return false // 실제로는 로그인 상태를 반환
    }
    
    func hasAdminPrivileges() -> Bool {
        print("Checking admin privileges...") // 이 함수는 호출되지 않음
        return true
    }
    
    // && 단축 평가
    if isUserLoggedIn() && hasAdminPrivileges() {
        print("Admin access granted.")
    } else {
        print("Access denied or not logged in.")
    }
    // 출력:
    // Checking login status...
    // Access denied or not logged in.
    
    func isDataAvailable() -> Bool {
        print("Checking data availability...")
        return true
    }
    
    func needsFurtherProcessing() -> Bool {
        print("Checking if further processing is needed...") // 이 함수는 호출되지 않음
        return false
    }
    
    // || 단축 평가
    if isDataAvailable() || needsFurtherProcessing() {
        print("Data is available or no further processing needed initially.")
    }
    // 출력:
    // Checking data availability...
    // Data is available or no further processing needed initially.
    ```
    
    단축 평가는 특히 오른쪽 조건이 비용이 많이 드는 연산(예: 복잡한 계산, 네트워크 요청)일 때 성능 향상에 기여합니다.
    

#### 나. 논리 부정 연산자 `!` (NOT)

Boolean 값의 참/거짓을 반전시킵니다.

- **예시**:
    
    Swift
    
    ```
    let isAuthenticated = false
    if !isAuthenticated { // isAuthenticated가 false이므로 !isAuthenticated는 true
        print("User is not authenticated. Please log in.")
    }
    
    let itemsInCart = 0
    // if !(itemsInCart > 0) 와 동일
    if itemsInCart <= 0 {
        print("Your cart is empty.")
    }
    ```
    

#### 다. 복잡한 조건과 괄호 `()` 사용

여러 논리 연산자를 함께 사용할 때, 괄호를 사용하여 **평가 순서를 명확히** 하거나 **의도한 대로 우선순위를 지정**할 수 있습니다. 일반적으로 AND(`&&`)가 OR(`||`)보다 우선순위가 높지만, 가독성을 위해 괄호를 사용하는 것이 좋습니다.

- **예시**:
    
    Swift
    
    ```
    let userAge = 25
    let isPremiumMember = true
    let hasDiscountCoupon = false
    
    // (나이가 18세 이상이고 프리미엄 회원이거나) 또는 할인 쿠폰이 있는 경우
    if (userAge >= 18 && isPremiumMember) || hasDiscountCoupon {
        print("Special offer applicable!")
    } else {
        print("No special offer at this moment.")
    }
    
    // 괄호 없이: userAge >= 18 && (isPremiumMember || hasDiscountCoupon) 와 다르게 해석될 수 있음
    // (실제로는 &&가 ||보다 우선순위가 높아 위와 동일하게 동작하지만, 괄호로 명확히 하는 것이 좋음)
    ```
    

#### 라. 중첩된 `if` 문 (Nested `if` Statements)

`if` 문 내부에 또 다른 `if` 문을 사용하여 더 세분화된 조건을 처리할 수 있습니다. 하지만 너무 깊게 중첩되면 코드 가독성이 떨어질 수 있으므로 주의해야 합니다.

- **예시**:
    
    Swift
    
    ```
    let fileExists = true
    let userHasPermission = false
    let isNetworkDrive = true
    
    if fileExists {
        print("File found.")
        if userHasPermission {
            print("Opening file...")
        } else {
            print("Permission denied to open the file.")
            if isNetworkDrive {
                print("Try checking network drive permissions.")
            }
        }
    } else {
        print("File not found.")
    }
    ```
    
    이런 경우 `guard` 문이나 함수 분리 등을 통해 가독성을 높일 수 있습니다.

#### 마. 열거형(Enum)과 `switch` 문 (대안)

제공된 예시처럼 열거형의 여러 케이스를 `if-else if-else`로 처리할 수도 있지만, `switch` 문을 사용하면 더 깔끔하고 Swift의 열거형 처리 기능을 최대한 활용할 수 있습니다 (특히 모든 케이스를 다루는지 컴파일러가 확인해주는 장점).

- **제공된 예시의 `switch` 문 변환**:
    
    Swift
    
    ```
    enum TransportOption {
        case airplane, helicopter, bicycle, car, scooter
    }
    
    let transport = TransportOption.airplane
    
    switch transport {
    case .airplane, .helicopter: // 여러 케이스를 콤마로 연결
        print("Let's fly!")
    case .bicycle:
        print("I hope there's a bike path…")
    case .car:
        print("Time to get stuck in traffic.")
    case .scooter: // else에 해당했던 케이스
        print("I'm going to hire a scooter now!")
    // TransportOption의 모든 케이스가 다뤄졌으므로 default가 필수는 아님
    }
    ```
    

---

### 3. 구체적인 예시 🛠️

#### 가. 할인 조건 예시 (복합 조건)

학생이거나, 65세 이상이거나, 평일 오전 10시 이전에 방문하면 할인 적용.

Swift

```
let isStudent = false
let age = 70
let currentHour = 9
let isWeekday = true

if isStudent || age >= 65 || (isWeekday && currentHour < 10) {
    print("할인 적용 대상입니다.")
} else {
    print("정상가입니다.")
}
// 출력: 할인 적용 대상입니다. (age >= 65 조건 만족)
```

#### 나. 로그인 시도 횟수 제한

Swift

```
var loginAttempts = 0
let maxLoginAttempts = 3
var accountLocked = false

func attemptLogin(success: Bool) {
    if accountLocked {
        print("계정이 잠겼습니다. 관리자에게 문의하세요.")
        return
    }

    if success {
        print("로그인 성공!")
        loginAttempts = 0 // 시도 횟수 초기화
    } else {
        loginAttempts += 1
        print("로그인 실패. 남은 시도 횟수: \(maxLoginAttempts - loginAttempts)")
        if loginAttempts >= maxLoginAttempts {
            accountLocked = true
            print("로그인 시도 횟수 초과. 계정이 잠깁니다.")
        }
    }
}

attemptLogin(success: false)
attemptLogin(success: false)
attemptLogin(success: true) // 성공 시 시도 횟수 초기화
attemptLogin(success: false)
attemptLogin(success: false)
attemptLogin(success: false) // 계정 잠김
attemptLogin(success: true)  // 잠긴 계정으로 로그인 시도
```

---

### 4. 연관 학습 내용 📚

조건문은 다른 제어 흐름 및 프로그래밍 구조와 밀접하게 연관됩니다.

1. **`guard` 문**:
    
    - `if`와 반대로, 특정 조건이 `false`일 경우 현재 스코프를 빠르게 빠져나가도록(early exit) 강제합니다. 코드를 더 읽기 쉽게 만들고, 유효한 조건이 계속 이어지는 주 경로를 명확하게 드러내는 데 유용합니다.
2. **옵셔널 체이닝 (Optional Chaining) 및 nil 병합 연산자 (`??`)**:
    
    - 옵셔널 값을 다룰 때 `if let` 외에도 이러한 도구들을 사용하여 조건부 로직을 간결하게 표현할 수 있습니다.
3. **오류 처리 (`do-try-catch`)**:
    
    - 오류 발생 가능성이 있는 코드를 실행하고, 발생한 특정 오류 유형에 따라 조건적으로 다른 복구 로직을 수행할 수 있습니다.
4. **알고리즘 설계 및 문제 해결**:
    
    - 대부분의 알고리즘은 특정 조건에 따라 다른 경로를 선택하는 논리적 흐름에 기반합니다. 조건문은 이러한 로직을 구현하는 핵심 도구입니다.
5. **유닛 테스트 (Unit Testing)**:
    
    - 작성한 코드의 다양한 조건부 경로(branches)가 의도한 대로 동작하는지 확인하기 위해 유닛 테스트를 작성하는 것이 중요합니다. 각 `if`, `else if`, `else` 블록이 실행되는 시나리오를 테스트해야 합니다.

## 🚀 Swift `switch` 문 심층 탐구: 강력한 조건 분기 마스터하기

제공해주신 설명을 통해 Swift의 `switch` 문이 `if-else if` 체인보다 어떻게 더 효율적이고 안전하게 조건을 처리하는지, 특히 열거형(enum)과 함께 사용할 때의 장점, 그리고 `default` 케이스와 `fallthrough` 키워드의 기본적인 사용법을 이해하셨습니다. 이제 `switch` 문의 더욱 강력하고 다양한 기능들을 살펴보겠습니다.

---

### 1. `switch` 문 핵심 개념 복습 및 심화 🧐

- **기본 목적**: 특정 값(변수 또는 상수)을 여러 가능한 경우(case)와 비교하여 일치하는 코드 블록을 실행합니다.
- **열거형(Enum)과의 시너지**: 열거형의 모든 케이스를 검사하도록 컴파일러가 강제하여 실수를 줄입니다.
- **명시적 `break` 불필요**: 각 `case` 블록이 끝나면 자동으로 `switch` 문을 빠져나갑니다 (다른 언어들과의 차이점).
- **완전성 (Exhaustiveness)**: `switch` 문은 검사하는 값의 모든 가능한 경우를 반드시 다루어야 합니다.
    - 열거형의 경우 모든 케이스가 포함되어야 합니다.
    - `String`, `Int` 등 무한한 경우의 수를 가진 타입은 `default` 케이스가 필수입니다.
- **`default` 케이스**: 다른 어떤 `case`와도 일치하지 않을 때 실행되는 코드 블록입니다. 항상 마지막에 위치할 필요는 없지만, `default`가 다른 `case`보다 먼저 나오면 그 뒤의 `case`들은 평가될 기회가 없어 컴파일 오류가 발생합니다.
- **`fallthrough`**: 특정 `case`의 코드를 실행한 후, **의도적으로** 다음 `case`의 코드 블록까지 실행시키고 싶을 때 사용합니다. (매우 드물게 사용됨)

```Swift
enumORITY {
    case low, medium, high, critical
}

let currentPriority = Priority.high

switch currentPriority {
case .low:
    print("Handling low priority task.")
case .medium:
    print("Handling medium priority task.")
case .high:
    print("Handling HIGH priority task.") // 이 코드가 실행됨
    // 여기서 자동으로 switch 문 종료
case .critical:
    print("ALERT! Handling CRITICAL priority task.")
// 모든 enum 케이스가 다뤄졌으므로 default 불필요
}
```

---

### 2. `switch` 문의 추가 핵심 기능 🌟

#### 가. 값 바인딩 (Value Binding)

`case` 문 내에서 `switch` 문의 대상이 되는 값의 일부 또는 전체를 임시 상수나 변수로 추출(바인딩)하여 사용할 수 있습니다. `let` 또는 `var` 키워드를 사용합니다.

- **튜플(Tuple) 값 바인딩**:
    
    ```Swift
    let point = (1, 1)
    switch point {
    case (0, 0):
        print("Origin")
    case (_, 0): // x는 어떤 값이든 상관없고, y는 0
        print("On the x-axis")
    case (0, let y): // x는 0이고, y 값을 바인딩
        print("On the y-axis at y = \(y)")
    case (let x, let y) where x == y: // x와 y 값을 바인딩하고 where 절로 추가 조건
        print("On the line x == y at (\(x), \(y))")
    case (let x, let y): // 나머지 모든 튜플 값을 바인딩 (default 역할도 가능)
        print("Somewhere else at (\(x), \(y))")
    }
    // 출력: On the line x == y at (1, 1)
    ```
    
- **열거형(Enum) 연관 값(Associated Value) 바인딩**:
    
    ```Swift
    enum Barcode {
        case upc(Int, Int, Int, Int)
        case qrCode(String)
    }
    
    let productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")
    // let productBarcode = Barcode.upc(8, 85909, 51226, 3)
    
    switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode): // 연관 값을 productCode 상수로 바인딩
        print("QR code: \(productCode).") // 이 코드가 실행됨
    }
    // 출력: QR code: ABCDEFGHIJKLMNOP
    ```
    

#### 나. `where` 절 (Where Clauses)

`case` 패턴에 추가적인 조건을 부여하고 싶을 때 `where` 절을 사용합니다. `where` 절의 조건이 `true`일 때만 해당 `case`가 일치하는 것으로 간주됩니다.

- **예시**:
    
    ```Swift
    let age = 25
    let isStudent = true
    
    switch (age, isStudent) {
    case (let age, true) where age < 18:
        print("Student under 18")
    case (let age, _) where age >= 18 && age <= 65:
        print("Adult (18-65)")
    case (_, true): // 나이와 상관없이 학생인 경우 (위의 학생 조건에서 걸리지 않았다면)
        print("Student (18 or older, or over 65)")
    default:
        print("Other")
    }
    // 출력: Adult (18-65) (age=25, isStudent=true 지만, (let age, _) where age >=18.. 이 먼저 매치)
    // 순서가 중요! 만약 case (_, true) 가 더 위에 있었다면 그곳에 매치되었을 것.
    ```
    
    
    ```Swift
    let number = 7
    switch number {
    case let x where x % 2 == 0:
        print("\(x) is even.")
    case let x where x % 2 != 0:
        print("\(x) is odd.") // 이 코드가 실행됨
    default:
        break // 아무 작업도 하지 않음
    }
    // 출력: 7 is odd.
    ```
    

#### 다. 복합 케이스 (Compound Cases)

쉼표(`,`)로 구분하여 여러 패턴을 하나의 `case` 블록에서 처리할 수 있습니다. 단, 값 바인딩을 사용하는 경우 모든 복합 케이스 패턴이 동일한 이름과 타입의 값 바인딩을 정의해야 합니다.

- **예시**:
    
    ```Swift
    let character: Character = "e"
    switch character {
    case "a", "e", "i", "o", "u": // 여러 모음들을 한 번에 처리
        print("\(character) is a vowel.")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
         "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(character) is a consonant.")
    default:
        print("\(character) is not a vowel or consonant.")
    }
    // 출력: e is a vowel.
    ```
    
    ```Swift
    enum Movement { case forward(Int), backward(Int), left, right }
    let move = Movement.forward(10)
    
    switch move {
    case .forward(let amount), .backward(let amount): // amount 바인딩
        print("Moving by \(amount)")
    case .left, .right:
        print("Turning")
    }
    // 출력: Moving by 10
    ```
    

#### 라. 범위 매칭 (Interval Matching / Range Matching)

숫자 타입에 대해 특정 범위를 `case`로 사용할 수 있습니다.

- **예시**:
    
    ```Swift
    let score = 88
    var grade: String
    
    switch score {
    case 90...100:
        grade = "A"
    case 80..<90: // 80 이상 90 미만
        grade = "B" // 이 코드가 실행됨
    case 70..<80:
        grade = "C"
    case 60..<70:
        grade = "D"
    default: // 0..<60 또는 100 초과 등
        grade = "F"
    }
    print("Grade: \(grade)") // 출력: Grade: B
    ```
    

#### 마. `@unknown default`

외부 라이브러리나 프레임워크에서 가져온 열거형(enum)을 `switch` 할 때 사용합니다. 만약 해당 열거형이 미래에 새로운 케이스를 추가하더라도, `@unknown default`는 컴파일러 경고를 통해 개발자에게 새로운 케이스를 처리하도록 알려줍니다. 일반 `default`는 이러한 경고를 주지 않습니다.

- **특징**:
    
    - `switch` 문이 완전해야 한다는 규칙을 만족시킵니다.
    - 향후 열거형에 추가될 수 있는 알려지지 않은 케이스를 처리합니다.
    - 새로운 케이스가 추가되면 컴파일 시점에 경고가 발생하여 코드를 업데이트하도록 유도합니다.
- **예시**:
    
    ```Swift
    // 외부 라이브러리의 enum이라고 가정
    // @frozen public enum LibraryAPIResponse {
    //    case success
    //    case failure
    //    case pending
    //    // 미래에 .rateLimited 케이스가 추가될 수 있음
    // }
    
    // 예시를 위해 직접 정의
    @frozen enum LibraryAPIResponse {
       case success
       case failure
       case pending
       // case rateLimited // 이 케이스가 나중에 추가되었다고 가정
    }
    
    let response = LibraryAPIResponse.pending // 또는 나중에 추가될 .rateLimited
    
    switch response {
    case .success:
        print("API call successful!")
    case .failure:
        print("API call failed.")
    case .pending:
        print("API call is pending.")
    // 만약 LibraryAPIResponse에 rateLimited가 추가되고 이 case가 없다면
    // @unknown default가 경고를 발생시킴
    @unknown default:
        print("An unknown API response was received. Please update the app or check API documentation.")
        // 여기서 fallthrough를 사용하면 안 됨
    }
    ```
    
    `@frozen` 어트리뷰트가 붙은 열거형은 라이브러리 작성자가 향후 케이스를 추가하지 않겠다고 명시하는 것이므로 `@unknown default` 대신 일반 `default`를 사용해도 경고가 발생하지 않습니다. 하지만 라이브러리가 `@frozen`으로 표시하지 않은 열거형에 대해서는 `@unknown default`를 사용하는 것이 안전합니다.
    

---

### 3. `fallthrough` 심화 및 주의사항 ⚠️

제공된 "The Twelve Days of Christmas" 예시는 `fallthrough`의 동작을 잘 보여줍니다. 하지만 `fallthrough`는 다음과 같은 이유로 매우 신중하게 사용해야 합니다.

- **가독성 저하**: 코드의 흐름을 예측하기 어렵게 만들 수 있습니다. 대부분의 경우, `fallthrough` 없이 로직을 구성하는 것이 더 명확합니다.
- **오류 유발 가능성**: 의도치 않은 동작을 초래할 수 있습니다. C 스타일 언어에서 `break`를 빠뜨려 발생하는 오류와 유사한 상황을 만들 수 있습니다.
- **대안 고려**: `fallthrough`를 사용하고 싶다면, 해당 로직을 여러 함수로 분리하거나, `case` 블록 내에서 공통 코드를 호출하는 방식으로 재구성하는 것이 더 나은 경우가 많습니다.

`fallthrough`는 다음 `case`의 조건 검사를 건너뛰고 **무조건적으로** 다음 `case` 블록의 코드를 실행합니다. 값 바인딩이나 `where` 절이 있는 `case`로 `fallthrough`할 수는 없습니다.

---

### 4. 연관 학습 내용 📚

`switch` 문은 Swift의 강력한 **패턴 매칭(Pattern Matching)** 시스템의 일부입니다. 다음 개념들을 함께 학습하면 더욱 깊이 있는 이해가 가능합니다.

1. **패턴 매칭의 다른 형태**:
    
    - **`if case let` / `if case where`**: `switch` 문처럼 복잡한 패턴 매칭을 단일 `if` 조건문에서 사용할 수 있게 합니다.
    - **`for case let` / `for case where`**: 컬렉션을 순회하면서 특정 패턴에 맞는 요소만 처리할 때 사용합니다.
    - **옵셔널 패턴 (`x?`)**: 옵셔널 값을 매칭할 때 사용합니다.
    - **타입 캐스팅 패턴 (`is Type`, `as Type`)**: `switch`나 `if case`에서 타입을 확인하거나 캐스팅할 때 사용합니다.
2. **열거형(Enum) 심층 활용**:
    
    - 특히 연관 값(associated values)을 가진 열거형을 다룰 때 `switch`는 필수적입니다.
    - 재귀 열거형(recursive enums)을 처리할 때도 `switch`를 사용합니다.
3. **튜플(Tuple) 활용**:
    
    - 여러 값을 그룹화하여 `switch`의 대상으로 사용하고, 다양한 조합을 `case`로 표현할 수 있습니다.
4. **오류 처리 (`Error` 프로토콜)**:
    
    - `catch` 블록에서 발생한 오류의 특정 타입이나 조건을 `switch`와 유사한 패턴 매칭으로 구분하여 처리할 수 있습니다.
5. **표현식 패턴 (Expression Pattern `~=`)**:
    
    - `switch` 문의 `case`에서 내부적으로 사용되는 연산자입니다. 사용자 정의 타입이 `switch` 문에서 특정 방식으로 매칭되도록 `~=` 연산자를 직접 구현할 수도 있습니다 (고급 주제).

## 🚀 Swift 삼항 조건 연산자 (Ternary Conditional Operator) 심층 학습

제공해주신 내용을 통해 Swift의 삼항 조건 연산자 (`?:`)의 기본 구조, 사용법, 그리고 `if-else`와의 유사성 및 SwiftUI에서의 중요성에 대해 잘 이해하셨습니다. "WTF" (What, True, False) 니모닉도 매우 유용합니다! 이제 몇 가지 추가적인 개념과 심화 내용을 더해 삼항 연산자에 대한 이해를 완성해 보겠습니다.

---

### 1. 삼항 조건 연산자 핵심 개념 복습 및 심화 🧐

- **정의**: 세 개의 피연산자를 가지는 유일한 Swift 연산자입니다.
- **구조**: `조건 ? 참일_때의_값 : 거짓일_때의_값`
- **기능**: 조건을 평가하여 `참`이면 첫 번째 값을 반환하고, `거짓`이면 두 번째 값을 반환합니다.
- **`if-else` 와의 관계**: 간결한 `if-else` 문의 표현식(expression) 형태라고 볼 수 있습니다.
- **SwiftUI에서의 중요성**: 특정 SwiftUI 코드 블록(예: ViewBuilder) 내에서는 문(statement) 형태의 `if-else` 대신 표현식(expression) 형태의 삼항 연산자를 사용해야 하는 경우가 많습니다.

```Swift
let temperature = 30
let advice = temperature > 25 ? "It's hot, stay hydrated!" : "Enjoy the mild weather."
print(advice) // 출력: It's hot, stay hydrated!
```

---

### 2. 삼항 연산자의 추가 핵심 기능 및 고려 사항 🌟

#### 가. 반환 값의 타입 호환성 (Type Compatibility)

삼항 연산자에서 `참일_때의_값`과 `거짓일_때의_값`은 **서로 호환되는 타입이거나, Swift가 추론할 수 있는 공통된 슈퍼타입**을 가져야 합니다. 전체 삼항 연산자 표현식은 단일 타입을 반환하기 때문입니다.

- **예시**:
    
    ```Swift
    let useDouble = true
    let number = useDouble ? 10.5 : 5 // 결과 타입은 Double로 추론됨 (5는 5.0으로 변환)
    print(number) // 출력: 10.5 또는 5.0
    
    // let mixedResult = useDouble ? "Hello" : 5 // 오류: String과 Int는 직접 호환되지 않음
    // 위와 같은 경우 Any 타입으로 명시하거나, 두 값을 동일한 타입으로 변환해야 합니다.
    let mixedResult: Any = useDouble ? "Hello" : 5
    print(mixedResult)
    
    // 옵셔널 타입 예시
    let defaultName: String? = "Guest"
    let specificName: String? = "Alice"
    let currentName = specificName != nil ? specificName! : defaultName // 두 표현식 모두 String? 또는 String
    print(currentName ?? "N/A")
    ```
    
    Swift는 가능한 가장 구체적인 공통 타입을 찾으려고 합니다. 두 값이 완전히 다른 타입이고 공통 슈퍼타입으로 추론되지 않으면 컴파일 오류가 발생합니다.

#### 나. 가독성 (Readability)

삼항 연산자는 코드를 매우 간결하게 만들 수 있지만, 남용하거나 조건 또는 반환 값이 너무 복잡해지면 오히려 가독성을 해칠 수 있습니다.

- **좋은 사용 예 (간단한 조건 및 할당)**:
    
    ```Swift
    let isLoggedIn = true
    let statusMessage = isLoggedIn ? "Logged In" : "Logged Out"
    ```
    
- **가독성이 떨어질 수 있는 예 (복잡한 조건)**:
    
    ```Swift
    let score = 85
    let attendance = 90
    // 조건이 길어지면 가독성이 떨어짐
    let grade = score > 80 && attendance > 85 ? "Pass" : "Fail"
    print(grade)
    
    // 이 경우 if-else가 더 명확할 수 있음
    // if score > 80 && attendance > 85 {
    //     grade = "Pass"
    // } else {
    //     grade = "Fail"
    // }
    ```
    
    일반적으로 조건이 간단하고, 참/거짓일 때 반환되는 값이 단순할 때 사용하는 것이 좋습니다.
    

#### 다. 중첩된 삼항 연산자 (Nested Ternary Operators)

삼항 연산자 내부에 또 다른 삼항 연산자를 사용하는 것이 기술적으로는 가능하지만, **가독성을 심각하게 저해하므로 강력히 권장되지 않습니다.**

- **예시 (권장하지 않음)**:
    
    ```Swift
    let a = 5
    let b = 10
    let result = a > b ? "a is greater" : (b > 0 ? "b is positive" : "b is not positive")
    print(result) // 출력: b is positive
    
    // 위 코드는 다음과 같이 if-else if-else로 작성하는 것이 훨씬 명확합니다.
    // if a > b {
    //     print("a is greater")
    // } else if b > 0 {
    //     print("b is positive")
    // } else {
    //     print("b is not positive")
    // }
    ```
    

#### 라. 표현식(Expression)으로서의 본질

삼항 연산자는 값을 반환하는 **표현식**입니다. 이는 `if-else`가 그 자체로는 값을 반환하지 않는 **문(statement)**인 것과 대조됩니다. (물론 `if-else` 블록 내에서 값을 할당하거나 `return` 할 수 있습니다.) 이러한 표현식의 특성 때문에 SwiftUI의 ViewBuilder와 같이 표현식이 요구되는 곳에서 유용하게 사용됩니다.

- **제공된 예시의 핵심**:
    
    ```Swift
    // print(if hour < 12 { "It's before noon" } else { "It's after noon" }) // 오류: if-else는 표현식이 아님
    
    // 삼항 연산자는 표현식이므로 print 함수의 인자로 직접 사용 가능
    print(hour < 12 ? "It's before noon" : "It's after noon")
    ```
    

---

### 3. 구체적인 사용 예시 🛠️

#### 가. 옵셔널 값 처리와 기본값 제공 (nil 병합 연산자와 유사)

```Swift
var optionalValue: Int? = nil
let valueToUse = optionalValue != nil ? optionalValue! : 0 // optionalValue가 nil이면 0 사용
print("Value to use: \(valueToUse)") // 출력: Value to use: 0

optionalValue = 100
let anotherValueToUse = optionalValue != nil ? optionalValue! : 0
print("Another value to use: \(anotherValueToUse)") // 출력: Another value to use: 100

// 참고: 이 경우는 nil 병합 연산자 `??`를 사용하는 것이 더 간결하고 안전합니다.
// let valueToUseWithNilCoalescing = optionalValue ?? 0
```

#### 나. 함수 반환 값 결정

```Swift
func getGreeting(for time: Int) -> String {
    return time < 12 ? "Good morning!" : "Good afternoon/evening!"
}
print(getGreeting(for: 10)) // 출력: Good morning!
print(getGreeting(for: 17)) // 출력: Good afternoon/evening!
```

#### 다. 계산된 프로퍼티(Computed Property) 값 설정

```Swift
struct User {
    var score: Int
    var hasPassed: Bool {
        return score >= 60 ? true : false
        // 더 간결하게: return score >= 60
    }
}
let student1 = User(score: 75)
print("Student 1 passed: \(student1.hasPassed)") // 출력: Student 1 passed: true

let student2 = User(score: 50)
print("Student 2 passed: \(student2.hasPassed)") // 출력: Student 2 passed: false
```

#### 라. SwiftUI View 내에서의 조건부 텍스트 색상 (개념적 예시)

실제 SwiftUI 코드는 아니지만, 개념적으로 왜 필요한지 보여줍니다.

```Swift
// (개념적 코드 - 실제 SwiftUI와는 다름)
// struct MyView {
//     var isError: Bool
//     func body() -> TextElement {
//         return TextElement("Status Message",
//                            color: isError ? "Red" : "Green") // 여기서 삼항 연산자 사용
//     }
// }
```

SwiftUI에서는 View를 구성하는 코드 블록 내에서 `if-else` 문을 직접 사용하여 View의 속성을 동적으로 변경하기 어렵거나 코드가 복잡해질 수 있습니다. 이때 삼항 연산자를 사용하면 간결하게 표현식으로 처리할 수 있습니다.

---

### 4. 연관 학습 내용 📚

삼항 조건 연산자를 이해했다면 다음 개념들을 학습하여 Swift 프로그래밍 능력을 더욱 향상시킬 수 있습니다.

1. **표현식(Expressions) vs. 문(Statements)**:
    
    - Swift에서 어떤 것이 값을 생성하는 표현식이고, 어떤 것이 작업을 수행하는 문인지 구분하는 것은 중요합니다. 삼항 연산자는 표현식의 좋은 예입니다.
2. **SwiftUI (Swift User Interface)**:
    
    - 제공된 내용에서 강조된 것처럼, SwiftUI는 선언적 구문을 사용하며, View를 구성할 때 삼항 연산자와 같은 표현식 기반의 조건부 로직이 자주 활용됩니다. `if` 문도 ViewBuilder 내에서 조건부로 View를 포함하거나 제외하는 데 사용될 수 있지만, 속성 값 자체를 조건부로 변경할 때는 삼항 연산자가 유용합니다.
3. **Nil 병합 연산자 (`??` - Nil-Coalescing Operator)**:
    
    - 옵셔널 값이 `nil`일 경우 기본값을 제공하는 간결한 방법을 제공합니다. `optionalValue != nil ? optionalValue! : defaultValue`와 유사한 기능을 더 안전하고 짧게 표현합니다: `optionalValue ?? defaultValue`.
4. **단축 평가 (Short-circuit Evaluation)**:
    
    - 삼항 연산자의 조건 부분 다음에는 `참일_때의_값` 또는 `거짓일_때의_값` 중 하나만 평가됩니다. 이는 논리 연산자 `&&`, `||`의 단축 평가와 유사한 개념입니다.
5. **고차 함수 (Higher-Order Functions)와 클로저(Closures)**:
    
    - 데이터를 변환하거나 필터링할 때 클로저 내에서 간결한 조건부 로직을 위해 삼항 연산자가 사용될 수 있습니다.